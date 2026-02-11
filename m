Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C362D877F
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831269; cv=none; b=behkWJZ1LEHjRtWRQHU5RbIs4wxchCoyXUB3QcKq2FWkYRYPr55DNrzhvC5mvab9loSAoTTuQfERIS2wjvCL62fD6Ls+PICv4xNby8YSkKSHVfzeSfCL/yqEJoKBH+K3c4q3zClHvbm02BS1Lz4xHfvI4WboniHD2w5mD/pbx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831269; c=relaxed/simple;
	bh=BOtqzINSJkvVF3BJ+I9/SEpyPvXjE1wD/Pgxwmr4TOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMANWAXJSV4Xfbhw+jjXIiYg/w+Op8KnbHnopOYpq3PM2SDeYLGQ6aKdS6Uo3yJe0wNS8woLFndes7pukCcgpiuj+8XIDa63afaqd4GXpBJmq0sry/OoQaJNbspW909owEvhEMAsIj2o3P990aRkmZL8CWGW+TT0FNcqQTtrcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4cRNUhO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4cRNUhO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48327b8350dso49664935e9.1
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770831266; x=1771436066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NRnArFJ4FK2jOO4FMkxgZZsssccfLs2sPAF2qNLKg8=;
        b=K4cRNUhOknV6Whnku2Wpi8uY3TAaCiw4iHVT8Uwa/vlGNOKcdO/HH7R4v21mqGTioq
         tTTGGc3/13adKckDLv2RRUFyAJInIdPHCRPMBQ7SadRXphrVIeMW8CvYpipxkm4f88bm
         TuXA9jNF9WKkWzy5a7aGXQbhpF82zdyNInLJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831266; x=1771436066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4NRnArFJ4FK2jOO4FMkxgZZsssccfLs2sPAF2qNLKg8=;
        b=cRro7apQbjo5ye76cLyOu1J//TEn5smt/tcQES6CjiW9e1pLWHGiOUcGB7gDp6oUtL
         twB4XkIHyr/kBe18PzSG3X2yXWA/aj4P93kgzw4b7H+CItu0EADH4VaDDEGGjyISb8si
         pdRJyaHYuXQVxmMJDU46X5rl0bFypjFyQj9fW7gEdqMmLdsqG2trRjDSUoHxtlcDRn9T
         VkaMCRFLl3MVzKb/V2ouaoiMcaG4tids8Qaxvr7lIMP24h9CxcaBjQAf3HWlYeYpreTz
         tOTE+iik9ViHyxU/qH0KyLh5M30BsNm6Ughd5kLyd65IhYvCKMIzXCTbzK/cXptuADoX
         EcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZwuVq8L3waU1Bv+O5d24i6E4qDcxdxQrMdOsdRZLCelaQrlvBUA6P5mwo+m/trnJm5xbYcOue4+lqfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04chtaHIfl3yzYb+e/5NWQM5vbtfDTwhBbmzPUNpHMlUcmVCw
	3LscmGiXz/GPbPi1bwbhz1yM03PsXW+E7xYjpgrdLZqfi3OyrDJI6uXeMGmS9Eag4Q==
X-Gm-Gg: AZuq6aJZEPMHOX5GCALb7Tr+wgf9IMmldiK+qglc6SnJEFuhdZnwJRlZVx7NbP2i8uw
	f5Jrnbge3jYeU2k5IBTWvG2B6352693yRI+Yd6BPpw0ZXjmBycBEJgxgOoztfPypNwvL/MYF632
	B1SkkaemQaZysXkOUcokcJozx/DvxBQPk/SBkcrPbpYWUEcUgwXu3KLVNd+JFzHupQz+tChvVDb
	d02PEQItb1A9pFkn9MhfOaHksY5ZnZWsArBV1IdlmsZnaVyN0z2wnXUo0Bzm0X2qikovh0S8e0e
	RsdGY3NUkBZ+NsvwMY2ktWrq4N0DTTs7Vsd8bT5co/T6OwMhjk8HO5JDZw5ZPZQmdfMWk7IxdC1
	8byLHa87ua14IROJMwVKppCHQw0/yxw9SMiA0saGoIIc193140eH+NwBugzFGQlpDu/H1G842IC
	egMxds4ex5xRodOWPE8P+9iYcwXGE=
X-Received: by 2002:a05:600c:1389:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-4835b92bd7dmr41041165e9.23.1770831266460;
        Wed, 11 Feb 2026 09:34:26 -0800 (PST)
