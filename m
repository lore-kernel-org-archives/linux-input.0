Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5572F872
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720646; cv=none; b=BgxLS4mu+sNqvPvO+J36Fp2VxGCoGrXIjvoECDPKYoe73+kPChrP8zHNOIYAX5o4pIy3RlPYM7TO7IFEGKKpL2PWVFjDt+J2xMS0rx//LyVK7TTDE4lCRjYuDHNrtfZFCeaKngnkzqTnJfkQyS6QB9S/VkHegvWAnSJYQC+iO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720646; c=relaxed/simple;
	bh=hLvjMkh6hXEkiLWKyvozmQcSnbRn+eBjFoiwAf52Zm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGdmJuoI3GvTisTTPerT4rxQOzStHHuCIOZo7h3AAgQVcj6GqH7YwRv0Hssydn7tCx/Z8KzZtsgQ3HmKmiZJdZzVTewV6TrWiC05BHAKcRFrYgscbZHsc+92JdOSck4pgG2vlWw5yq5BfhISdnuXTNLE/7mbjf+uAwa4QE7b7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk9zY7/g; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk9zY7/g"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3953232eec.1
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720644; x=1772325444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9VQyZPUVBKtquLyDlkewfzJ1/s13aoNaQBA0/wQfDo=;
        b=Wk9zY7/gryD+kX/pdvBie5RetaFOI5a51kE0taBDOHOXSNoSyxAhy/npGCew/Sdzvp
         IjVgxRPlyZISKAYTZS49WPAn5lPLD/l37LxEH+NanRB0r4pGB9g2IUOX2qEt3py8l3J/
         rrcat1VMRiQ6XO3HJlghSDMyN61g8oW4UUWVmtbCg/9q/48VZ4mzCRJwqPHr8J2kmjQQ
         ZBkasAjDZtG11pMXIOCWQVePCYu6poBCNIzwFFjjP25ledPoHEn3PzAc4iZZgAO5JcEc
         dByjw5Y7RLKAcnMju/Dfu58YHI2OESoEXiEE2GDr67ajp35kib6WhsBiVGihOXbk/aLM
         0NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720644; x=1772325444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9VQyZPUVBKtquLyDlkewfzJ1/s13aoNaQBA0/wQfDo=;
        b=WhEeit2/UaGT94Awefw0Gfx3oj564l1EJVuMc5NldVTZy891RGJpl2TCDyoYtCQPkW
         hvVdTCZJOHFH53LnUbAENko/xx9xAEjgN7OnzW+2lKU0sXEv1/pEKgJmRutza6ZlMALC
         x6BIYhKwaut4nAMKu+mMa+KtSJoeG00U43Q4Wxx0JlEiPLhRIDHBqeziOxBJJV18KiPk
         cXbaAtVWZlQZaGuecJK3ounNcT4iZbeuwn3BRR5g3X/KUhIfTdO0FvwPlSmETsLiBZnI
         PKfeAdwGaa7N9KuS6K+mMFQMfkruexdlccwAscDFLnWGioVK74JEzkLWMHUanPhDUEqS
         pNag==
X-Forwarded-Encrypted: i=1; AJvYcCU0iNdJysviuFl5Ft3FfgB87kGgooANHCeIg6lj++3NQ8FolLtvy8NAl41Bz1RuMXd4P0BJ7mi71VAN2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVH1S4CSojF2+dx6caP6H/m70ovTWhnSRQtRwvWdWev8leF433
	mVN0cSICbCyUSgVMf0r4NyBiZ9rgZG8owr3pYMcjdidVF+GsK2Ikgf0P
