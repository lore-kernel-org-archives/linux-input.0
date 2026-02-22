Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090715464D
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720647; cv=none; b=HBAqKT5aO8kiZdt/erLYXtjwSZlWJ8GU+Xw4J0T8mlGeNUzpiZUpHfyVxD5VpGiADOUfvOMInOrUOJESQh3wteRSacfU7Xx4LIcxWYVXdWLx/qE9cSFnnZO6w8XcLz+cit7QmN9kxtqWU7CUZZDEoeZWsVUKAc16IeMtoLoW0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720647; c=relaxed/simple;
	bh=9PIvHtnQQPX0geRK/dmhjO3klHd/KaXG584rzQOB/JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7GFchy4lHOz9+hsPGAgSxPcWBtZrn0ckwYnARRQ+LqM2Dw62/30a5hDbJHpt79Nd47W93e4QmqOaOt8csRg5WFcBTQIWIa/ixHgGpxxyUDxx7k+CiA2a6xgdDIcVrC/bFB0zYf9xghM+FEv3ZSVRlUQs4Zhd2sNWKL1rXSUmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOq4cbWf; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOq4cbWf"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3305091eec.1
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720645; x=1772325445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sARAzmZJKwF06xGFK5wTcr5wd7Z7a524dohAqEFNZkY=;
        b=LOq4cbWfqwyVhARh9QilB7ngz/rN5DAhEERux20+wELEQMUY9s+6bmKwnpfZGlp4IQ
         s2/174eCRIOhk0lJhUtmHefvn4PVlKzpxctoq/cQ2k6Q5ffslFHkryW9kpBAP9xFOEo3
         ZqGzlIWeNA34PPLfPjrjFWGhUWluSZbWzbZJ+H00HGAXcvxnTlUN1I21KahtLN04wLtC
         3LLffFAh3yVT90KHwLRjqvTiWgTLuSq4m6hCuVJwQTufLCf+I+U9B4Q4Gyj1Mh0SSltR
         NOIt6fbNWxOgMGBsGBrVtTWAVWphuN347PvF5uxgzZ3jOykWde9mFhiT9+RD59jje/9S
         SJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720645; x=1772325445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sARAzmZJKwF06xGFK5wTcr5wd7Z7a524dohAqEFNZkY=;
        b=NdWa63700peznbDtRNVM9Pc0bSdeMF5j0KlkWRGm6HiUqC8vztkVlMr2p+nxpFl4pd
         koce3L6u290km164gQRDGgri31B+yMp/i8epn38X1DNYP1yej5XtG8Nv446iQZbiPpRo
         SneRqWgi73K5/1XgwCOcmZt5XZI12S4WfWX60lAWh1iaIpdJgBWzPkRmgGLZt3UnnKl9
         w+Gq+a+IMGY9oPU3U0PFQFVqrUPEJ07Z7QZnAFquP3zWNnxfGIEuGhZ97zTbEPgGA1ga
         FJOs71q/uKEieZRfb2h+Kf2A+dMy65Dl2DwlvvLylq4I4sjG5NpPVIdIvZSG8yayIlm5
         Ofzw==
X-Forwarded-Encrypted: i=1; AJvYcCXae8JfTlx6rxszF57z1nku5MH5+7YVCopTYSPteSvLeoedggGlTVPrBoVYhEk1DI/OBn3cE/JGxV2cCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsvyalDUxkMNQ7yFeEZTISMzR30VxuE/+bqjSUwBFXlK7DuCD
	L8HSqHAPbBSIZvqX0amDQ005pkeVkbbnqZ4X1HWGTKpaaU18QqGjj+IT
X-Gm-Gg: AZuq6aJJRorWcojAti6Udbi990xK9jmjo+ba6ZfMGpWsF7A/uWmWUz6G6Nps0rKG/79
	aBHVBM9Z/3djeebQTFiMjGkENJrF9zI53azRVjrEsnMhzS6LMl33P2w0eBlI/yXhhaSmSY62Xsb
	4QYCsecHDeCMiV3tc6r2Y9Vvsq7Pr6A70iRySc+hdQDu1JP15uVy+4iTrUNySqRPFpwoO7t81BD
	pQrYvh8HsgD/M5/+Mm6TJ/qLXjmtbkmUmok3OEo2QiZFdatE9/XItL/LdxNBZbrFVYLdz+2xpkP
	DO3Z0u/Xpr8rrObDkhvlDcvc0lwaI5prYWdRI2Wn4JWMvn0YOp04agfHzxLqWNULqCPnrrgXLAv
	34U+/diMOoyAD585zDTbqabHD/U/2rBuVlebZKRCrWLOJeMNKXivtEuHKYWBHUdN/JjetRx5xu2
	GwLUeGybEpiLyafvUzWf/Kl9YuU3aPY8hNOAwPkr6AzGHYMBkyHwMfKJLn4UnfH9jndm+MCH3Z9
	sJnF0DZ79cwJA==
