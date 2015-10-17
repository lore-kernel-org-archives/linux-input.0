From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Chromebook Pixel 1 atmel_mxt_ts doesn't work
Date: Sat, 17 Oct 2015 11:26:19 -0700
Message-ID: <20151017182619.GH13470@dtor-ws>
References: <CANdZDc4sHV5D6a8TsuSJ5hbecXP4SokmLp8E9KkD92pmMu7OTg@mail.gmail.com>
 <CAKdAkRTSUfVraTGkm6AwwxG_A1g4XJBdk4Xfmd7HP+MGrNhDKA@mail.gmail.com>
 <CANdZDc7WGtg6rzbNOozH-Q-qEw8PWdd_E738oe=Vt=Fctk7JWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34117 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbJQS0X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 14:26:23 -0400
Received: by pasz6 with SMTP id z6so7849121pas.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2015 11:26:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANdZDc7WGtg6rzbNOozH-Q-qEw8PWdd_E738oe=Vt=Fctk7JWQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zooko Wilcox-O'Hearn <zookog@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Nick Dyer <nick.dyer@itdev.co.uk>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 07:59:17PM +0000, Zooko Wilcox-O'Hearn wrote:
> This is the complete output of running evtest and choosing option 10,
> from the console (while X is running, but I'm not running evtest under
> X).
> 
> zooko@spark ~ $ sudo evtest
> No device specified, trying to scan all of /dev/input/event*
...
>   Property type 0 (INPUT_PROP_POINTER)
>   Property type 2 (INPUT_PROP_BUTTONPAD)
> Testing ... (interrupt to exit)

I see. I wonder if configuration data stored in controller's NVRAM was
reset somehow. You can try extracting that data from Chrome OS
repository [1] (I believe this is a public link).

Rename files from *.raw into link-*.raw and drop them in /lib/firmware
Then apply the 2 attached patches and see if it will bring the touch
back to life.

Thanks!

-- 
Dmitry

[1]
https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-link/chromeos-base/chromeos-touch-config-link/files/

--TB36FDmn/VVEgNH/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="atmel-platform-cfg.patch"

Input: atmel_mxt_ts - allow specifying device-specific configs

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Atmel controllers are very flexible and to function optimally require
device-specific configuration to be loaded. While the configuration is
stored in NVRAM and is normally persistent, sometimes it gets corrupted
and needs to be reloaded.

Instead of using the same name, maxtouch.cfg, for all systems and all
devices, let's allow platform data to specify the name of configuration
file that should be loaded. This is especially useful for systems that
use Atmel controllers for both touchscreen and touchpad, since their
configurations will surely differ.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/atmel,maxtouch.txt   |    6 ++++++
 drivers/input/touchscreen/atmel_mxt_ts.c           |   11 ++++++++++-
 include/linux/platform_data/atmel_mxt_ts.h         |    1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 1852906..fd2344d 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -9,6 +9,12 @@ Required properties:
 - interrupts: The sink for the touchpad's IRQ output
     See ../interrupt-controller/interrupts.txt
 
+Optional properties:
+
+- linux,config-name: name of configuration file that should be loaded
+    into device for optimal functioning. If not specified "maxtouch.cfg"
+    will be used.
+
 Optional properties for main touchpad device:
 
 - linux,gpio-keymap: When enabled, the SPT_GPIOPWN_T19 object sends messages
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c562205..86f4360 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1989,7 +1989,8 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		goto err_free_object_table;
 
-	error = request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
+	error = request_firmware_nowait(THIS_MODULE, true,
+					data->pdata->cfg_name ?: MXT_CFG_NAME,
 					&client->dev, GFP_KERNEL, data,
 					mxt_config_cb);
 	if (error) {
@@ -2416,11 +2417,13 @@ static void mxt_input_close(struct input_dev *dev)
 #ifdef CONFIG_OF
 static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 {
+	struct device_node *np;
 	struct mxt_platform_data *pdata;
 	struct device_node *np = client->dev.of_node;
 	u32 *keymap;
 	int proplen, ret;
 
+	np = client->dev.of_node;
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
@@ -2448,6 +2451,8 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 
 	pdata->suspend_mode = MXT_SUSPEND_DEEP_SLEEP;
 
+	of_property_read_string(np, "linux,config-name", &pdata->cfg_name);
+
 	return pdata;
 }
 #else
@@ -2478,11 +2483,15 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
 		.pdata	= {
 			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
 			.t19_keymap	= samus_touchpad_buttons,
+			.cfg_name	= "samus-337t.raw",
 		},
 	},
 	{
 		/* Touchscreen */
 		.hid	= "ATML0001",
+		.pdata	= {
+			.cfg_name	= "samus-2954t2.raw",
+		},
 	},
 	{ }
 };
diff --git a/include/linux/platform_data/atmel_mxt_ts.h b/include/linux/platform_data/atmel_mxt_ts.h
index 695035a..2bcd4ff 100644
--- a/include/linux/platform_data/atmel_mxt_ts.h
+++ b/include/linux/platform_data/atmel_mxt_ts.h
@@ -26,6 +26,7 @@ struct mxt_platform_data {
 	u8 t19_num_keys;
 	const unsigned int *t19_keymap;
 	enum mxt_suspend_mode suspend_mode;
+	const char *cfg_name;
 };
 
 #endif /* __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H */

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=chromeos_laptop-add-config

chromeos_laptop: add config names for Pixel 1 touchpad/screen

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Make use of the new facilities in Atmel driver to allow specifying
configuration file that is used by the device. We will be using
link-224sl.raw for the touchpad and link-1664s.raw for the touchpad.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 0207274..70bf81d 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -112,6 +112,7 @@ static struct mxt_platform_data atmel_224s_tp_platform_data = {
 	.t19_num_keys		= ARRAY_SIZE(mxt_t19_keys),
 	.t19_keymap		= mxt_t19_keys,
 	.suspend_mode		= MXT_SUSPEND_T9_CTRL,
+	.cfg_name		= "link-224sl.raw",
 };
 
 static struct i2c_board_info atmel_224s_tp_device = {
@@ -123,6 +124,7 @@ static struct i2c_board_info atmel_224s_tp_device = {
 static struct mxt_platform_data atmel_1664s_platform_data = {
 	.irqflags		= IRQF_TRIGGER_FALLING,
 	.suspend_mode		= MXT_SUSPEND_T9_CTRL,
+	.cfg_name		= "link-1664s.raw",
 };
 
 static struct i2c_board_info atmel_1664s_device = {

--TB36FDmn/VVEgNH/--
