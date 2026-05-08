Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44C2F8EB1;
	Fri,  8 May 2026 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216653; cv=none; b=KBBTvk/fCoe2FkkZimOJknsPeluQgeY64m/7wYduceSBZ7RWzAfdsU7gsDLGNV+nFMBOP9xc2xoI6KBGPj0wVtqAenS0180yLSnVz9wW5HupDkhVA6L8VdNbUlLuENh6kV1tDCFDpJ1ZD5XfCN52Wq9/yyuBM694Qo9RaShEyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216653; c=relaxed/simple;
	bh=VFb2FxuhLCRMmPj4fC2L9d2sNR6IU0C1GuoKIlJQm6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXnp2clu409q3EiJ8wGgtwwk+2zph+Ue8tiFa67NJLnhtViFhyTvdR+AZEYpVUPk+Webw4HBabWICpUm7rrNVDfI2s8DUiANJFEKiQUHm7H9/SP6KC1BBSYROq2qyjsfZLECSjqKKo87kWcjql8TjYrLJ4z3mOkgXY75U4CMY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=K5Shzndh; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qbODZmUj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K5Shzndh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qbODZmUj"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBcJJ5CQhz9tYQ;
	Fri,  8 May 2026 06:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778216144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf6FTAk6TK1D0M6gzE98qOg22WFwdTvdp/dqs3D6Ev0=;
	b=K5ShzndhEVQFNBhMEhnf3h+FmB3kbS8WG1fGAMdhbv8k0QeZ1UBGwEOK6SbCcLyanoNAuC
	+eridJukhWNF53wBlvR9RsqxUrT5l8vOic3zmYdSts8objbvidDcLdBJBTSHGqVdHl0H/A
	vRAuUvjOANs8YOMeZ612b7QFHq3hskNiGzSZDm4rWqhQqJ7JSjngjXQHIWUE+zLEX6yJ4Y
	xYf/tKWv6iV9V9iw/v33migBfY+m2EmFLvLNr3gges7dlgLvnIobB7DusGue/SmS5Rg7+Y
	Q+GX8RbAH6BsNOTy6K2aB9iCckXBgAGT7s77PkAmCit3aezEWDhJAQURiaVMiQ==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778216143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf6FTAk6TK1D0M6gzE98qOg22WFwdTvdp/dqs3D6Ev0=;
	b=qbODZmUjddPksW6rOCeyKes8jzY26S181MYlEktBo7QQpZm89dyVYmxsk3Pj0yMIym8P5A
	Zn+Rodje6ctdH7JzUKzofJQHb7Y4qQ8befv8Si8Z2GoKpCA/kFyXjTYJXVCvh18gefJJgl
	XadnG4Aub8UCp/wrkU8M6De+qBKG348V3mfsFrhZ/QIL4UYuyY9f1mhy6+7hKCd+kENAbN
	vPUtcd5jgzciUCWnyWazM18WRbgCc5pmqWYiqbkIVtxGzxfL63D7jffEI8l16BKbF6QElw
	uGVnlmn4SOxpCDu4UkfgPHPTYxrzx9PJs8Z7kxRz2mXjab1yQwS/b1SopeuEuQ==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH 3/3] HID: sony: use devm_kasprintf()
Date: Fri,  8 May 2026 06:51:11 +0200
Message-ID: <20260508045111.495032-4-rosalie@mailbox.org>
In-Reply-To: <20260508045111.495032-1-rosalie@mailbox.org>
References: <20260508045111.495032-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: w13m1wkiq66otccgnt1r8gj8p5iicz8e
X-MBO-RS-ID: 5651948491b8237f4b8

Using devm_kasprintf() makes the code less error-prone.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ff681ebc76ce..253fff4066eb 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1272,8 +1272,6 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 		int w, int h, int touch_major, int touch_minor, int orientation)
 {
-	size_t name_sz;
-	char *name;
 	int ret;
 
 	sc->touchpad = devm_input_allocate_device(&sc->hdev->dev);
@@ -1295,12 +1293,10 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	 * a suffix. Other devices which were added later like Sony TV remotes
 	 * inhirited this suffix.
 	 */
-	name_sz = strlen(sc->hdev->name) + sizeof(TOUCHPAD_SUFFIX);
-	name = devm_kzalloc(&sc->hdev->dev, name_sz, GFP_KERNEL);
-	if (!name)
+	sc->touchpad->name = devm_kasprintf(&sc->hdev->dev, GFP_KERNEL, "%s" TOUCHPAD_SUFFIX,
+										sc->hdev->name);
+	if (!sc->touchpad->name)
 		return -ENOMEM;
-	snprintf(name, name_sz, "%s" TOUCHPAD_SUFFIX, sc->hdev->name);
-	sc->touchpad->name = name;
 
 	/* We map the button underneath the touchpad to BTN_LEFT. */
 	__set_bit(EV_KEY, sc->touchpad->evbit);
@@ -1337,8 +1333,6 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 
 static int sony_register_sensors(struct sony_sc *sc)
 {
-	size_t name_sz;
-	char *name;
 	int ret;
 
 	sc->sensor_dev = devm_input_allocate_device(&sc->hdev->dev);
@@ -1357,12 +1351,10 @@ static int sony_register_sensors(struct sony_sc *sc)
 	/* Append a suffix to the controller name as there are various
 	 * DS4 compatible non-Sony devices with different names.
 	 */
-	name_sz = strlen(sc->hdev->name) + sizeof(SENSOR_SUFFIX);
-	name = devm_kzalloc(&sc->hdev->dev, name_sz, GFP_KERNEL);
-	if (!name)
+	sc->sensor_dev->name = devm_kasprintf(&sc->hdev->dev, GFP_KERNEL, "%s" SENSOR_SUFFIX,
+										sc->hdev->name);
+	if (!sc->sensor_dev->name)
 		return -ENOMEM;
-	snprintf(name, name_sz, "%s" SENSOR_SUFFIX, sc->hdev->name);
-	sc->sensor_dev->name = name;
 
 	if (sc->quirks & SIXAXIS_CONTROLLER) {
 		/* For the DS3 we only support the accelerometer, which works
-- 
2.54.0

