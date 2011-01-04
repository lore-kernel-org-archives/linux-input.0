From: Hong Liu <hong.liu@intel.com>
Subject: Re: [v3 2/3] 2/3 i2c: Cypress TTSP G3 MTDEV I2C Device Driver
Date: Tue, 04 Jan 2011 09:45:56 +0800
Message-ID: <1294105556.2570.14.camel@hongdev>
References: <Kevin McNeely <kev@cypress.com>
	 <1293650268-1561-2-git-send-email-kev@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62996 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab1ADBnh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Jan 2011 20:43:37 -0500
In-Reply-To: <1293650268-1561-2-git-send-email-kev@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <kev@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Henrik Rydberg <rydberg@euromail.se>, Alan Cox <alan@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2010-12-30 at 03:17 +0800, Kevin McNeely wrote:
[...]
> +
> +/* registered in driver struct */
> +static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
> +{
> +	struct cyttsp_i2c *ts;
> +
> +	ts = i2c_get_clientdata(client);
> +	cyttsp_core_release(ts->ttsp_client);
> +	kfree(ts);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int cyttsp_i2c_suspend(struct i2c_client *client, pm_message_t message)
> +{
> +	return cyttsp_suspend(dev_get_drvdata(&client->dev));
> +}
> +
> +static int cyttsp_i2c_resume(struct i2c_client *client)
> +{
> +	return cyttsp_resume(dev_get_drvdata(&client->dev));
> +}
> +#endif

I think what we get here is a pointer to cyttsp_i2c, and we need to pass
cyttsp_i2c->ttsp_client to cyttsp_suspend/resume.

Thanks,
Hong

> +
> +static const struct i2c_device_id cyttsp_i2c_id[] = {
> +	{ CY_I2C_NAME, 0 },  { }
> +};
> +
> +static struct i2c_driver cyttsp_i2c_driver = {
> +	.driver = {
> +		.name = CY_I2C_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = cyttsp_i2c_probe,
> +	.remove = __devexit_p(cyttsp_i2c_remove),
> +	.id_table = cyttsp_i2c_id,
> +#ifdef CONFIG_PM
> +	.suspend = cyttsp_i2c_suspend,
> +	.resume = cyttsp_i2c_resume,
> +#endif
> +};
> +
> +static int __init cyttsp_i2c_init(void)
> +{
> +	return i2c_add_driver(&cyttsp_i2c_driver);
> +}
> +
> +static void __exit cyttsp_i2c_exit(void)
> +{
> +	return i2c_del_driver(&cyttsp_i2c_driver);
> +}
> +
> +module_init(cyttsp_i2c_init);
> +module_exit(cyttsp_i2c_exit);
> +
> +MODULE_ALIAS("i2c:cyttsp");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
> +MODULE_AUTHOR("Cypress");
> +MODULE_DEVICE_TABLE(i2c, cyttsp_i2c_id);


