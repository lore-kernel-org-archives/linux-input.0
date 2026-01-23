Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F103101D4
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185744; cv=none; b=K94ebEHVGA9FsJLB1cwzaK5YIDagGvFmN3NFIgibtNRs3W6bOFTMILUVKq7dVKMVk7d9+kj809s/rz8PrYjgFzy5UMC3sFMsd8Ebc3AmMs/Bd0GkOl5pWZfyj2rxr8Aah/dzavclBeLXFY8Ca2r0E4m7H9DIimGvvvZMeL2hwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185744; c=relaxed/simple;
	bh=fJy/CYjxSzlpe3N/wZNN3iCtkD+XZFkJQDJsVJMWOMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OY0z+L0JbK6gkm77ZUB50AN+AMd6A9xFN/BrD3pOXAXAVc83FhHsBoAyf/N2BrBr6/hBpqMTsPYuR3kJeAJfijmCGos8F7+8Z3OKu0anPikKk59Jb0o5VrkfXb8qJw+E9jf7mf4AGv1+TpTpmTTpAcBmF2DpqSG4jhi3bgDkBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjK1p-0000Ip-JG; Fri, 23 Jan 2026 17:28:57 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Fri, 23 Jan 2026 17:28:56 +0100
Subject: [PATCH 2/2] Input: st1232 - expose firmware version via sysfs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-input-st1232-firmware-version-v1-2-32df7eefdafe@pengutronix.de>
References: <20260123-input-st1232-firmware-version-v1-0-32df7eefdafe@pengutronix.de>
In-Reply-To: <20260123-input-st1232-firmware-version-v1-0-32df7eefdafe@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Khalid Talash <ktalash@topcon.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Allow user space programs to read the firmware version and revision of
the touch controller from the sysfs.

Suggested-by: Khalid Talash <ktalash@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/input/touchscreen/st1232.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 3362ee83b21d..0da7f2cec60d 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -69,6 +69,34 @@ struct st1232_ts_data {
 	u32 fw_revision;
 };
 
+static ssize_t fw_version_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct st1232_ts_data *st1232_ts = i2c_get_clientdata(client);
+
+	return sysfs_emit(buf, "%u\n", st1232_ts->fw_version);
+}
+
+static ssize_t fw_revision_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct st1232_ts_data *st1232_ts = i2c_get_clientdata(client);
+
+	return sysfs_emit(buf, "%08x\n", st1232_ts->fw_revision);
+}
+
+static DEVICE_ATTR_RO(fw_version);
+static DEVICE_ATTR_RO(fw_revision);
+
+static struct attribute *st1232_attrs[] = {
+	&dev_attr_fw_version.attr,
+	&dev_attr_fw_revision.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(st1232);
+
 static int st1232_ts_read_data(struct st1232_ts_data *ts, u8 reg,
 			       unsigned int n)
 {
@@ -445,6 +473,7 @@ static struct i2c_driver st1232_ts_driver = {
 	.driver = {
 		.name	= ST1232_TS_NAME,
 		.of_match_table = st1232_ts_dt_ids,
+		.dev_groups = st1232_groups,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= pm_sleep_ptr(&st1232_ts_pm_ops),
 	},

-- 
2.47.3

