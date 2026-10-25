Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972390;
	b=HsraO7KhBuJwKP+iu0fGtk8OehtBEV8mMmZQgKKo3oMeOcDtu0AXYyExdABSLO6kSbok
	 66p7SHpqMVKBMsMx1T63eAOudvsavXvQiDikGwyPPROR0oT1PveZ2QxZKGv03iw6E51/4
	 9AXO+69dIxFfXx6tC2jbLXniE/fchH5IXQa0RZbdbAsrr6KSyiMxi9RmYOZ+f9OHpApQX
	 uIOIKi3qsmAQQoWfspmqjIyu894FAkHWEhfF9JPeZbQBVD+JFBh/nNwTjXMWTjAu88lIL
	 lo4nepWkzwEspHb+bI1V56u97vlGBxsalNy5dVHZWyMKGNkp06kyat18RkOcIo4Pemg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972390;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=81aVzsRhIxyvHrijYkBfmYhJCAQ6H9fni/47H/TxpOM=;
	b=wqCxpwHL4bsa5SFpJoUTCnkNDtQ85swzZ32iHIKGBXUwA92ZSdQCpOpC0UErnvsmBDeA
	 mpoQPNHL4km4/e1UNSEtQuAYKFo9g9PjJbfOcjXuxqyExNgx9XEPxdUvHjf3hq24ELTQG
	 L3/pHwLPAnj5VrAHbMQnk9t7HHK6Bo7S2nf+uztBk3LsUENLKhjue2I3ICCz9rm7tStm0
	 Xn949tJgJhczayn6feMKyKgiocti40pVGaDBS6B9KpYOKRGsbyKEf3XDUHuXX/VzhDzfs
	 1XIAYZmk5edVBFzfFwehpzhOxl/eVUEGB5UYrILGR6V5sRfcGQygHDDklG8xNzWK1pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="kE/lKOK3";
	arc=none smtp.remote-ip=95.215.58.119
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF660A5BC2
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 23:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADF660A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kE/lKOK3
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dxlZbiIEkXKFcuOlPf4JXHYhH/NjTKA8GtaFDY2kMA8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792972387; v=1; x=1793577187;
 b=kE/lKOK3/AxhwZXZ2J5QBLdTNXdxwB+KlsJ6yWuXhcaZq1Kn2zXuShxHwHiai7/WBLF7cUuw
 NtcvtKH8buMBLObNcLP03QnzT4sYSX7zYXW0U00sMTxt6xUBKgtmIkwuKA5NhqXIWsClbkXKe1v
 ooqwMN+lj/EzOs7XhfPsG8Zk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4bf86ce714a13f90;
	Sun, 25 Oct 2026 23:53:07 +0000
X-Mizu-Trace-ID: 4bf86ce714a13f90
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
Subject: [PATCH v11 15/18] HID: asus: size ally gamepad commands from the HID report descriptor
Date: Sun, 25 Oct 2026 23:52:28 +0000
Message-ID: <20261025235232.129945-16-denis.benato@linux.dev>
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

ally_alloc_cmd() hardcodes ROG_ALLY_REPORT_SIZE both for the command
buffer allocation and, at every call site, for the transfer length, and
mcu_request_version() uses it for the size of the MCU version response.
The gamepad protocol speaks through the 0x5A feature report, whose
transfer length is declared by the HID report descriptor of the device
at hand, and the MCU version is read back from the 0x0d feature report
the same way.

Size both from the report descriptor instead:

- ally_alloc_cmd() takes the HID device, resolves the length of the
  0x5A feature report through asus_report_len() and returns it to the
caller;
- every caller sends and receives with the returned length instead of
the hardcoded ROG_ALLY_REPORT_SIZE;
- ally_set_button_mapping() declares the size of its mapping block
(the length byte at buf[4] plus the four 11-byte entries, up to
buf[48]) so a descriptor with a short 0x5A report is rejected by the
fit check instead of being overflowed by the fixed-offset writes;
- mcu_request_version() sizes the 0x0d response buffer with
asus_report_len() and gives up when the device does not declare the
report at all; ROG_ALLY_REPORT_SIZE has no users left and is removed.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 103 +++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f438cad13264..e444cad85b32 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -69,7 +69,6 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_XGM_QUERY_VERSION 0x03
 #define ASUS_XGM_INFO_LEN 32
 
-#define ROG_ALLY_REPORT_SIZE 64
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
 
