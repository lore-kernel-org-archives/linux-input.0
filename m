Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975083;
	b=iJ5nJbz4nviFtbXgi9Ot7Bv4IC/7KWRrTdne7YTgI+wjq7muGpLs1iFGwOhPoIg4Xy8j
	 uxWnZuQNBri/nsaZQLrfjzcSIcV59dYGcevmZjj9+PXyXKuarBmt6pwRiBfl1Ga0jtjAA
	 z8iW1J7p01OSo1eUZfdk4451H85lfeF94Hnt4fq6iYi34v1pGps6dVoXzisYDg8ulXfBy
	 SSgeSBT0iBH4ihSs9mZENlIN5kozpiBnSwDOMcWZirrFOdTa+KNVkfDbdGJkiNIPPlpVO
	 W6S+iA2jGMlcXZDyEt8ww40yKmEFS5L+ynChrVhe834tUwc2oXB/wl33HGw912RGtGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975083;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BCYEjSQDvOt5m5eb3+cqpLgk8f/PYhquxo4tMD2xjJU=;
	b=3ZFQDqv3rwijr69PS5B0DtvLTYTu0mhEWWFynhAPj1/VNYoJ245B7FwhfYtJY2Q4DHgQ
	 LZPACs96IpoJHPp+omMbx+8cG/aBW7X48mbxvhBUCJbjYAKqq98kukdbQ3achGsN2jGny
	 x/FFfR9cGHgv9pYZjW2YkgCRro03PcO92H0XAhfE+67cxRE8GLrB5i7YAoQJfQf0i/kyp
	 lECZ2tB6AGgVUtabR3SdhBz6gw9XdPSAFfu+IRpumG/Va6G344Vz78lMKe6no5FpLb6c1
	 SsLDydSTTMRMiBmbCSDB8bwVVmLbZKEbmTBtV1+t9Gml5nAt7daJd+Qenb6sr5aTBSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ty28EFe7;
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62C606A33E
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D62C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ty28EFe7
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=df1sVJZ+X3HL5EKrSAXlwWXx25ef9tBEfcYBlA4RQ3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975081; v=1; x=1794579881;
 b=Ty28EFe7Nzhk5nw5BXJofaRXq5A+Vcj9QMwA9WONCCGcGSR97Gl7KyqgIN5brqU89i06f0Rg
 HygjpEHW3ZxQVb6FwyRukpFGcUm5z4CA2U7B6Mb9ZKN78Wo0d+412uz4bRfTYSAagsEpoZe+Eii
 Sa20zABJthGtVsYTAWKn5PxU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0737bcd5abac521;
	Fri, 06 Nov 2026 14:24:41 +0000
X-Mizu-Trace-ID: a0737bcd5abac521
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v14 13/18] HID: asus: identify XG Mobile stations and bind the LED to the reported model
Date: Fri,  6 Nov 2026 14:23:29 +0000
Message-ID: <20261106142334.1881-14-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106142334.1881-1-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
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

The XG Mobile LED interface is currently bound to two USB product IDs
(0x1970, 0x1a9a). The stations identify themselves through the vendor
report 0x5E: after the usual "ASUS Tech.Inc." unlock, the 0xCE 0x01
query answers with a NUL terminated string of the form

  MB:<mainboard>;SN:<serial>;PRO:<model>;PNUM:<part number>;

Run this query at probe time to initialize the LED interface only on
supported models (GC31, GC32 and GC33). The LED name is the model
followed by the bus identity (asus:xgm-<model>-<uniq>:led).
The identity query is tried three times, one second apart, so one
missed transfer does not leave the LED unregistered.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 234 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index cb6c55e75e6e..8ed74ac10cb4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -26,6 +26,7 @@
 #include <linux/compiler_attributes.h>
 #include <linux/container_of.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/hid.h>
@@ -70,6 +71,29 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
+/* XG Mobile station protocol on FEATURE_KBD_LED_REPORT_ID2. */
+#define ASUS_XGM_CMD_QUERY 0xce
+#define ASUS_XGM_QUERY_IDENTITY 0x01
+#define ASUS_XGM_INFO_LEN 32
+
+/* Identity string fields, each "TAG:value;" inside the query answer. */
+#define ASUS_XGM_TAG_MAINBOARD	"MB:"
+#define ASUS_XGM_TAG_SERIAL	"SN:"
+#define ASUS_XGM_TAG_MODEL	"PRO:"
+#define ASUS_XGM_TAG_PART	"PNUM:"
+
+/*
+ * Every station answer echoes the report id, the opcode and the
+ * subcommand, then the payload.
+ */
+enum {
+	ASUS_XGM_RESP_REPORT_ID,
+	ASUS_XGM_RESP_OPCODE,
+	ASUS_XGM_RESP_SUBCMD,
+	ASUS_XGM_RESP_PAYLOAD,
+	ASUS_XGM_RESP_HDR_LEN = ASUS_XGM_RESP_PAYLOAD,
+};
+
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
 
