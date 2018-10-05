/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sgc.data;

import com.sgc.model.Classification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Anushanth
 */
public class SubClassificationDao {

    Connection connection;
    PreparedStatement statement;
    final String scid ="SCID";
    final String mcName = "MCName";
    final String scName = "SCName";
    final String mcid = "MCID";
    
    public void insertSub(Classification sub) {

        try {
            connection = DatabaseConnect.getConnection();
            String insertSubSql = "INSERT INTO sub (SCID,SCName,MCID) VALUES (?,?,?)";
            statement = connection.prepareStatement(insertSubSql);
            statement.setString(1, sub.getSubId());
            statement.setString(2, sub.getSubClass());
            statement.setString(3, sub.getMainId());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
    }

    public List<Classification> searchSub(String txtSearchSub) {
        List<Classification> result = new ArrayList<>();
        try {
            connection = DatabaseConnect.getConnection();
            String searchSubSql = "SELECT * FROM sub s INNER JOIN main m ON s.MCID = m.MCID WHERE s.MCID LIKE ? OR SCName LIKE ? OR MCName LIKE ?";

            statement = connection.prepareStatement(searchSubSql);
            statement.setString(1, txtSearchSub + "%");
            statement.setString(2, txtSearchSub + "%");
            statement.setString(3, txtSearchSub + "%");

            ResultSet rsSearchSub = statement.executeQuery();

            while (rsSearchSub.next()) {
                Classification sub = new Classification();
                sub.setSubId(rsSearchSub.getString(scid));
                sub.setMainClass(rsSearchSub.getString(mcName));
                sub.setSubClass(rsSearchSub.getString(scName));
                result.add(sub);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
        return result;
    }

    public List<Classification> viewSub() {
        List<Classification> result = new ArrayList<>();
        try {
            connection = DatabaseConnect.getConnection();
            String getSubClassSql = "SELECT * FROM sub s INNER JOIN main m ON s.MCID=m.MCID";

            statement = connection.prepareStatement(getSubClassSql);
            ResultSet rsViewSub = statement.executeQuery();

            while (rsViewSub.next()) {
                Classification sub = new Classification();
                sub.setSubId(rsViewSub.getString(scid));
                sub.setSubClass(rsViewSub.getString(scName));
                sub.setMainClass(rsViewSub.getString(mcName));
                result.add(sub);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
        return result;
    }

    public String getSubId() {
        String subId = null;
        try {
            connection = DatabaseConnect.getConnection();
            String getSubIdSQL = "SELECT SCID FROM sub ORDER BY SCID";
            
            statement = connection.prepareStatement(getSubIdSQL);
            ResultSet rsGetSubID = statement.executeQuery();

            while (rsGetSubID.next()) {
                subId = rsGetSubID.getString(scid);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
        return subId;
    }

    public void deleteSub(String id) {

        try {
            connection = DatabaseConnect.getConnection();
            String deleteSubSql = "DELETE FROM sub WHERE SCID = ?";
            statement = connection.prepareStatement(deleteSubSql);
            statement.setString(1,id);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
    }

    public int countMain(String mcid) {
        int count = 0;
        try {
            connection = DatabaseConnect.getConnection();
            String countMainSql = "SELECT * FROM sub WHERE MCID = ?";
            statement = connection.prepareStatement(countMainSql);
            statement.setString(1, mcid);
            ResultSet rsCountMain = statement.executeQuery();
            while (rsCountMain.next()) {
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
        return count;
    }

    public Classification populateSub(String subId) {
        Classification sub = new Classification();
        try {
            connection = DatabaseConnect.getConnection();
            String popSubSql = "SELECT * FROM sub WHERE SCID = ?";
            statement = connection.prepareStatement(popSubSql);
            statement.setString(1, subId);
            ResultSet rsPopSub = statement.executeQuery();

            while (rsPopSub.next()) {
                sub.setSubId(rsPopSub.getString(scid));
                sub.setMainId(rsPopSub.getString(mcid));
                sub.setSubClass(rsPopSub.getString(scName));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
        return sub;
    }

    public void updateSub(Classification sub) {

        try {
            connection = DatabaseConnect.getConnection();
            String updateSubSql = "UPDATE sub SET SCName = ? , MCID = ? WHERE SCID = ?";
            statement = connection.prepareStatement(updateSubSql);
            statement.setString(1, sub.getSubClass());
            statement.setString(2, sub.getMainId());
            statement.setString(3, sub.getSubId());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubClassificationDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DatabaseConnect.disconnect();
        }
    }
}
