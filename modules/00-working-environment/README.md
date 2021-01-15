# Prepare a Linux workspace for EKS

Working with containers and Kubernetes requires you to install a handful of tools
to your machine. To make it easier for you to cleanup after the workshop, you might
want to do the workshop on a different machine than your computer or laptop.

Here, we provide a few options on creating a remote dev environment on AWS,
so you keep installations on your local machine to a minimum:

**Choose one option:**
- [Create a dev environment on AWS Cloud9](#using-aws-cloud9)
- `TODO`

---

## Using AWS Cloud9

[AWS Cloud9][cloud9] is a cloud IDE for writing, running, and debugging code.
We can create a dev environment, then work in it completely from within our browser,
very similarly to how you use your preferred IDE.

### Create a Cloud9 environment

1. Go to your [AWS Cloud9 Console][cloud9-console].
2. Confirm that you're in the right AWS region.
   You should be able to select which region you want to work in on the top-right
   of your screen.

   **If you're not sure which region you should be in**, ask your workshop moderator.

3. Click the `Create environment` button.
4. Give your environment a name and an optional description, then click `Next step`.
5. Confirm the following options:
   - Environment type: **Create a new EC2 instance**
   - Instance type: **Other instance type: `t3.large`**
   - Platform: **Amazon Linux 2**
   - Cost-saving setting: **After four hours**

   Then click `Next step`.
6. Confirm your settings in the next step, then click `Create environment` 
   to create your Cloud9 instance.

### Customize your environment 

Once the Cloud9 instance becomes available, feel free to customize it as you like.
We suggest you do the following too:

- Close the Welcome screen
- Close the lower work area (by clicking the `𝖷` on the top-right of the lower panel)
- Open a new terminal on the main work area (by clicking `＋` on the main panel, 
  and selecting `New Terminal`)

### Install required tools

Just to make things easier during the workshop, we can give our Cloud9 dev environment
admin powers. 

> :warning::warning::warning:<br/>
> **Always be very, very careful with giving anything admin permissions**.<br/>
> Don't give anything more permissions than it requires to function.<br/> 
> :warning::warning::warning:

1. Open your Settings (by clicking the ⚙ icon on the top-right of the screen).
2. Navigate to `AWS Settings` on the left sidebar, then **disable** 
   `AWS managed temporary credentials`.
3. Open a terminal (if you don't have one open yet), and paste in your credentials
   from Event Engine. This gives your terminal temporary credentials.

   ```bash
   # :: example
   export AWS_DEFAULT_REGION=ap-southeast-1
   export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXX
   export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   export AWS_SESSION_TOKEN=<a very long string>
   ```

4. Run the following in your terminal:

   > **IMPORTANT:**<br/>
   > Do **not** directly pipe arbitrary scripts in the wild to `bash` like this.<br/>
   > (i.e. don't just do `curl some-script.sh | bash` willy-nilly). 
   > This is very dangerous. Make sure you trust 
   > the script and where the script is coming from.
   > 
   > We're just doing this to save a lot of time for the workshop.
   > If you want to inspect what the script does, it's found right here:
   > https://gist.github.com/richardneililagan/b527511214496d4bb701b088ffd89ce3

   ```bash
   curl --silent https://gist.githubusercontent.com/richardneililagan/b527511214496d4bb701b088ffd89ce3/raw/prep-cloud9-eksworkshop.sh | bash
   ```

5. Just to make sure the credentials are completely set, close your current terminal
   and open a new one. :)

---


[cloud9]: https://aws.amazon.com/cloud9
[cloud9-console]: https://console.aws.amazon.com/cloud9
