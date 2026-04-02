Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC755364927
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154588; cv=none; b=AB+qfUHdC+a1MtdztJpU59MEdIvFWZ8dWR7QtfeU61gmnYmOpqVYccTwkrkZwkdQ3lFeuIO54x+xAmY+V8XHrAv5o9gKj1o3LyzywTuBHwsxNLF1k8qKYfOhqARUX5C0YV49NxDIxCV+AF6czZFjJeeKdyUFJ18iNcFJBYhn9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154588; c=relaxed/simple;
	bh=fkALRlDaCvYw96amaCu4NjwJ0Qdrhwo4g5tT/+jYDbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiW52sjbVvC1UTC3TaIklj8NaCXetVEfcNRg0HkSALilQ/lNYOk4/li4JL1+uFXbPCOeyW9T/NBKlm29eqBwBMUBJRglYsoi8Tw+0cLwMnd5cCyLyUJVzK4pnXVZ7jDymDl7dBil7m7QXOoLiH6Zkc3hx/AuOECxl3NGsy7axAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQYx+Fh5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQYx+Fh5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d0288d24f6so172247785a.0
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775154585; x=1775759385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vq95h5+ES6NzDCLDOYDrw2F8+izhS35fbgzcadc4Cg=;
        b=RQYx+Fh5rNJ8i36d4h7xLe3O+NNJfTKateXycUpv0CCyh1hgtA2zlwB+As0qy6h4Xx
         /+ek3Ph1L8NwongR2rsVWq0XgrPlu2en+oW0ere7ALipUTxlv9xVhdFxAojTEKkxnjEt
         Cidn6R2Ehoui8FgHNEp/klUKTaDSjIGceaEYhtsTfCOkad9ncCq0Fggm8ONCQofxNh54
         UMlA4ePfibfpZVX7cGhNvQkWpizduPngnWViXuLCSShOf8CMXOiHmNtkqLPqzEdGxjaH
         k8RMq+hDFw7m8gbUvsEus+hzgt4v4thk5PhQ7qUMXGCt9wmA3Qs4yNVNlwSZCqDUv6z6
         IgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775154585; x=1775759385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Vq95h5+ES6NzDCLDOYDrw2F8+izhS35fbgzcadc4Cg=;
        b=pf26fDMw2vw0VP7Ax/RgLNU78/C3ytDBLhISEtci/U2+u6W+H+wKet2CRPoG0a+Wgf
         MQi12rXaNJbVGm24ZKnJj3pAZBZv/r73KA64pPG5SNXPxFATlgtMdWnODf1gSIUZblHn
         STOu6vEbKXpKsa3MNM+NfrX2AmhQ9jcHjGEMjAguTUU5oxbc8w1mqyOwdBbtSp42ehlX
         kKb+70uoFhdL91/kkIqma1+e5Q0WWEi8uzIIgpRXFspRm210QdOqyQjSfT7Le2WZA8iW
         Cd6KH3/nwYBNAMBY7GE1KEiBj22GMEgoO2pGt/7czwxx+2QtPI4761RSSlXSi/uoqH3C
         817Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkO27QfKBBwsyhqPjFbTvj1SRD745ygPsl6+GYZ2XYv56sBA6z6/pPxiwkBcpo4byEJUvLwKHFHshZXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJ6kbip8XUP1fYdy9BVbHRedGEQoyluoYWt8MU/S1mJnHLGj0
	CPM49S83BHJHiTJcx/sPXE2W4vF5yEumF00wAwzvxhxzApjGdWplFdlNR0fooSy3gA4=
X-Gm-Gg: ATEYQzw9nP10QuIAR43vRj5mcKzhRQ3sL41meGy97B5RnkuRMPffmFTcJNDAL2hxP28
	eCRhipHk5CleDPmhZmkej0HqsLItmTaxYjUUWnPX7UOc07tsxD4h+t/WzGhwTtub4ZTO/+DDOcw
	TzoI3UCs8gfANVWnhqBi5bEM0vZuXr8OXQAYctV2e4uo91Lu9wCLmmMDmiQymgfETPidfC/V3G2
	5jmOjTUHxCk+yGS8jJ2qhdQIDE/ZvVUO64zLzMWjk9YMhsBA7Ijl/+8xRe+FYr2gKxX+YSQgLNU
	BJu0v/5ewib71jIET5oo6Jkr8Gy9rJ9bhwIY/QZvWXv9Tx3TMKocPy/Kpf5R3IZRqtpyZCYrZZj
	vMND7aJxVNdsExaixZVkDLd2b/CPVpEMcXw9gigRu2iUpRv5E37Pgt1/oU30ZRqI8WQbW7caUAe
	jmAiHePw2J9mzNrkY9GGLv
X-Received: by 2002:a05:620a:4452:b0:8c6:f416:69f8 with SMTP id af79cd13be357-8d42490a6aamr31433185a.15.1775154584826;
        Thu, 02 Apr 2026 11:29:44 -0700 (PDT)
