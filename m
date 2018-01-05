From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen :Modify Raydium Firmware
 update input file
Date: Thu, 4 Jan 2018 21:53:38 -0800
Message-ID: <20180105055338.cogtaty5p5r5gglt@dtor-ws>
References: <20171221135122.345-1-jeffrey.lin@raydium.corp-partner.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38346 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeAEFxm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Jan 2018 00:53:42 -0500
Content-Disposition: inline
In-Reply-To: <20171221135122.345-1-jeffrey.lin@raydium.corp-partner.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: groeck@chromium.org, keith.tzeng@quantatw.com, Katherine.Hsieh@quantatw.com, bleung@google.com, jeffrey.lin@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, calvin.tseng@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Jeffrey,

On Thu, Dec 21, 2017 at 09:51:22PM +0800, jeffrey.lin wrote:
> Modify update firmware to accept alternative file name
> 
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index a99fb5cac5a0..439d43c3519c 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -130,6 +130,7 @@ struct raydium_data {
>  	struct gpio_desc *reset_gpio;
>  
>  	struct raydium_info info;
> +	char fw_file[64];

You do not really need to keep the firmware name in driver data, just
use a temporary in raydium_i2c_fw_update().

>  
>  	struct mutex sysfs_mutex;
>  
> @@ -752,12 +753,16 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
>  {
>  	struct i2c_client *client = ts->client;
>  	const struct firmware *fw = NULL;
> -	const char *fw_file = "raydium.fw";
>  	int error;
>  
> -	error = request_firmware(&fw, fw_file, &client->dev);
> +	/* Firmware name */
> +	snprintf(ts->fw_file, sizeof(ts->fw_file),
> +		"raydium_%x.fw", ts->info.hw_ver);

hw_ver is LE32, you need to convert it to CPU endianness before using.
Also it would be better if we used the same encoding for the hardware
version as the one that we use when we output it in sysfs. It makes
userspace life a bit easier I think.

How about the version of the patch below?

Thanks.

-- 
Dmitry


Input: raydium_i2c_ts - include hardware version in firmware name

From: Jeffrey Lin <jeffrey.lin@rad-ic.com>

Add hardware version to the firmware file name to handle scenarios where
single system image supports variety of devices.

Signed-off-by: Jeffrey Lin <jeffrey.lin@rad-ic.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 100538d64fff..d1c09e6a2cb6 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -752,13 +752,20 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
 	const struct firmware *fw = NULL;
-	const char *fw_file = "raydium.fw";
+	char *fw_file;
 	int error;
 
+	fw_file = kasprintf(GFP_KERNEL, "raydium_%#04x.fw",
+			    le32_to_cpu(ts->info.hw_ver));
+	if (!fw_file)
+		return -ENOMEM;
+
+	dev_dbg(&client->dev, "firmware name: %s\n", fw_file);
+
 	error = request_firmware(&fw, fw_file, &client->dev);
 	if (error) {
 		dev_err(&client->dev, "Unable to open firmware %s\n", fw_file);
-		return error;
+		goto out_free_fw_file;
 	}
 
 	disable_irq(client->irq);
@@ -787,6 +794,9 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
 
 	release_firmware(fw);
 
+out_free_fw_file:
+	kfree(fw_file);
+
 	return error;
 }
 
