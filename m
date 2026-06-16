Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44323A59A7;
	Tue, 16 Jun 2026 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643095; cv=none; b=Eerqkvcx+Gc5WnH2dnILvHDwBdjj4H+nZ6wVeqvz0DPnc+LivfEwDy1k9X3Aj0wIzQj/EfuueE9dqUqOCDlX3OHjbcWgq+sd9sw6G83IFtEH3Qqwn3mZlZoyK0zNH8vXoWCQiTJJn4961AiX5n3le11CxyJrz50aueEKB3PMsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643095; c=relaxed/simple;
	bh=VFb2FxuhLCRMmPj4fC2L9d2sNR6IU0C1GuoKIlJQm6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=batAFQr/zmgbikplMiZJR6f9sEARPys5b3f9f4G7FDsda1eF4+cFxo6eOawx42MASShVqzVZGPDbfChBtUnBdTiEyMczcaTOyPMrCyexEYDG9KitUxObDKhV3ev371TonHXsoonakoH0SMIP6kd8x9mGuJCTiL2tV0ak5QzMEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=n4wvlrPw; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z8WTLcY9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n4wvlrPw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z8WTLcY9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gfzg10BYlz9v1D;
	Tue, 16 Jun 2026 22:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf6FTAk6TK1D0M6gzE98qOg22WFwdTvdp/dqs3D6Ev0=;
	b=n4wvlrPwJKBNuw41ShfPrQz1S4l0Qj7jmaKbEfGPX41Se6I1oHUrli38phhvTKw8vbgNU5
	xaq04tIeze34U5sMJlBJTCTBmOr8PRhMlxrSyVfn4mdqF097LZn1TfmAUNKcqQqTi5uRoW
	YMKLGcpyLoSc9KwwSDrkfeO3hhV7EhNXD/IUReUo/eDkBun0Hsu4aZOLx/DrjSwGCEVxLM
	KGFAx2yyAGpxAhsB4joaGlBI8hpOP6mB7thkS6/+x6SBuqLqhQIPyAdMXM6UOE1/JIu/ch
	XCZoKVhC5mPEfSy9OToTcVgktwy0Uh0KUIhceWjDRpY5c655NpwfOzPtddm7SA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Z8WTLcY9;
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf6FTAk6TK1D0M6gzE98qOg22WFwdTvdp/dqs3D6Ev0=;
	b=Z8WTLcY9+rH4OQe3GmoAlIvrww9OI+isK0bpvncXEepL1NzXH35sYLs7virL6oTgvFxJsQ
	+Kc4Gvzh5T434TeJM2s1UUi2/Jq/uko/VfxH+q4F48JxeDj1hVUZlIQuB1cGlC9dvk47oc
	Yy/MfQ0I6WYZH17BIT6TsbsHiLiycCAZAQjXwF3J4ja0AqYghl9sDvvf4P+ojV53CM4Tml
	EbSidEpwAVYUzjzMN61hPfstAU/7fZn8zCoHXjDFxIr49qBsyFs5193RXq0PIk3hpEiHs0
	ttRfhBNNATXBxIEmHl4n/8Hfn4SbmExNsT0eNlncNC20UXB636NXkM8aEXuNjw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH v2 4/4] HID: sony: use devm_kasprintf()
Date: Tue, 16 Jun 2026 22:50:43 +0200
Message-ID: <20260616205042.6671-6-rosalie@mailbox.org>
In-Reply-To: <20260616205042.6671-2-rosalie@mailbox.org>
References: <20260616205042.6671-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eejc86mgrhqr1e3tk3c96p77hh6o5r5n
X-MBO-RS-ID: 70ba1e4fa4419c8c539
X-Rspamd-Queue-Id: 4gfzg10BYlz9v1D

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