X-Received: by 2002:a05:7300:cb13:b0:2ba:9350:d8ba with SMTP id 5a478bee46e88-2bd7b9eddb3mr1785735eec.10.1771720644976;
        Sat, 21 Feb 2026 16:37:24 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:24 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] Input: cros_ec_keyb - add function key support
Date: Sat, 21 Feb 2026 16:37:10 -0800
Message-ID: <20260222003717.471977-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
In-Reply-To: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Baltieri <fabiobaltieri@chromium.org>

Add support for handling an Fn button and sending separate keycodes for
a subset of keys in the matrix defined in the upper half of the keymap.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Link: https://patch.msgid.link/20260211173421.1206478-3-fabiobaltieri@chromium.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 182 +++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 066aaa87d93f..bdbfd219f2e8 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -29,6 +29,12 @@
 
 #include <linux/unaligned.h>
 
+/*
+ * Maximum size of the normal key matrix, this is limited by the host command
+ * key_matrix field defined in ec_response_get_next_data_v3
+ */
+#define CROS_EC_KEYBOARD_COLS_MAX 18
+
 /**
  * struct cros_ec_keyb - Structure representing EC keyboard device
  *
@@ -44,6 +50,9 @@
  * @bs_idev: The input device for non-matrix buttons and switches (or NULL).
  * @notifier: interrupt event notifier for transport devices
  * @vdata: vivaldi function row data
+ * @has_fn_map: whether the driver uses an fn function-map layer
+ * @fn_active: tracks whether the function key is currently pressed
+ * @fn_combo_active: tracks whether another key was pressed while fn is active
  */
 struct cros_ec_keyb {
 	unsigned int rows;
@@ -61,6 +70,10 @@ struct cros_ec_keyb {
 	struct notifier_block notifier;
 
 	struct vivaldi_data vdata;
+
+	bool has_fn_map;
+	bool fn_active;
+	bool fn_combo_active;
 };
 
 /**
@@ -166,16 +179,89 @@ static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint8_t *buf)
 	return false;
 }
 
+static void cros_ec_emit_fn_key(struct input_dev *input, unsigned int pos)
+{
+	input_event(input, EV_MSC, MSC_SCAN, pos);
+	input_report_key(input, KEY_FN, true);
+	input_sync(input);
+
+	input_event(input, EV_MSC, MSC_SCAN, pos);
+	input_report_key(input, KEY_FN, false);
+}
+
+static void cros_ec_keyb_process_key_plain(struct cros_ec_keyb *ckdev,
+					   int row, int col, bool state)
+{
+	struct input_dev *idev = ckdev->idev;
+	const unsigned short *keycodes = idev->keycode;
+	int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
+
+	input_event(idev, EV_MSC, MSC_SCAN, pos);
+	input_report_key(idev, keycodes[pos], state);
+}
+
+static void cros_ec_keyb_process_key_fn_map(struct cros_ec_keyb *ckdev,
+					    int row, int col, bool state)
+{
+	struct input_dev *idev = ckdev->idev;
+	const unsigned short *keycodes = idev->keycode;
+	unsigned int pos, fn_pos;
+	unsigned int code, fn_code;
+
+	pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
+	code = keycodes[pos];
+
+	if (code == KEY_FN) {
+		ckdev->fn_active = state;
+		if (state) {
+			ckdev->fn_combo_active = false;
+		} else if (!ckdev->fn_combo_active) {
+			/*
+			 * Send both Fn press and release events if nothing
+			 * else has been pressed together with Fn.
+			 */
+			cros_ec_emit_fn_key(idev, pos);
+		}
+		return;
+	}
+
+	fn_pos = MATRIX_SCAN_CODE(row + ckdev->rows, col, ckdev->row_shift);
+	fn_code = keycodes[fn_pos];
+
+	if (state) {
+		if (ckdev->fn_active) {
+			ckdev->fn_combo_active = true;
+			if (!fn_code)
+				return; /* Discard if no Fn mapping exists */
+
+			code = fn_code;
+			pos = fn_pos;
+		}
+	} else {
+		/*
+		 * If the Fn-remapped code is currently pressed, release it.
+		 * Otherwise, release the standard code (if it was pressed).
+		 */
+		if (fn_code && test_bit(fn_code, idev->key)) {
+			code = fn_code;
+			pos = fn_pos;
+		} else if (!test_bit(code, idev->key)) {
+			return; /* Discard, key press code was not sent */
+		}
+	}
+
+	input_event(idev, EV_MSC, MSC_SCAN, pos);
+	input_report_key(idev, code, state);
+}
 
 /*
  * Compares the new keyboard state to the old one and produces key
- * press/release events accordingly.  The keyboard state is 13 bytes (one byte
- * per column)
+ * press/release events accordingly.  The keyboard state is one byte
+ * per column.
  */
 static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 			 uint8_t *kb_state, int len)
 {
-	struct input_dev *idev = ckdev->idev;
 	int col, row;
 	int new_state;
 	int old_state;
@@ -192,20 +278,19 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 
 	for (col = 0; col < ckdev->cols; col++) {
 		for (row = 0; row < ckdev->rows; row++) {
-			int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
-			const unsigned short *keycodes = idev->keycode;
-
 			new_state = kb_state[col] & (1 << row);
 			old_state = ckdev->old_kb_state[col] & (1 << row);
-			if (new_state != old_state) {
-				dev_dbg(ckdev->dev,
-					"changed: [r%d c%d]: byte %02x\n",
-					row, col, new_state);
-
-				input_event(idev, EV_MSC, MSC_SCAN, pos);
-				input_report_key(idev, keycodes[pos],
-						 new_state);
-			}
+
+			if (new_state == old_state)
+				continue;
+
+			dev_dbg(ckdev->dev, "changed: [r%d c%d]: byte %02x\n",
+				row, col, new_state);
+
+			if (ckdev->has_fn_map)
+				cros_ec_keyb_process_key_fn_map(ckdev, row, col, new_state);
+			else
+				cros_ec_keyb_process_key_plain(ckdev, row, col, new_state);
 		}
 		ckdev->old_kb_state[col] = kb_state[col];
 	}
@@ -583,6 +668,62 @@ static void cros_ec_keyb_parse_vivaldi_physmap(struct cros_ec_keyb *ckdev)
 	ckdev->vdata.num_function_row_keys = n_physmap;
 }
 
