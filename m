Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972388;
	b=cgzaWlpFOdoCRW9QdpYVSwsGkoAIculPoJNiK3As5hIE9PZUCqD98IHAzRm3LGP9Ot4z
	 gdiKapyW0YzSz+u2lCYXBGUqZrdpXWGGP9Tc/Zjtk2Vjbj9CtoWFyhy6NnTkZxR9jUegy
	 DY/sZoLql0Hh7tm/MCpHZM+fiuomnSXTVMz3hEShe3ZWHGC0mJ+c6sNJphj1ZR9MlvJBu
	 kMZGUZS4QLG19Vk5iv4IrFq1aNmKX5yznICObUvyHGmoYMLCRnqwRwBRRjBhRRF4/G4LF
	 tZ5oa7IME/+PC+jA+Cp41DMuAG1yaKaMK1iFH8TUT061xF9xszM5/TZoSy5AqzprqKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972388;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D0NSCnSnHvibQ22wIHusrKeWbf7lWfSwMwU20JuWpHE=;
	b=n9dMrgOf1276ARXAVWTQDsgKKLPFakeyacHPYqr0aMuen2Qot23dL+DeAVSdIZWk+WyF
	 rh9b2iWg0uIoRPwijPOxHWxF1x8mIK7F8iZj6d6aQMAqXChM2xw1eZKjy6Yo4g76h9ukf
	 Qla6c/Tv9v9l0euWA4WIT5TguWVEuwBXuBqP3L7zAaT6TC5/Xe62CKtSgFERp1v/pB3RT
	 /Wxfha62oF7R+974Ny0Qoh821l3bYDg5yJAuBCd34f5T1GHv4IXCaajw0nKh4BbFvWnCU
	 YhwAvo9QGL1H2AUH3qpAULGWmNbrfhlbyOoowERkOJi+SwGTwZ7KLdU1aKQ3ANVDiJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UsnyeUYt;
	arc=none smtp.remote-ip=91.218.175.190
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E1606A31B
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 23:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E36E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UsnyeUYt
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SEK2m6Xjc2HWh6AeZPyBY2z+Q3T3l0R1Tz/h8bAgWuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792972386; v=1; x=1793577186;
 b=UsnyeUYthlXyNSz87ciVSPgkhmBdYF9okDeia8UnUPJCbNAeZ3BrM0ZGW6mx6I7oPpxkr65n
 IdWwCe/NJJsaTNTFmuhbdG1apJqVJReaMaoHqq4pvBR997sFiVZhUK0ZvoKKfzeQgeJ3hUPKsk2
 eUqgFCYTWMdE4MBB+6zYJQHw=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9b8e9d147094b360;
	Sun, 25 Oct 2026 23:53:06 +0000
X-Mizu-Trace-ID: 9b8e9d147094b360
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v11 14/18] HID: asus: expose XG Mobile identity and firmware information
Date: Sun, 25 Oct 2026 23:52:27 +0000
Message-ID: <20261025235232.129945-15-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025235232.129945-1-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Benato <benato.denis96@gmail.com>

The identity query also reports the mainboard part number, the serial
number and the part number of the station, and the 0xCE 0x03 query
answers with an 8-byte binary blob followed by "tag, length, data"
fields where GEN holds the station generation and VER the firmware
version.

Collect this information at probe time and expose it read-only on the
HID device:

  /sys/bus/hid/devices/<bus>:<addr>.<intf>/xgm_model             (PRO)
  .../xgm_serial                                              (SN)
  .../xgm_mainboard                                           (MB)
  .../xgm_part_number                                         (PNUM)
  .../xgm_firmware_version                                    (VER)
  .../xgm_generation                                          (GEN)

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 176 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index e751bf163434..f438cad13264 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -185,6 +185,8 @@ struct asus_xgm_info {
 	char serial[ASUS_XGM_INFO_LEN];
 	char model[ASUS_XGM_INFO_LEN];
 	char part_number[ASUS_XGM_INFO_LEN];
+	char firmware_version[ASUS_XGM_INFO_LEN];
+	char generation[ASUS_XGM_INFO_LEN];
 };
 
 struct asus_touchpad_info {
@@ -6204,6 +6206,148 @@ static bool asus_xgm_is_supported_model(const struct asus_xgm_info *info)
 	return false;
 }
 