@@ -217,6 +241,13 @@ struct asus_xgm_led {
 	struct hid_device *hdev;
 };
 
+struct asus_xgm_info {
+	char mainboard[ASUS_XGM_INFO_LEN];
+	char serial[ASUS_XGM_INFO_LEN];
+	char model[ASUS_XGM_INFO_LEN];
+	char part_number[ASUS_XGM_INFO_LEN];
+};
+
 struct asus_touchpad_info {
 	int max_x;
 	int max_y;
@@ -296,6 +327,7 @@ struct asus_drvdata {
 	struct asus_hid_listener listener;
 	bool fn_lock;
 	struct asus_xgm_led *xgm_led;
+	struct asus_xgm_info *xgm_info;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -4924,6 +4956,169 @@ static int asus_battery_probe(struct hid_device *hdev)
 	return ret;
 }
 
+/**
+ * asus_xgm_query() - Run a query command against an XG Mobile station
+ * @hdev: HID device
+ * @subcmd: query sub-command
+ * @buf: buffer to store the answer in
+ * @buf_size: size of @buf
+ *
+ * Windows re-sends the "ASUS Tech.Inc." unlock before every command
+ * burst, so do the same.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int asus_xgm_query(struct hid_device *hdev, u8 subcmd,
+			  u8 *buf, size_t buf_size)
+{
+	const u8 unlock[] = {
+		FEATURE_KBD_LED_REPORT_ID2,
+		'A', 'S', 'U', 'S', ' ', 'T', 'e', 'c', 'h', '.', 'I', 'n', 'c', '.'
+	};
+	const u8 cmd[] = { FEATURE_KBD_LED_REPORT_ID2, ASUS_XGM_CMD_QUERY, subcmd };
+	int ret;
+
+	ret = asus_kbd_set_report(hdev, unlock, sizeof(unlock));
+	if (ret < 0)
+		return ret;
+
+	ret = asus_kbd_set_report(hdev, cmd, sizeof(cmd));
+	if (ret < 0)
+		return ret;
+
+	return asus_kbd_get_report(hdev, FEATURE_KBD_LED_REPORT_ID2, buf, buf_size);
+}
+
+/**
+ * asus_xgm_info_assign() - Copy an identity field up to its ';'
+ * terminator
+ * @dst: destination buffer
+ * @dst_len: size of @dst, including the trailing NUL
+ * @src: start of the field inside the identity string
+ * @src_len: number of bytes available at @src
+ *
+ * Copies up to @dst_len - 1 bytes from @src, stopping at the first ';'
+ * field separator, and NUL terminates @dst.
+ */
+static void asus_xgm_info_assign(char *dst, size_t dst_len,
+				 const char *src, size_t src_len)
+{
+	const char *sep = strnchr(src, src_len, ';');
+	size_t n = sep ? (size_t)(sep - src) : src_len;
+
+	if (n >= dst_len)
+		n = dst_len - 1;
+
+	memcpy(dst, src, n);
+	dst[n] = '\0';
+}
+
+/**
+ * asus_xgm_take_field() - Copy one tagged field out of the identity string
+ * @dst: destination buffer
+ * @dst_len: size of @dst, including the trailing NUL
+ * @identity: identity string returned by the station
+ * @identity_len: number of bytes available at @identity
+ * @tag: field tag, including the colon
+ *
+ * A tag that is absent leaves @dst untouched.
+ */
+static void asus_xgm_take_field(char *dst, size_t dst_len,
+				const char *identity, size_t identity_len,
+				const char *tag)
+{
+	size_t tag_len = strlen(tag);
+	const char *found = strnstr(identity, tag, identity_len);
+	size_t value_off;
+
+	if (!found)
+		return;
+
+	value_off = (found - identity) + tag_len;
+	if (value_off > identity_len)
+		return;
+
+	asus_xgm_info_assign(dst, dst_len, identity + value_off,
+			     identity_len - value_off);
+}
+
+/**
+ * asus_xgm_get_identity() - Query the identity of an XG Mobile station
+ * @hdev: HID device
+ * @info: identity structure to fill in
+ *
+ * The identity query answers with a NUL terminated string of the form
+ * "MB:<mainboard>;SN:<serial>;PRO:<model>;PNUM:<part number>;", which is
+ * split into the fields of @info. The model field is mandatory: a station
+ * that does not report one is treated as absent.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int asus_xgm_get_identity(struct hid_device *hdev,
+				 struct asus_xgm_info *info)
+{
+	size_t len = asus_report_len(hdev, FEATURE_KBD_LED_REPORT_ID2);
+	const char *payload;
+	size_t payload_len;
+	int ret;
+
+	if (!len)
+		return -EINVAL;
+
+	u8 *buf __free(kfree) = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = asus_xgm_query(hdev, ASUS_XGM_QUERY_IDENTITY, buf, len);
+	if (ret < 0)
+		return ret;
+
+	if (len <= ASUS_XGM_RESP_HDR_LEN ||
+	    buf[ASUS_XGM_RESP_OPCODE] != ASUS_XGM_CMD_QUERY ||
+	    buf[ASUS_XGM_RESP_SUBCMD] != ASUS_XGM_QUERY_IDENTITY)
+		return -ENODEV;
+
+	payload = (const char *)buf + ASUS_XGM_RESP_PAYLOAD;
+	payload_len = strnlen(payload, len - ASUS_XGM_RESP_HDR_LEN);
+	if (!payload_len)
+		return -ENODEV;
+
+	asus_xgm_take_field(info->mainboard, sizeof(info->mainboard),
+			    payload, payload_len, ASUS_XGM_TAG_MAINBOARD);
+	asus_xgm_take_field(info->serial, sizeof(info->serial),
+			    payload, payload_len, ASUS_XGM_TAG_SERIAL);
+	asus_xgm_take_field(info->model, sizeof(info->model),
+			    payload, payload_len, ASUS_XGM_TAG_MODEL);
+	asus_xgm_take_field(info->part_number, sizeof(info->part_number),
+			    payload, payload_len, ASUS_XGM_TAG_PART);
+
+	if (!info->model[0])
+		return -ENODEV;
+
+	return 0;
+}
+
+static const char * const asus_xgm_models[] = { "GC31", "GC32", "GC33" };
+
+/**
+ * asus_xgm_is_supported_model() - Check that a station is supported
+ * @info: identity of the station
+ *
+ * The supported families are the GC31, GC32 and GC33 stations.
+ *
+ * Return: true if the reported model belongs to one of the supported
+ * families, false otherwise.
+ */
+static bool asus_xgm_is_supported_model(const struct asus_xgm_info *info)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(asus_xgm_models); i++)
+		if (strncmp(info->model, asus_xgm_models[i],
+			    strlen(asus_xgm_models[i])) == 0)
+			return true;
+
+	return false;
+}
+
 static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
 {
 	const u8 buf[] = { FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00 };
@@ -5190,14 +5385,49 @@ static void asus_initialize_reports(struct hid_device *hdev)
 
 static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 {
+	struct asus_xgm_info *info;
 	const char *name;
-	int ret;
+	int attempt, ret;
+
+	info = devm_kzalloc(&hdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	/*
+	 * The station reports its identity through the query protocol: the
+	 * reported model decides whether the LED interface is registered.
+	 * The LED name is that model, then the bus identity. One missed
+	 * transfer used to leave that LED unregistered, so try three times
+	 * and wait a second between attempts.
+	 */
+	for (attempt = 0; attempt < 3; attempt++) {
+		ret = asus_xgm_get_identity(hdev, info);
+		if (!ret)
+			break;
+		if (attempt < 2)
+			ssleep(1);
+	}
+	if (ret < 0) {
+		hid_warn(hdev, "Failed to query XG Mobile identity: %d\n", ret);
+		return 0;
+	}
+
+	hid_info(hdev, "XG Mobile: model %s, serial %s\n",
+		 info->model, info->serial);
+
+	if (!asus_xgm_is_supported_model(info)) {
+		hid_warn(hdev, "Unsupported XG Mobile model %s\n", info->model);
+		return 0;
+	}
+
+	drvdata->xgm_info = info;
 
 	drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
 	if (drvdata->xgm_led == NULL)
 		return -ENOMEM;
 
-	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
+	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s-%s:led",
+			      info->model,
 			      strlen(hdev->uniq) ? hdev->uniq : dev_name(&hdev->dev));
 
 	if (name == NULL) {
-- 
2.47.3