+/* Returns true if there is a KEY_FN code defined in the normal keymap */
+static bool cros_ec_keyb_has_fn_key(struct cros_ec_keyb *ckdev)
+{
+	const unsigned short *keycodes = ckdev->idev->keycode;
+	int i;
+
+	for (i = 0; i < MATRIX_SCAN_CODE(ckdev->rows, 0, ckdev->row_shift); i++) {
+		if (keycodes[i] == KEY_FN)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Returns true if there is a KEY_FN defined and at least one key in the fn
+ * layer keymap
+ */
+static bool cros_ec_keyb_has_fn_map(struct cros_ec_keyb *ckdev)
+{
+	struct input_dev *idev = ckdev->idev;
+	const unsigned short *keycodes = ckdev->idev->keycode;
+	int i;
+
+	if (!cros_ec_keyb_has_fn_key(ckdev))
+		return false;
+
+	for (i = MATRIX_SCAN_CODE(ckdev->rows, 0, ckdev->row_shift);
+	     i < idev->keycodemax; i++) {
+		if (keycodes[i] != KEY_RESERVED)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Custom handler for the set keycode ioctl, calls the default handler and
+ * recomputes has_fn_map.
+ */
+static int cros_ec_keyb_setkeycode(struct input_dev *idev,
+				   const struct input_keymap_entry *ke,
+				   unsigned int *old_keycode)
+{
+	struct cros_ec_keyb *ckdev = input_get_drvdata(idev);
+	int ret;
+
+	ret = input_default_setkeycode(idev, ke, old_keycode);
+	if (ret)
+		return ret;
+
+	ckdev->has_fn_map = cros_ec_keyb_has_fn_map(ckdev);
+
+	return 0;
+}
+
 /**
  * cros_ec_keyb_register_matrix - Register matrix keys
  *
@@ -604,6 +745,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	if (err)
 		return err;
 
+	if (ckdev->cols > CROS_EC_KEYBOARD_COLS_MAX) {
+		dev_err(dev, "keypad,num-columns too large: %d (max: %d)\n",
+			ckdev->cols, CROS_EC_KEYBOARD_COLS_MAX);
+		return -EINVAL;
+	}
+
 	ckdev->valid_keys = devm_kzalloc(dev, ckdev->cols, GFP_KERNEL);
 	if (!ckdev->valid_keys)
 		return -ENOMEM;
@@ -632,11 +779,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	idev->id.version = 1;
 	idev->id.product = 0;
 	idev->dev.parent = dev;
+	idev->setkeycode = cros_ec_keyb_setkeycode;
 
 	ckdev->ghost_filter = device_property_read_bool(dev,
 					"google,needs-ghost-filter");
 
-	err = matrix_keypad_build_keymap(NULL, ckdev->rows, ckdev->cols,
+	err = matrix_keypad_build_keymap(NULL, ckdev->rows * 2, ckdev->cols,
 					 NULL, idev);
 	if (err) {
 		dev_err(dev, "cannot build key matrix\n");
@@ -651,6 +799,8 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	cros_ec_keyb_compute_valid_keys(ckdev);
 	cros_ec_keyb_parse_vivaldi_physmap(ckdev);
 
+	ckdev->has_fn_map = cros_ec_keyb_has_fn_map(ckdev);
+
 	err = input_register_device(ckdev->idev);
 	if (err) {
 		dev_err(dev, "cannot register input device\n");
-- 
2.53.0.345.g96ddfc5eaa-goog

