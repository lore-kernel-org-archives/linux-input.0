From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 4/4] Input: synaptics-rmi4 - add SMBus support
Date: Thu, 23 Jun 2016 16:06:35 -0700
Message-ID: <20160623230635.GS32561@dtor-ws>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-5-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465484030-28838-5-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Thu, Jun 09, 2016 at 04:53:50PM +0200, Benjamin Tissoires wrote:
> +
> +struct mapping_table_entry {
> +	u16 rmiaddr;

Should be __le16 rmiaddr, otherwise:

  CHECK   drivers/input/rmi4/rmi_smbus.c
drivers/input/rmi4/rmi_smbus.c:116:33: warning: incorrect type in assignment (different base types)
drivers/input/rmi4/rmi_smbus.c:116:33:    expected unsigned short [unsigned] [usertype] rmiaddr
drivers/input/rmi4/rmi_smbus.c:116:33:    got restricted __le16 [usertype] <noident>

> +
> +static struct i2c_driver rmi_smb_driver;
> +

I do not think this forward declaration is needed.

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rmi_smb_suspend(struct device *dev)

__maybe_unused instead of #ifdef.

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = rmi_driver_suspend(rmi_smb->xport.rmi_dev);
> +	if (ret)
> +		dev_warn(dev, "Failed to suspend device: %d\n", ret);
> +
> +	return ret;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM
> +static int rmi_smb_runtime_suspend(struct device *dev)

Same here?

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = rmi_driver_suspend(rmi_smb->xport.rmi_dev);
> +	if (ret)
> +		dev_warn(dev, "Failed to suspend device: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int rmi_smb_runtime_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = rmi_driver_resume(rmi_smb->xport.rmi_dev);
> +	if (ret)
> +		dev_warn(dev, "Failed to resume device: %d\n", ret);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops rmi_smb_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(rmi_smb_suspend, NULL)
> +	SET_RUNTIME_PM_OPS(rmi_smb_runtime_suspend, rmi_smb_runtime_resume,
> +			   NULL)
> +};
> +
> +static int rmi_smb_resume(struct device *dev)
> +{
> +	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
> +	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
> +	struct rmi_device *rmi_dev = rmi_smb->xport.rmi_dev;
> +	int ret;
> +
> +	rmi_smb_reset(&rmi_smb->xport, 0);
> +
> +	rmi_reset(rmi_dev);
> +
> +	ret = rmi_driver_resume(rmi_smb->xport.rmi_dev);
> +	if (ret)
> +		dev_warn(dev, "Failed to resume device: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rmi_id[] = {
> +	{ "rmi4_smbus", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rmi_id);
> +
> +static struct i2c_driver rmi_smb_driver = {
> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= "rmi4_smbus",
> +		.pm	= &rmi_smb_pm,
> +		.resume	= rmi_smb_resume,

Why rmi_smb_resume is not part of rmi_smb_pm?

Thanks.

-- 
Dmitry
