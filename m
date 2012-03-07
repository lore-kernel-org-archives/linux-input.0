From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v4] Touchscreen driver for FT5x06 based EDT displays
Date: Wed, 07 Mar 2012 15:50:44 +0100
Message-ID: <4F5775C4.5070401@kernelconcepts.de>
References: <1326413588-30517-1-git-send-email-simon.budig@kernelconcepts.de>	<1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de>	<1331050527-4902-2-git-send-email-simon.budig@kernelconcepts.de> <20120307143652.3f7335f8@wker>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060806050604060304060308"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:43200 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab2CGOus (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 09:50:48 -0500
In-Reply-To: <20120307143652.3f7335f8@wker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, yanok@emcraft.com, b.van.den.berg.nl@gmail.com

This is a multi-part message in MIME format.
--------------060806050604060304060308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/07/2012 02:36 PM, Anatolij Gustschin wrote:
>> +	if (tsdata->reset_pin >= 0) {
>> +		error = gpio_request(tsdata->reset_pin, NULL);
> 
> It would be helpful to have labels for requested gpio pins. Can you pass
> "ft5x06 reset" instead of NULL here?

[x] done. I actually use "edt-ft5x06", since the ft5x06 on the edt
devices has an EDT specific custom firmware, making it unlikely that it
will work on other ft5x06 based devices.

> Please drop this 'error = -ENOMEM;'. We should return
> error code returned by gpio_request() here.

[x] done.

> gpio pin label, too?

Yup.

Thanks for the feedback.

I have attached a small patch intended to be applied on top of the v4
patch. I'll resubmit a complete patch shortly, I am just waiting a bit
for additional feedback.

I hope this helps,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XdcQACgkQO2O/RXesiHCVfQCeI/ZLuyuQC8Fz2JJKYZVz0r9p
0EIAnjrAm7VrQkJTWM0YkRhdpfPB+eQW
=uLWv
-----END PGP SIGNATURE-----

--------------060806050604060304060308
Content-Type: text/x-patch;
 name="edt-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="edt-fixes.patch"

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 56efc99..6c09eac 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -388,6 +388,7 @@ config TOUCHSCREEN_PENMOUNT
 
 config TOUCHSCREEN_EDT_FT5X06
 	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
+	depends on I2C
 	help
 	  Say Y here if you have an EDT "Polytouch" touchscreen based
 	  on the FocalTech FT5x06 family of controllers connected to
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index eb31025..719e8e6 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -544,12 +544,11 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	mutex_init(&tsdata->mutex);
 
 	if (tsdata->reset_pin >= 0) {
-		error = gpio_request(tsdata->reset_pin, NULL);
+		error = gpio_request(tsdata->reset_pin, "edt-ft5x06 reset");
 		if (error < 0) {
 			dev_err(&client->dev,
 			        "Failed to request GPIO %d as reset pin, error %d\n",
 			         tsdata->reset_pin, error);
-			error = -ENOMEM;
 			goto err_free_tsdata;
 		}
 
@@ -564,7 +563,7 @@ static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
 	tsdata->irq_pin = pdata->irq_pin;
 	tsdata->irq = gpio_to_irq(tsdata->irq_pin);
 
-	error = gpio_request(tsdata->irq_pin, NULL);
+	error = gpio_request(tsdata->irq_pin, "edt-ft5x06 irq");
 	if (error < 0) {
 		dev_err(&client->dev,
 		        "Failed to request GPIO %d for IRQ %d, error %d\n",

--------------060806050604060304060308--
