From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv6 1/5] Input: edt-ft5x06: several cleanups; no functional change
Date: Mon, 24 Mar 2014 16:11:06 +0100
Message-ID: <1395673870-29435-2-git-send-email-LW@KARO-electronics.de>
References: <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
 <1395673870-29435-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1395673870-29435-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fugang Duan <B38611@freescale.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

- remove redundant parens
- remove redundant type casts
- fix mixed tab/space indentation

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/input/touchscreen/edt-ft5x06.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index 412a85e..155ab3b 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -173,7 +173,7 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void =
*dev_id)
 		x =3D ((buf[0] << 8) | buf[1]) & 0x0fff;
 		y =3D ((buf[2] << 8) | buf[3]) & 0x0fff;
 		id =3D (buf[2] >> 4) & 0x0f;
-		down =3D (type !=3D TOUCH_EVENT_UP);
+		down =3D type !=3D TOUCH_EVENT_UP;
=20
 		input_mt_slot(tsdata->input, id);
 		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
@@ -257,7 +257,7 @@ static ssize_t edt_ft5x06_setting_show(struct devic=
e *dev,
 	struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
 	struct edt_ft5x06_attribute *attr =3D
 			container_of(dattr, struct edt_ft5x06_attribute, dattr);
-	u8 *field =3D (u8 *)((char *)tsdata + attr->field_offset);
+	u8 *field =3D (u8 *)tsdata + attr->field_offset;
 	int val;
 	size_t count =3D 0;
 	int error =3D 0;
@@ -299,7 +299,7 @@ static ssize_t edt_ft5x06_setting_store(struct devi=
ce *dev,
 	struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
 	struct edt_ft5x06_attribute *attr =3D
 			container_of(dattr, struct edt_ft5x06_attribute, dattr);
-	u8 *field =3D (u8 *)((char *)tsdata + attr->field_offset);
+	u8 *field =3D (u8 *)tsdata + attr->field_offset;
 	unsigned int val;
 	int error;
=20
@@ -479,7 +479,7 @@ static int edt_ft5x06_debugfs_mode_set(void *data, =
u64 mode)
=20
 	if (mode !=3D tsdata->factory_mode) {
 		retval =3D mode ? edt_ft5x06_factory_mode(tsdata) :
-			        edt_ft5x06_work_mode(tsdata);
+				edt_ft5x06_work_mode(tsdata);
 	}
=20
 	mutex_unlock(&tsdata->mutex);
@@ -568,7 +568,6 @@ out:
 	return error ?: read;
 };
=20
-
 static const struct file_operations debugfs_raw_data_fops =3D {
 	.open =3D simple_open,
 	.read =3D edt_ft5x06_debugfs_raw_data_read,
@@ -614,8 +613,6 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts=
_data *tsdata)
=20
 #endif /* CONFIG_DEBUGFS */
=20
-
-
 static int edt_ft5x06_ts_reset(struct i2c_client *client,
 					 int reset_pin)
 {
@@ -852,8 +849,8 @@ static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
 			 edt_ft5x06_ts_suspend, edt_ft5x06_ts_resume);
=20
 static const struct i2c_device_id edt_ft5x06_ts_id[] =3D {
-	{ "edt-ft5x06", 0 },
-	{ }
+	{ "edt-ft5x06", 0, },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
=20
--=20
1.7.10.4

