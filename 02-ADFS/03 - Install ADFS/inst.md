# Install ADFS.

To Integrate Azure Stack Hub internal ADFS with your Active Directory you will need to install ADFS and prepare it to work with Azure Stack Hub.

## **Add ADFS Roles & Features**

A Windows Server has been deployed for you to use for the ADFS Role. The server's name is ADFS-01 with an IP address of 10.100.100.11.

1. From your **ASDK** , connect to **ADFS-01** using **RDP** with its IP address **10.100.100.11**.


2. Click the **Start button** and click on **Server manager**.

 ![](images/image1.png)


1. When Server Manager has finished loading, click on **Add roles and features**.

 ![](RackMultipart20230124-1-bkc7oq_html_49711a5db6863979.png)

4. On the Before you begin page, click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_87da0a314e096018.png)

5. On the Select Installation type page, ensure the **Role-based or feature-based installation** is selected, then click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_a52b62a6d11ffed0.png)

6. On the Select destination server page, ensure that **ADFS-01** is selected and click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_d94ba567f675eb07.png)

7. On the Select server roles page, **select Active Directory Federation Services** and click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_cfa25c9723d268b4.png)

8. On the Select features page, click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_8cc8ac040bbe019f.png)

9. On the Active Directory Federation Services page, click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_ed1f15ea819baa90.png)

10. On the Confirm installation selections page, **click on Restart the destination server if required** , click **Yes on the popup confirmation** box, then click **Install**.

 ![](RackMultipart20230124-1-bkc7oq_html_cc7843202b6bc7ab.png)

11. When the Install is complete if the server did not restart automatically, **restart the server before proceeding**.









# **Active Directory Federation Services Configuration**

Now that ADFS has been installed, we need to configure the ADFS Role.

1. When the server has restarted, log back in and open Server Manager. When Server Manager finishes loading, click on the **exclamation point** in the upper right, then click on the **Configure the federation service link.**
 ![](RackMultipart20230124-1-bkc7oq_html_76fe8099c19d490.png)


2. On the Welcome page, ensure the **Create the first federation server in a federation server farm** is selected and click **Next**.


 ![](RackMultipart20230124-1-bkc7oq_html_692fa55040f573e3.png)

3. On the Connect to Active Directory Domain Service page, click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_2a89a28fcc776027.png)

4. On Specify Service Properties page, click the drop down to **select the adfs.contoso.local SSL certificate**. Enter **adfs.contoso.local for the Federation Service Name** and enter a **Federation Service display name like Contoso Corp**. Click **Next**.
 ![](RackMultipart20230124-1-bkc7oq_html_2444609c9b580c91.png)

5. On the Specify Service Account page, click **Select** to search for the ADFS Service account.

 ![](RackMultipart20230124-1-bkc7oq_html_137d8159a242c82f.png)

6. When the User search box appears, type **FsGmsa** in the object name box, click **Check Names** , then click **Ok**.

 ![](RackMultipart20230124-1-bkc7oq_html_9f967cc3200e4fb3.png)

7. Back on Specify Service Account screen, click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_b223221333b2722e.png)

8. On the Specify Configuration Database page, ensure **Create a database on this server using Windows Internal Database** is selected, then click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_beebbdf7aaab16c5.png)

9. On the Review Options screen, verify you have everything configured properly, then click **Next**.

 ![](RackMultipart20230124-1-bkc7oq_html_3d842ba48ea8be4f.png)


10. When the Pre-requisites checks are complete, click **Configure**.

 ![](RackMultipart20230124-1-bkc7oq_html_68ce9b8c1acf03eb.png)

11. Once the install is complete, click Close.

 ![](RackMultipart20230124-1-bkc7oq_html_e7fb8e2366a46448.png)