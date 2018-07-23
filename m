From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 01/11] touchscreen: ft5x06: Use octal permissions
Date: Mon, 23 Jul 2018 18:49:27 +0530
Message-ID: <20180723131954.30739-11-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Harshit Jain <harshitjain6751@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,

WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
+static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);

WARNING: Symbolic permissions 'S_IRUSR | S_IWUSR' are not preferred. Consider using octal permissions '0600'.
+	debugfs_create_file("mode", S_IRUSR | S_IWUSR,

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+	debugfs_create_file("raw_data", S_IRUSR,

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 1e18ca0d1b4e..ea4026682e79 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -479,16 +479,16 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 }
 
 /* m06, m09: range 0-31, m12: range 0-5 */
-static EDT_ATTR(gain, S_IWUSR | S_IRUGO, WORK_REGISTER_GAIN,
+static EDT_ATTR(gain, 0644, WORK_REGISTER_GAIN,
 		M09_REGISTER_GAIN, 0, 31);
 /* m06, m09: range 0-31, m12: range 0-16 */
-static EDT_ATTR(offset, S_IWUSR | S_IRUGO, WORK_REGISTER_OFFSET,
+static EDT_ATTR(offset, 0644, WORK_REGISTER_OFFSET,
 		M09_REGISTER_OFFSET, 0, 31);
 /* m06: range 20 to 80, m09: range 0 to 30, m12: range 1 to 255... */
-static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
+static EDT_ATTR(threshold, 0644, WORK_REGISTER_THRESHOLD,
 		M09_REGISTER_THRESHOLD, 0, 255);
 /* m06: range 3 to 14, m12: (0x64: 100Hz) */
-static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
+static EDT_ATTR(report_rate, 0644, WORK_REGISTER_REPORT_RATE,
 		NO_REGISTER, 0, 255);
 
 static struct attribute *edt_ft5x06_attrs[] = {
@@ -739,12 +739,12 @@ edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
 	if (!tsdata->debug_dir)
 		return;
 
-	debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir, &tsdata->num_x);
-	debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir, &tsdata->num_y);
+	debugfs_create_u16("num_x", 0400, tsdata->debug_dir, &tsdata->num_x);
+	debugfs_create_u16("num_y", 0400, tsdata->debug_dir, &tsdata->num_y);
 
-	debugfs_create_file("mode", S_IRUSR | S_IWUSR,
+	debugfs_create_file("mode", 0600,
 			    tsdata->debug_dir, tsdata, &debugfs_mode_fops);
-	debugfs_create_file("raw_data", S_IRUSR,
+	debugfs_create_file("raw_data", 0400,
 			    tsdata->debug_dir, tsdata, &debugfs_raw_data_fops);
 }
 
-- 
2.17.1