@@ -943,28 +942,33 @@ static int ally_gamepad_send_receive_packet(struct ally_handheld *ally,
 
 /**
  * ally_alloc_cmd() - Construct a command buffer for the gamepad
+ * @hdev: HID device the command is built for
  * @cmd: Command code to send
  * @payload: Optional payload data to include in the command
  * @payload_size: Size of the payload data
+ * @size: Where to store the length of the allocated buffer
  *
- * The constructed buffer is 64 bytes long, and it is the caller
- * responsibility to free the buffer using kfree().
+ * The buffer is sized after the feature report the device declares for
+ * the gamepad commands, and it is the caller responsibility to free the
+ * buffer using kfree().
  *
  * Return: the newly allocated buffer containing the command, or NULL on
  * allocation failure or if the payload would not fit in the report
  */
-static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
+static u8 *ally_alloc_cmd(struct hid_device *hdev, u8 cmd, const u8 *payload,
+			  u8 payload_size, size_t *size)
 {
+	size_t hw_len = asus_report_len(hdev, HID_ALLY_SET_REPORT_ID);
 	u8 *hidbuf;
 
 	/*
 	 * The payload is written after the 4-byte command header:
 	 * reject one that would spill past the end of the report.
 	 */
-	if (payload_size > ROG_ALLY_REPORT_SIZE - 4)
+	if (hw_len < 4 || payload_size > hw_len - 4)
 		return NULL;
 
-	hidbuf = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
+	hidbuf = kzalloc(hw_len, GFP_KERNEL);
 
 	if (!hidbuf)
 		return NULL;
@@ -977,6 +981,8 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
 	if (payload_size > 0 && payload)
 		memcpy(&hidbuf[4], payload, payload_size);
 
+	*size = hw_len;
+
 	return hidbuf;
 }
 
@@ -992,15 +998,17 @@ static bool ally_check_capability(struct hid_device *hdev, struct ally_handheld
 				  enum ally_command_codes check_cmd)
 {
 	u8 payload[] = { 0x00 };
+	size_t buf_len;
 	int ret;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(check_cmd, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, check_cmd, payload,
+					       sizeof(payload), &buf_len);
 	if (!buf) {
 		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
 		return false;
 	}
 
-	ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_receive_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to check capability 0x%02x: %d\n", check_cmd, ret);
 		return false;
@@ -1043,16 +1051,18 @@ static int ally_set_xbox_controller(struct hid_device *hdev,
 				    struct ally_config *cfg, bool enabled)
 {
 	u8 payload[] = { enabled ? 0x01 : 0x00 };
+	size_t buf_len;
 	int ret;
 
 	if (!cfg || !cfg->xbox_controller_support)
 		return -EOPNOTSUPP;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_XBOX_CONTROLLER, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_XBOX_CONTROLLER,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set Xbox controller mode: %d\n", ret);
 		return ret;
@@ -1160,6 +1170,7 @@ static DEVICE_ATTR_RW(xbox_controller);
 static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *hdev, u8 mode)
 {
 	u8 payload[] = { mode };
+	size_t buf_len;
 	int ret;
 
 	if (mode < ALLY_GAMEPAD_MODE_GAMEPAD ||
@@ -1168,11 +1179,12 @@ static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *
 		return -EINVAL;
 	}
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_GAMEPAD_MODE, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_GAMEPAD_MODE,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set gamepad mode: %d\n", ret);
 		return ret;
@@ -1609,13 +1621,15 @@ static int ally_set_vibration_intensity(struct ally_handheld *ally,
 					struct hid_device *hdev, u8 left, u8 right)
 {
 	const u8 data[] = { left, right };
+	size_t buf_len;
 	int ret;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_VIBRATION_INTENSITY, data, sizeof(data));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_VIBRATION_INTENSITY,
+					       data, sizeof(data), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set vibration intensity: %d\n", ret);
 		return ret;
@@ -1777,13 +1791,15 @@ static int ally_set_joystick_thresholds(struct ally_handheld *ally,
 					u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
 {
 	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	size_t buf_len;
 	int ret;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_JOYSTICK_DEADZONE, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_JOYSTICK_DEADZONE,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set joystick ranges: %d\n", ret);
 		return ret;
@@ -2125,6 +2141,7 @@ static int ally_set_anti_deadzone(struct ally_handheld *ally,
 				  u8 left_adz, u8 right_adz)
 {
 	const u8 payload[] = { left_adz, right_adz };
+	size_t buf_len;
 	int ret;
 
 	if (!cfg->anti_deadzone_support) {
@@ -2132,11 +2149,12 @@ static int ally_set_anti_deadzone(struct ally_handheld *ally,
 		return -EOPNOTSUPP;
 	}
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_ANTI_DEADZONE, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_ANTI_DEADZONE,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set anti-deadzone values: %d\n", ret);
 		return ret;
@@ -2320,13 +2338,15 @@ static int ally_set_trigger_ranges(struct ally_handheld *ally,
 				   u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
 {
 	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
+	size_t buf_len;
 	int ret;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_TRIGGER_RANGE, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_TRIGGER_RANGE,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set trigger ranges: %d\n", ret);
 		return ret;
@@ -2676,13 +2696,15 @@ static int ally_set_joystick_resp_curve(struct ally_handheld *ally,
 		curve->entry_3.move, curve->entry_3.resp,
 		curve->entry_4.move, curve->entry_4.resp
 	};
+	size_t buf_len;
 	int ret;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_RESP_CURVE, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_RESP_CURVE,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0)
 		return ret;
 
@@ -3039,13 +3061,15 @@ static int ally_set_turbo_params(struct ally_handheld *ally,
 		turbo->btn_m1.turbo,
 		turbo->btn_m1.toggle,
 	};
+	size_t buf_len;
 	int ret;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_TURBO_PARAMS, payload, sizeof(payload));
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_TURBO_PARAMS,
+					       payload, sizeof(payload), &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	ret = ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 	if (ret < 0) {
 		hid_err(hdev, "Failed to set turbo parameters: %d\n", ret);
 		return ret;
@@ -3318,12 +3342,18 @@ static int ally_set_button_mapping(struct hid_device *hdev, struct ally_handheld
 	 */
 	u8 macro_bytes[11] = {0};
 	u8 btn_bytes[11] = {0};
+	size_t buf_len;
 
 	if (!mapping || !mapping->first.remap || !mapping->first.macro ||
 	    !mapping->second.remap || !mapping->second.macro)
 		return -EINVAL;
 
-	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_MAPPING, NULL, 0);
+	/*
+	 * The mapping block spans buf[4]..buf[48]: give ally_alloc_cmd() its
+	 * size so the fit check protects the fixed-offset writes below.
+	 */
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_MAPPING, NULL,
+					       1 + 0x2C, &buf_len);
 	if (!buf)
 		return -ENOMEM;
 
@@ -3439,7 +3469,7 @@ static int ally_set_button_mapping(struct hid_device *hdev, struct ally_handheld
 		memcpy(&buf[38], macro_bytes, 11);
 	}
 
-	return ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	return ally_gamepad_send_packet(ally, hdev, buf, buf_len);
 }
 
 /**
@@ -4156,14 +4186,16 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
 static int ally_gamepad_check_ready(struct ally_handheld *ally, struct hid_device *hdev)
 {
 	u8 payload[] = { 0x00 };
+	size_t buf_len;
 	int ret;
 
 	for (int i = 0; i < HID_ALLY_READY_MAX_TRIES; i++) {
-		u8 *buf __free(kfree) = ally_alloc_cmd(CMD_CHECK_READY, payload, sizeof(payload));
+		u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_CHECK_READY,
+						       payload, sizeof(payload), &buf_len);
 		if (!buf)
 			return -ENOMEM;
 
-		ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+		ret = ally_gamepad_send_receive_packet(ally, hdev, buf, buf_len);
 		if (ret < 0) {
 			hid_dbg(hdev, "ROG Ally check %d/%d failed: %d\n", i,
 				HID_ALLY_READY_MAX_TRIES, ret);
@@ -5796,10 +5828,14 @@ static int mcu_parse_version_string(const u8 *response, size_t response_size)
 
 static int mcu_request_version(struct hid_device *hdev)
 {
-	u8 *response __free(kfree) = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
+	size_t hw_len = asus_report_len(hdev, FEATURE_REPORT_ID);
 	const u8 request[] = { 0x5a, 0x05, 0x03, 0x31, 0x00, 0x20 };
 	int ret;
 
+	if (!hw_len)
+		return -EINVAL;
+
+	u8 *response __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
 	if (!response)
 		return -ENOMEM;
 
@@ -5807,17 +5843,16 @@ static int mcu_request_version(struct hid_device *hdev)
 	if (ret < 0)
 		return ret;
 
-	ret = hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response,
-				ROG_ALLY_REPORT_SIZE, HID_FEATURE_REPORT,
-				HID_REQ_GET_REPORT);
+	ret = hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response, hw_len,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0)
 		return ret;
 
-	ret = mcu_parse_version_string(response, ROG_ALLY_REPORT_SIZE);
+	ret = mcu_parse_version_string(response, hw_len);
 	if (ret < 0) {
 		pr_err("Failed to parse MCU version: %d\n", ret);
 		print_hex_dump(KERN_ERR, "MCU: ", DUMP_PREFIX_NONE,
-			      16, 1, response, ROG_ALLY_REPORT_SIZE, false);
+			       16, 1, response, hw_len, false);
 	}
 
 	return ret;
-- 
2.47.3

