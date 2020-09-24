package com.oultoncollege.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * User.java
 *  Model for a User's data.
 * 
 * @author bcopeland
 */
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private int userID;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String phoneExt;
    private int accountTypeID;

    
    public User() {
        // TODO Auto-generated constructor stub - required for JPA mappings
    }
    
    public User(int userID, String email, String password, String firstName, String lastName, String phoneNumber, String phoneExt, int accountTypeID) {
        setUserID(userID);
        setEmail(email);
        setPassword(password);
        setFirstName(firstName);
        setLastName(lastName);
        setPhoneNumber(phoneNumber);
        setPhoneExt(phoneExt);
        setAccountTypeID(accountTypeID);
    }

    
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneExt() {
        return phoneExt;
    }

    public void setPhoneExt(String phoneExt) {
        this.phoneExt = phoneExt;
    }

    public int getAccountTypeID() {
        return accountTypeID;
    }

    public void setAccountTypeID(int accountTypeID) {
        this.accountTypeID = accountTypeID;
    }

}