Received: from fedora ([2600:382:6114:1b06:cf32:7ce8:f756:4daf])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392ce8sm314825785a.7.2026.04.02.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:29:44 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH] HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen misclassification
Date: Thu,  2 Apr 2026 14:29:37 -0400
Message-ID: <20260402182937.388847-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Book 9 14IAH10 (83KJ) uses a composite USB HID device
(17EF:6161) where three descriptor quirks combine to cause hid-multitouch
to incorrectly set INPUT_PROP_BUTTONPAD on both touchscreen nodes, making
libinput treat them as indirect clickpads rather than direct touchscreens.

Quirk 1: The HID_DG_TOUCHSCREEN application collection contains
HID_UP_BUTTON usages (stylus barrel buttons). The generic heuristic in
mt_touch_input_mapping() treats any touchscreen-with-buttons as a
touchpad, setting INPUT_MT_POINTER.

Quirk 2: A HID_DG_TOUCHPAD collection ("Emulated Touchpad") sets
INPUT_MT_POINTER unconditionally in mt_allocate_application().

Quirk 3: The HID_DG_BUTTONTYPE feature report (0x51) returns
MT_BUTTONTYPE_CLICKPAD, directly setting td->is_buttonpad = true.

These combine to produce INPUT_PROP_BUTTONPAD on the touchscreen input
nodes. libinput treats the devices as indirect clickpads and suppresses
direct touch events, leaving the touchscreens non-functional under
KDE/Wayland.

Additionally, the firmware resets if any USB control request is received
during the CDC ACM initialization window. The existing GET_REPORT call
in mt_check_input_mode() during probe triggers this reset.

Fix by extending MT_QUIRK_YOGABOOK9I (already defined for the earlier
Yoga Book 9i) to guard all three BUTTONPAD heuristics and skip the
HID_DG_BUTTONTYPE GET_REPORT during probe for this device.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
Tested-by: Dave Carey <carvsdriver@gmail.com>
---
 drivers/hid/hid-multitouch.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e82a3c4e5..1bef32b1d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -549,7 +549,14 @@ static void mt_feature_mapping(struct hid_device *hdev,
 
 	switch (usage->hid) {
 	case HID_DG_CONTACTMAX:
-		mt_get_feature(hdev, field->report);
+		/*
+		 * Yoga Book 9: skip GET_REPORT during probe; the firmware
+		 * resets if it receives any control request before the init
+		 * Output report is sent (within ~1.18s of USB enumeration).
+		 * Logical maximum from the descriptor is used as the fallback.
+		 */
+		if (!(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I))
+			mt_get_feature(hdev, field->report);
 
 		td->maxcontacts = field->value[0];
 		if (!td->maxcontacts &&
@@ -566,6 +573,10 @@ static void mt_feature_mapping(struct hid_device *hdev,
 			break;
 		}
 
+		/* Yoga Book 9 reports Clickpad but is a direct touchscreen */
+		if (td->mtclass.quirks & MT_QUIRK_YOGABOOK9I)
+			break;
+
 		mt_get_feature(hdev, field->report);
 		switch (field->value[usage->usage_index]) {
 		case MT_BUTTONTYPE_CLICKPAD:
@@ -579,7 +590,9 @@ static void mt_feature_mapping(struct hid_device *hdev,
 		break;
 	case 0xff0000c5:
 		/* Retrieve the Win8 blob once to enable some devices */
-		if (usage->usage_index == 0)
+		/* Yoga Book 9: skip; firmware resets before init if queried */
+		if (usage->usage_index == 0 &&
+		    !(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I))
 			mt_get_feature(hdev, field->report);
 		break;
 	}
@@ -644,8 +657,11 @@ static struct mt_application *mt_allocate_application(struct mt_device *td,
 
 	/*
 	 * Model touchscreens providing buttons as touchpads.
+	 * Yoga Book 9 has an emulated touchpad but its touch surfaces
+	 * are direct screens, not indirect pointers.
 	 */
-	if (application == HID_DG_TOUCHPAD) {
+	if (application == HID_DG_TOUCHPAD &&
+	    !(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I)) {
 		mt_application->mt_flags |= INPUT_MT_POINTER;
 		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
 	}
@@ -802,11 +818,15 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 	/*
 	 * Model touchscreens providing buttons as touchpads.
+	 * Skip for Yoga Book 9 which has stylus buttons inside
+	 * touchscreen collections, not physical touchpad buttons.
 	 */
 	if (field->application == HID_DG_TOUCHSCREEN &&
 	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
-		app->mt_flags |= INPUT_MT_POINTER;
-		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
+		if (!(app->quirks & MT_QUIRK_YOGABOOK9I)) {
+			app->mt_flags |= INPUT_MT_POINTER;
+			td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
+		}
 	}
 
 	/* count the buttons on touchpads */
@@ -1420,7 +1440,6 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	 */
 	if (cls->quirks & MT_QUIRK_APPLE_TOUCHBAR)
 		app->mt_flags |= INPUT_MT_DIRECT;
-
 	if (cls->is_indirect)
 		app->mt_flags |= INPUT_MT_POINTER;
 
@@ -1432,7 +1451,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 
 	/* check for clickpads */
 	if ((app->mt_flags & INPUT_MT_POINTER) &&
-	    (app->buttons_count == 1))
+	    (app->buttons_count == 1) &&
+	    !(app->quirks & MT_QUIRK_YOGABOOK9I))
 		td->is_buttonpad = true;
 
 	if (td->is_buttonpad)
-- 
2.53.0

