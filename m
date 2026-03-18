Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829A39F169
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834105; cv=none; b=fM8rNbejYQPwO48ivYsiLaOt4Hm384+Nr/T4vvw/OVtgXplAkmO2wBQC5fu1zBIbPdt/wxY1HMOiBjRm0iu+tbn/lBFXVlFKPPJj8TvE4tNVc5V75h0846DStrPdX6UzlapWtrWfURSKCMT5EJb5BmlW80KlXKYUz+YXdythNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834105; c=relaxed/simple;
	bh=xjyZBk0grBs+VBgeS/r4YIeY4xLiQl3ez6F3b1DmFrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NV8ROACLoDLYGSX5UkeE4sbdBt52tVp+PhgwfafyPCU4sm/LjRl0FloJZDobV6h9ZmJQdk5BflGg5FOpG8ozhRmPhxcilDiKMosiLm0kPEMNC1diEceYN4nSh1YfWTCbtgYF668ptY4GXnykDCUAr1GZ5AvPujulIVcIPam7MiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1w2pHR-0001h8-Pl; Wed, 18 Mar 2026 12:41:41 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Wed, 18 Mar 2026 12:41:31 +0100
Subject: [PATCH v2 2/2] Input: st1232 - expose firmware version via sysfs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-input-st1232-firmware-version-v2-2-e844ee340d36@pengutronix.de>
References: <20260318-input-st1232-firmware-version-v2-0-e844ee340d36@pengutronix.de>
In-Reply-To: <20260318-input-st1232-firmware-version-v2-0-e844ee340d36@pengutronix.de>
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
Changes in v2:
- none
---
 drivers/input/touchscreen/st1232.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index cc72d70642b2..843140ebb6bf 100644
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