+/**
+ * asus_xgm_tlv_str() - Extract a "tag, length, data" field
+ * @dst: destination buffer
+ * @dst_len: size of @dst, including the trailing NUL
+ * @buf: answer of a version query
+ * @len: size of @buf
+ * @tag: three characters tag to look for
+ *
+ * The version query answers with an 8-byte binary blob followed by
+ * "tag, length, data" fields, where GEN holds the station generation and
+ * VER the firmware version.
+ *
+ * Return: 0 on success, -ENOENT if @tag is missing or its data does not
+ * fit @dst
+ */
+static int asus_xgm_tlv_str(char *dst, size_t dst_len, const u8 *buf,
+			    size_t len, const char *tag)
+{
+	size_t i;
+	u8 n;
+
+	for (i = 3; i + 4 <= len; i++) {
+		if (memcmp(buf + i, tag, 3))
+			continue;
+
+		n = buf[i + 3];
+		if (i + 4 + n > len || n >= dst_len)
+			return -ENOENT;
+
+		memcpy(dst, buf + i + 4, n);
+		dst[n] = '\0';
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * asus_xgm_get_version() - Query the firmware version of a station
+ * @hdev: HID device
+ * @info: identity structure whose generation and firmware_version fields
+ * get filled in
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int asus_xgm_get_version(struct hid_device *hdev,
+				struct asus_xgm_info *info)
+{
+	size_t len = asus_report_len(hdev, FEATURE_KBD_LED_REPORT_ID2);
+	int ret;
+
+	if (!len)
+		return -EINVAL;
+
+	u8 *buf __free(kfree) = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = asus_xgm_query(hdev, ASUS_XGM_QUERY_VERSION, buf, len);
+	if (ret < 0)
+		return ret;
+
+	if (len < 4 || buf[1] != ASUS_XGM_CMD_QUERY ||
+	    buf[2] != ASUS_XGM_QUERY_VERSION)
+		return -ENODEV;
+
+	asus_xgm_tlv_str(info->generation, sizeof(info->generation),
+			 buf, len, "GEN");
+	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
+			 buf, len, "VER");
+
+	return 0;
+}
+
+/**
+ * asus_xgm_drvdata() - Get the drvdata behind an XG Mobile attribute
+ * @dev: HID device the attribute is attached to
+ *
+ * Return: the asus_drvdata of @dev
+ */
+static struct asus_drvdata *asus_xgm_drvdata(struct device *dev)
+{
+	return hid_get_drvdata(to_hid_device(dev));
+}
+
+static ssize_t xgm_model_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->model);
+}
+static DEVICE_ATTR_RO(xgm_model);
+
+static ssize_t xgm_serial_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->serial);
+}
+static DEVICE_ATTR_RO(xgm_serial);
+
+static ssize_t xgm_mainboard_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->mainboard);
+}
+static DEVICE_ATTR_RO(xgm_mainboard);
+
+static ssize_t xgm_part_number_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->part_number);
+}
+static DEVICE_ATTR_RO(xgm_part_number);
+
+static ssize_t xgm_firmware_version_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->firmware_version);
+}
+static DEVICE_ATTR_RO(xgm_firmware_version);
+
+static ssize_t xgm_generation_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->generation);
+}
+static DEVICE_ATTR_RO(xgm_generation);
+
+static struct attribute *asus_xgm_attrs[] = {
+	&dev_attr_xgm_model.attr,
+	&dev_attr_xgm_serial.attr,
+	&dev_attr_xgm_mainboard.attr,
+	&dev_attr_xgm_part_number.attr,
+	&dev_attr_xgm_firmware_version.attr,
+	&dev_attr_xgm_generation.attr,
+	NULL
+};
+
+static const struct attribute_group asus_xgm_attr_group = {
+	.attrs = asus_xgm_attrs,
+};
+
 static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
 {
 	const u8 buf[] = { FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00 };
@@ -6499,9 +6643,29 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 
 	drvdata->xgm_info = info;
 
+	ret = asus_xgm_get_version(hdev, info);
+	if (ret < 0)
+		hid_warn(hdev, "Failed to query XG Mobile version: %d\n", ret);
+	else
+		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
+			 info->firmware_version, info->generation);
+
+	/*
+	 * The attribute group is not devm-managed: a creation failure is
+	 * fatal and unwound through asus_xgm_init_err, while on the unbind
+	 * path the removal is gated on xgm_info exactly like the creation.
+	 */
+	ret = sysfs_create_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	if (ret) {
+		hid_err(hdev, "Failed to create XG Mobile attributes: %d\n", ret);
+		goto asus_xgm_init_err;
+	}
+
 	drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
-	if (drvdata->xgm_led == NULL)
-		return -ENOMEM;
+	if (!drvdata->xgm_led) {
+		ret = -ENOMEM;
+		goto asus_xgm_init_err;
+	}
 
 	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
 			      info->model);
@@ -6533,6 +6697,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 
 	return 0;
 asus_xgm_init_err:
+	sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	drvdata->xgm_info = NULL;
 	drvdata->xgm_led = NULL;
 	return ret;
 }
@@ -6750,6 +6916,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->xgm_info)
+		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
@@ -6768,6 +6937,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->xgm_info)
+		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
-- 
2.47.3