Received: from balto-ws ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d50f24sm5885498f8f.14.2026.02.11.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:34:26 -0800 (PST)
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] Input: cros_ec_keyb - add function key support
Date: Wed, 11 Feb 2026 17:34:21 +0000
Message-ID: <20260211173421.1206478-3-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To: <20260211173421.1206478-1-fabiobaltieri@chromium.org>
References: <20260211173421.1206478-1-fabiobaltieri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for handling an Fn button and sending separate keycodes for
a subset of keys in the matrix defined in the upper half of the keymap.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 191 +++++++++++++++++++++++---
 1 file changed, 175 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 1c6b0461dc35..67022f92533d 100644
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
+ * @fn_key_pressed: tracks the function key status
+ * @fn_event_pending: tracks where any function key fired
  */
 struct cros_ec_keyb {
 	unsigned int rows;
@@ -61,6 +70,10 @@ struct cros_ec_keyb {
 	struct notifier_block notifier;
 
 	struct vivaldi_data vdata;
+
+	bool has_fn_map;
+	bool fn_key_pressed;
+	bool fn_event_pending;
 };
 
 /**
@@ -166,16 +179,103 @@ static bool cros_ec_keyb_has_ghosting(struct cros_ec_keyb *ckdev, uint8_t *buf)
 	return false;
 }
 
+/*
+ * Process a function key state change, send an event report if appropriate.
+ */
+static void cros_ec_keyb_process_fn_key(struct cros_ec_keyb *ckdev,
+					int row, int col, bool state)
+{
+	struct input_dev *idev = ckdev->idev;
+	int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
+
+	ckdev->fn_key_pressed = state;
+
+	if (state) {
+		ckdev->fn_event_pending = false;
+	} else if (!ckdev->fn_event_pending) {
+		/*
+		 * Send the original code if nothing else has been pressed
+		 * together with Fn.
+		 */
+		input_event(idev, EV_MSC, MSC_SCAN, pos);
+		input_report_key(idev, KEY_FN, true);
+		input_sync(idev);
+
+		input_event(idev, EV_MSC, MSC_SCAN, pos);
+		input_report_key(idev, KEY_FN, false);
+	}
+}
+
+/*
+ * Return the Fn code for a normal key row, col combination, optionally set a
+ * position code too.
+ */
+static unsigned int cros_ec_keyb_fn_code(struct cros_ec_keyb *ckdev,
+					 int row, int col, int *pos)
+{
+	struct input_dev *idev = ckdev->idev;
+	const unsigned short *keycodes = idev->keycode;
+	int fn_pos = MATRIX_SCAN_CODE(row + ckdev->rows, col, ckdev->row_shift);
+
+	if (pos)
+		*pos = fn_pos;
+
+	return keycodes[fn_pos];
+}
+
+/*
+ * Process the new state for a single key.
+ */
+static void cros_ec_keyb_process_one(struct cros_ec_keyb *ckdev,
+				     int row, int col, bool state)
+{
+	struct input_dev *idev = ckdev->idev;
+	const unsigned short *keycodes = idev->keycode;
+	int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
+	unsigned int code = keycodes[pos];
+
+	dev_dbg(ckdev->dev, "changed: [r%d c%d]: byte %02x\n", row, col, state);
+
+	if (ckdev->has_fn_map) {
+		int fn_pos;
+		unsigned int fn_code = cros_ec_keyb_fn_code(ckdev, row, col, &fn_pos);
+
+		if (code == KEY_FN)
+			return cros_ec_keyb_process_fn_key(ckdev, row, col, state);
+
+		if (!state) {
+			if (test_bit(fn_code, idev->key)) {
+				code = fn_code;
+				pos = fn_pos;
+			} else if (test_bit(code, idev->key)) {
+				/* nothing to do */
+			} else {
+				/* Discard, key press code was not sent */
+				return;
+			}
+		} else if (ckdev->fn_key_pressed) {
+			ckdev->fn_event_pending = true;
+
+			if (!fn_code)
+				return;
+
+			code = fn_code;
+			pos = fn_pos;
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
@@ -192,20 +292,13 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 
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
+			cros_ec_keyb_process_one(ckdev, row, col, new_state);
 		}
 		ckdev->old_kb_state[col] = kb_state[col];
 	}
@@ -582,6 +675,63 @@ static void cros_ec_keyb_parse_vivaldi_physmap(struct cros_ec_keyb *ckdev)
 	ckdev->vdata.num_function_row_keys = n_physmap;
 }
 
+/* Returns true if there is a KEY_FN code defined in the normal keymap */
+static bool cros_ec_keyb_has_fn_key(struct cros_ec_keyb *ckdev)
+{
+	struct input_dev *idev = ckdev->idev;
+	const unsigned short *keycodes = idev->keycode;
+
+	for (int row = 0; row < ckdev->rows; row++) {
+		for (int col = 0; col < ckdev->cols; col++) {
+			int pos = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
+
+			if (keycodes[pos] == KEY_FN)
+				return true;
+		}
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
+	if (!cros_ec_keyb_has_fn_key(ckdev))
+		return false;
+
+	for (int row = 0; row < ckdev->rows; row++) {
+		for (int col = 0; col < ckdev->cols; col++) {
+			if (cros_ec_keyb_fn_code(ckdev, row, col, NULL) != 0)
+				return true;
+		}
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
@@ -603,6 +753,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
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
@@ -631,11 +787,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	idev->id.version = 1;
 	idev->id.product = 0;
 	idev->dev.parent = dev;
+	idev->setkeycode = cros_ec_keyb_setkeycode;
 
 	ckdev->ghost_filter = device_property_read_bool(dev,
 					"google,needs-ghost-filter");
 
-	err = matrix_keypad_build_keymap(NULL, NULL, ckdev->rows, ckdev->cols,
+	err = matrix_keypad_build_keymap(NULL, NULL, ckdev->rows * 2, ckdev->cols,
 					 NULL, idev);
 	if (err) {
 		dev_err(dev, "cannot build key matrix\n");
@@ -650,6 +807,8 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	cros_ec_keyb_compute_valid_keys(ckdev);
 	cros_ec_keyb_parse_vivaldi_physmap(ckdev);
 
+	ckdev->has_fn_map = cros_ec_keyb_has_fn_map(ckdev);
+
 	err = input_register_device(ckdev->idev);
 	if (err) {
 		dev_err(dev, "cannot register input device\n");
-- 
2.53.0.239.g8d8fc8a987-goog