X-Gm-Gg: AZuq6aIVKcnvrPEUanpohR8nO2H+rbFXP1lGqQHygIAXDzVWsoJdJfZAOFWNAQmcj6m
	o+Z+vUNJskoqMLNtx1cyxUKSdVfpP+z+BVxjoUisqX41z2l9MMgRkOdBfFvQB/cGbQxrF4idz1/
	c9N4czg3KrdNYU/FakbktbLzIfmoP/SoeMdOTfgQbWrw5QVjbx04N2AvVqXQlHCTcrKpDliQPtE
	u0pUXkyQENDfvZS6t4SI5DdcsveNLUgro8Kp+scWdqH9MSkGQAd/zDjYsJZnWodgFn0ziN5hyuF
	q7pLGeVgH/WkHyQ6yBph6CA9ivxNrNbRpKjM15QtfIb2hC8bijoaquLNNMQ6pAptrDf2jB5qO2l
	fBxvrBl4H9SePrkzZhuack2fjiIbjRv+ytu0/k/tBGTrNBL1g5GtHwNH1V7fye19NfGZNMDX225
	y11cYC+L5cGxVwqlFTUMkoECjht/2mY0w8nOJJHYXkaeyb0CoxtFn/sD+QPHoZLAlr6aGOOp6Hr
	oVrK1Wkq+tJJw==
X-Received: by 2002:a05:7300:fb81:b0:2b8:2910:dc9b with SMTP id 5a478bee46e88-2bd7b9f2a6dmr1800752eec.3.1771720643913;
        Sat, 21 Feb 2026 16:37:23 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:23 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Input: export input_default_setkeycode
Date: Sat, 21 Feb 2026 16:37:09 -0800
Message-ID: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Baltieri <fabiobaltieri@chromium.org>

Export input_default_setkeycode so that a driver can set a custom
setkeycode handler to take some driver specific action but still call
the default handler at some point.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Link: https://patch.msgid.link/20260211173421.1206478-2-fabiobaltieri@chromium.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 23 ++++++++++++++++++++---
 include/linux/input.h |  4 ++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ceb134044175..9336980ee320 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -861,14 +861,30 @@ static int input_default_getkeycode(struct input_dev *dev,
 	return 0;
 }
 
-static int input_default_setkeycode(struct input_dev *dev,
-				    const struct input_keymap_entry *ke,
-				    unsigned int *old_keycode)
+/**
+ * input_default_setkeycode - default setkeycode method
+ * @dev: input device which keymap is being updated.
+ * @ke: new keymap entry.
+ * @old_keycode: pointer to the location where old keycode should be stored.
+ *
+ * This function is the default implementation of &input_dev.setkeycode()
+ * method. It is typically used when a driver does not provide its own
+ * implementation, but it is also exported so drivers can extend it.
+ *
+ * The function must be called with &input_dev.event_lock held.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int input_default_setkeycode(struct input_dev *dev,
+			     const struct input_keymap_entry *ke,
+			     unsigned int *old_keycode)
 {
 	unsigned int index;
 	int error;
 	int i;
 
+	lockdep_assert_held(&dev->event_lock);
+
 	if (!dev->keycodesize)
 		return -EINVAL;
 
@@ -922,6 +938,7 @@ static int input_default_setkeycode(struct input_dev *dev,
 	__set_bit(ke->keycode, dev->keybit);
 	return 0;
 }
+EXPORT_SYMBOL(input_default_setkeycode);
 
 /**
  * input_get_keycode - retrieve keycode currently mapped to a given scancode
diff --git a/include/linux/input.h b/include/linux/input.h
index 7d7cb0593a63..06ca62328db1 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -517,6 +517,10 @@ INPUT_GENERATE_ABS_ACCESSORS(res, resolution)
 int input_scancode_to_scalar(const struct input_keymap_entry *ke,
 			     unsigned int *scancode);
 
+int input_default_setkeycode(struct input_dev *dev,
+			     const struct input_keymap_entry *ke,
+			     unsigned int *old_keycode);
+
 int input_get_keycode(struct input_dev *dev, struct input_keymap_entry *ke);
 int input_set_keycode(struct input_dev *dev,
 		      const struct input_keymap_entry *ke);
-- 
2.53.0.345.g96ddfc5eaa-goog

