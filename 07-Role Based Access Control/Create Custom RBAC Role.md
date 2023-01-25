# Create Custom RBAC Role

In the next exercise we will focus on Role-based Access Control (RBAC).

## Before you begin

1. Create a folder on C: named RBAC: Example: C:\RBAC

2. Download the following file and save it in C:\RBAC.
[VirtualMachineRestart.json](https://raw.githubusercontent.com/RichShillingtonMSFT/Azure-Stack-Hub-Operator-Labs-ADFS/main/07-Role%20Based%20Access%20Control/VirtualMachineRestart.json)

## Create the Custome RBAC Role.

1. Open the **Azure Stack User Portal**


2. Click on All Services, Subscriptions then click on the Development Subscription.


3. Click Access Control (IAM), then Roles. Notice the built-in roles currently available.

![](images/Picture1.png)


4. Click Add, then Add Custom Role.

![](images/Picture2.png)

![](images/Picture3.png)

5. Select Start from JSON then click on the file browser icon.

![](images/Picture4.png)


6. Browse to **C:\LabFiles\07-Role Based Access Control **and select** VirtualMachineRestart.json**, then click **Open**.

![](images/Picture5.png)

7. Click Next.

![](images/Picture6.png)


8. Review the permissions imported from the JSON file, then click Next.

![](images/Picture7.png)

9. Click Add assignable scopes.

![](images/Picture8.png)


10. Select your Development Subscription, then click Add.

![](images/Picture9.png)

![](images/Picture10.png)

11. Click **Review + Create** , then **Create**.

![](images/Picture11.png)

![](images/Picture12.png)


12. Click Ok on the success popup.

![](images/Picture13.png)


13. You can now see and assign the custom role you created.

![](images/Picture14.png)