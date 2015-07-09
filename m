From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - Add a prodcut_id attribute in sysfs
Date: Thu, 9 Jul 2015 13:59:56 -0700
Message-ID: <20150709205956.GF1237@dtor-ws>
References: <1436454043-15093-1-git-send-email-hn.chen@weidahitech.com>
 <20150709180603.GB1237@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36902 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbbGIVAC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 17:00:02 -0400
Content-Disposition: inline
In-Reply-To: <20150709180603.GB1237@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, charliemooney@google.com

On Thu, Jul 09, 2015 at 11:06:03AM -0700, Dmitry Torokhov wrote:
> Hi Hn,
> 
> On Thu, Jul 09, 2015 at 11:00:43PM +0800, HungNien Chen wrote:
> > @@ -165,6 +170,8 @@ struct wdt87xx_sys_param {
> >  	u16	scaling_factor;
> >  	u32	max_x;
> >  	u32	max_y;
> > +	u16	vendor_id;
> > +	u16	product_id;
> 
> The vendor and product id of the device usually go into input dveice:
> 
> 	input->id.vendor
> 	input->id.product
> 
> the custom attributes should be created for data that is not covered by
> the standard attributes (like you have with config_csum or fw_version).

Something like the version below...

-- 
Dmitry

Input: wdt87xx_i2c - populate vendor and product in input device

From: HungNien Chen <hn.chen@weidahitech.com>

These attributes can be used to identify controllers present in the system.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c |   46 ++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index fb92ae1..764d8f2 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -23,7 +23,7 @@
 #include <asm/unaligned.h>
 
 #define WDT87XX_NAME		"wdt87xx_i2c"
-#define WDT87XX_DRV_VER		"0.9.6"
+#define WDT87XX_DRV_VER		"0.9.7"
 #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
 #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
 
@@ -85,6 +85,11 @@
 #define CTL_PARAM_OFFSET_PHY_H		24
 #define CTL_PARAM_OFFSET_FACTOR		32
 
+/* The definition of the device descriptor */
+#define WDT_GD_DEVICE			1
+#define DEV_DESC_OFFSET_VID		8
+#define DEV_DESC_OFFSET_PID		10
+
 /* Communication commands */
 #define PACKET_SIZE			56
 #define VND_REQ_READ			0x06
@@ -165,6 +170,8 @@ struct wdt87xx_sys_param {
 	u16	scaling_factor;
 	u32	max_x;
 	u32	max_y;
+	u16	vendor_id;
+	u16	product_id;
 };
 
 struct wdt87xx_data {
@@ -208,6 +215,32 @@ static int wdt87xx_i2c_xfer(struct i2c_client *client,
 	return 0;
 }
 
+static int wdt87xx_get_desc(struct i2c_client *client, u8 desc_idx,
+			    u8 *buf, size_t len)
+{
+	u8 tx_buf[] = { 0x22, 0x00, 0x10, 0x0E, 0x23, 0x00 };
+	int error;
+
+	tx_buf[2] |= desc_idx & 0xF;
+
+	error = wdt87xx_i2c_xfer(client, tx_buf, sizeof(tx_buf),
+				 buf, len);
+	if (error) {
+		dev_err(&client->dev, "get desc failed: %d\n", error);
+		return error;
+	}
+
+	if (buf[0] != len) {
+		dev_err(&client->dev, "unexpected response to get desc: %d\n",
+			buf[0]);
+		return -EINVAL;
+	}
+
+	mdelay(WDT_COMMAND_DELAY_MS);
+
+	return 0;
+}
+
 static int wdt87xx_get_string(struct i2c_client *client, u8 str_idx,
 			      u8 *buf, size_t len)
 {
@@ -403,6 +436,15 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
 	u8 buf[PKT_READ_SIZE];
 	int error;
 
+	error = wdt87xx_get_desc(client, WDT_GD_DEVICE, buf, 18);
+	if (error) {
+		dev_err(&client->dev, "failed to get device desc\n");
+		return error;
+	}
+
+	param->vendor_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_VID);
+	param->product_id = get_unaligned_le16(buf + DEV_DESC_OFFSET_PID);
+
 	error = wdt87xx_get_string(client, STRIDX_PARAMETERS, buf, 34);
 	if (error) {
 		dev_err(&client->dev, "failed to get parameters\n");
@@ -994,6 +1036,8 @@ static int wdt87xx_ts_create_input_device(struct wdt87xx_data *wdt)
 
 	input->name = "WDT87xx Touchscreen";
 	input->id.bustype = BUS_I2C;
+	input->id.vendor = wdt->param.vendor_id;
+	input->id.product = wdt->param.product_id;
 	input->phys = wdt->phys;
 
 	input_set_abs_params(input, ABS_MT_POSITION_X, 0,

