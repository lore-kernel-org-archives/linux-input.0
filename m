Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756494;
	b=CaOHZR89dVxMiVuk7jv4RC+K7sQvD2t/7EM9WhPpMuZDkbt8dbl5mi0ymg9S/A2G5SO6
	 qStxRkh5q9Ax7Xbn2PXutk7jzFC0Y1e/hEQ2LU08GRRcv+aYNFdSD9DusGXqGxiUHf8D4
	 16SKBzzbtKn2SOQpwmc/KvqTGcq5ovPDANBjHLVtLfgFlOMuqB2HYYMHD5cP8b2WIk/Yw
	 /mTmY9hounS2IOyNPp3QMaq8IcCGgYdXrfKq7tQKROTY8cPUpwYK9JbbW1klTyunKDasO
	 w5X9wUmxIpXO3oPdYv1YqXW9kV2C91m/T7PDfesWmOpfCaBNlORvYdNCpS8Uyh+0a9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756494;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sL0U7mg2y/5++XBx35WR3R/Ul/oU9IIAuNY/WBYt6gw=;
	b=JszAoMGvT/2xbYMIEjHmPgYAm4Msh47sqiog0ylPIiE5HlXJPAanfk6+h16EfHLVEytS
	 dT3BbldMq0OJSeaP259lDz59SDKghHWDnLtb0JzKcOefC31+e1+P2v7GyapX8aR69EezD
	 Q8TkfA2Jjbeod6SGFGcPF6KgPlRGlP+PLQ8H4mVZBEnMSbOuInZrlEIvXp1Vj5X29pu2M
	 rDF1KopVxk+twMGUTQuSAZgjNRiPzDVtkWjne9IJ94VRtbeuN4gQ6azQuzolBje4BAug0
	 A0ZYNY5lXZgG49aCFVAGm5yxW4dOTaWtgbjlMWOKhoiw8f4iLGlbHpFnlTVbvjlzdEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rJavOn0R;
	arc=none smtp.remote-ip=95.215.58.238
Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7B606D80D
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B7B606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rJavOn0R
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=paQmrDpl70WcGpcUTZwCfovzOpHuX0keP69tsTaw7Tw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756491; v=1; x=1794361291;
 b=rJavOn0RRcGn7XMxGjuSEw3KGyYlPeMlmAE6cjt7ilVDFw4kDeaumjSXfvTElOfrd48vcfoY
 mFfBs80q8hXFkaPH6gEPntgRsVcJPqQCSZTdojlXRjLc8OvnqFZvsJeHPN3g+Wl99O3No8KYcqR
 mKDb15P8Vf3gMB2c6gA1Ccs0=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b6c2fe6bd8c77244;
	Wed, 04 Nov 2026 01:41:31 +0000
X-Mizu-Trace-ID: b6c2fe6bd8c77244
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
Subject: [PATCH v13 14/18] HID: asus: expose XG Mobile identity and firmware information
Date: Wed,  4 Nov 2026 01:39:31 +0000
Message-ID: <20261104013935.512713-15-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104013935.512713-1-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 188 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index eb9dd69fd605..a24c64c86b5f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -73,6 +73,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 /* XG Mobile station protocol on FEATURE_KBD_LED_REPORT_ID2. */
 #define ASUS_XGM_CMD_QUERY 0xce
 #define ASUS_XGM_QUERY_IDENTITY 0x01
+#define ASUS_XGM_QUERY_VERSION 0x03
 #define ASUS_XGM_INFO_LEN 32
 
 /* Identity string fields, each "TAG:value;" inside the query answer. */
@@ -80,6 +81,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_XGM_TAG_SERIAL	"SN:"
 #define ASUS_XGM_TAG_MODEL	"PRO:"
 #define ASUS_XGM_TAG_PART	"PNUM:"
+#define ASUS_XGM_TAG_GENERATION	"GEN"
+#define ASUS_XGM_TAG_FIRMWARE	"VER"
+
+/* A version field is a 3-character tag, one length byte, then the data. */
+#define ASUS_XGM_TLV_TAG_LEN	3
+#define ASUS_XGM_TLV_HDR_LEN	(ASUS_XGM_TLV_TAG_LEN + 1)
 
 /*
  * Every station answer echoes the report id, the opcode and the
@@ -245,6 +252,8 @@ struct asus_xgm_info {
 	char serial[ASUS_XGM_INFO_LEN];
 	char model[ASUS_XGM_INFO_LEN];
 	char part_number[ASUS_XGM_INFO_LEN];
+	char firmware_version[ASUS_XGM_INFO_LEN];
+	char generation[ASUS_XGM_INFO_LEN];
 };
 
 struct asus_touchpad_info {
@@ -5063,6 +5072,153 @@ static bool asus_xgm_is_supported_model(const struct asus_xgm_info *info)
 	return false;
 }
 
+/**
+ * asus_xgm_tlv_str() - Extract a "tag, length, data" field
+ * @dst: destination buffer
+ * @dst_len: size of @dst, including the trailing NUL
+ * @buf: answer of a version query
+ * @len: size of @buf
+ * @tag: three-character tag to look for
+ *
+ * Return: 0 on success, -ENOENT if @tag is missing or its data does not
+ * fit in @dst.
+ */
+static int asus_xgm_tlv_str(char *dst, size_t dst_len, const u8 *buf,
+			    size_t len, const char *tag)
+{
+	const u8 *p = buf + ASUS_XGM_RESP_PAYLOAD;
+	const u8 *end = buf + len;
+	u8 n;
+
+	/*
+	 * The payload starts with a binary prefix and then the fields.
+	 * The station pads between fields with 0xff, so the tag is sought
+	 * at every byte rather than walked as a packed list.
+	 */
+	while (p + ASUS_XGM_TLV_HDR_LEN <= end) {
+		if (!memcmp(p, tag, ASUS_XGM_TLV_TAG_LEN)) {
+			n = p[ASUS_XGM_TLV_TAG_LEN];
+
+			if (n >= dst_len ||
+			    end - (p + ASUS_XGM_TLV_HDR_LEN) < n)
+				return -ENOENT;
+
+			memcpy(dst, p + ASUS_XGM_TLV_HDR_LEN, n);
+			dst[n] = '\0';
+			return 0;
+		}
+
+		p++;
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
+ * Return: 0 on success, negative errno on failure.
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
+	if (len <= ASUS_XGM_RESP_HDR_LEN ||
+	    buf[ASUS_XGM_RESP_OPCODE] != ASUS_XGM_CMD_QUERY ||
+	    buf[ASUS_XGM_RESP_SUBCMD] != ASUS_XGM_QUERY_VERSION)
+		return -ENODEV;
+
+	asus_xgm_tlv_str(info->generation, sizeof(info->generation),
+			 buf, len, ASUS_XGM_TAG_GENERATION);
+	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
+			 buf, len, ASUS_XGM_TAG_FIRMWARE);
+
+	return 0;
+}
+
+/**
+ * asus_xgm_drvdata() - Get the drvdata behind an XG Mobile attribute
+ * @dev: HID device the attribute is attached to
+ *
+ * Return: the asus_drvdata of @dev.
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
@@ -5366,9 +5522,29 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 
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
 
 	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s-%s:led",
 			      info->model,
@@ -5401,6 +5577,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 
 	return 0;
 asus_xgm_init_err:
+	sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	drvdata->xgm_info = NULL;
 	drvdata->xgm_led = NULL;
 	return ret;
 }
@@ -5617,6 +5795,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->xgm_info)
+		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
@@ -5641,6 +5822,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->xgm_info)
+		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
-- 
2.47.3

