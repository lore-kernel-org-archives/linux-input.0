Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300F3A6B66;
	Mon, 10 Aug 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371189; cv=none; b=XinGwdB1cI138qLCGum8Wy/AHX8mRIaLRt4Cxye10YcVnqTwxc/280ilJ+dsaMNl0ZnF96krA13r1NI9VMsuQHCEynfV/wsuzT5Rzng5f5d7PqZypy4QxsSmSIwF76B/KGmm3NJBTlVu5ygbCkQ4f9Z0JvT4zM2FYDaL94iEcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371189; c=relaxed/simple;
	bh=wCZC2igsgtDdtXKlYw00f5qAIxs2Bb1v5ou7IplbMQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5xJ5H+oaXioRXSNoO3mQtNGEjgU1N5lSMTAW9fX6DHKRoPjhPVR5thJb3UyCVcSH1lgncy1qHr3t3P92CtiCu2X2C7J7g7aluS1rdIX91cHC4523qNgofD7whAvE0zj1iKjGg8IEEUz4j3z8dMdNbCh8nkNiGLVUQPCExbLa3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=FsWGrtt/; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="FsWGrtt/"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 8808568b-9b84-4a05-8c90-5b1797f5864e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1786370637;
	bh=wCZC2igsgtDdtXKlYw00f5qAIxs2Bb1v5ou7IplbMQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=FsWGrtt/T8e1spr6bflURNOaevtEsZHLkzARItrXuAui9XcOk8Ut1ltgpAVUCuHV8
	 35UQ6Xzv9xEz8hWdJ0gU4v41BhAHOOrxEyoLbEe+Up9skIh2Igj7sxfF6BnnQDIOrY
	 X9qIMjDuETPNOJAGIeEVvc56oKjFHcjguq4h+ImYz2iSWMaQbp2ZZ5PcawAeZxb89P
	 cznSXMbC4qq4uChJogaS98wq52bCTu060cSWapJwFJVgmItACo2JdwbCtfYooqzNQX
	 O9jSZlz2oxcPozLS5DltKkz3ScC/YnvrSxvhOdlSZ1CT5lAZM5pphphzGvQJMs/O0V
	 n9oOXteyzEBNA==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH] HID: apple-touchbar: avoid nested runtime PM in PM callbacks
Date: Mon, 10 Aug 2026 16:03:52 +0200
Message-ID: <20260810140352.35866-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

Runtime suspend of the Touch Bar display stalls because its HID suspend
callback requests a runtime PM resume while already running as part of the
same USB PM transition. The nested request waits for the transition that
invoked the callback to finish.

The matching resume callback has the same problem. It can stall after the
virtual host controller has successfully resumed the port.

The mode update is therefore split into an active-device helper and a
runtime-PM-managed wrapper. Both PM callbacks call the active-device
helper and no longer acquire a nested runtime PM reference.

We maintain the apple-bce/t2bce virtual host controller used on these
systems. Although that module is not yet upstream, its runtime PM path has
already been adjusted so the complete suspend and resume cycle works with
this change.

Thanks for your time and work.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/hid/hid-appletb-kbd.c | 37 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 462010a75899..cbaf7587feea 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -87,29 +87,37 @@ static const struct key_entry appletb_kbd_keymap[] = {
 	{ KE_END, 0 }
 };
 
-static int appletb_kbd_set_mode(struct appletb_kbd *kbd, u8 mode)
+static int appletb_kbd_set_mode_active(struct appletb_kbd *kbd, u8 mode)
 {
 	struct hid_report *report = kbd->mode_field->report;
 	struct hid_device *hdev = report->device;
 	int ret;
 
-	ret = hid_hw_power(hdev, PM_HINT_FULLON);
-	if (ret) {
-		hid_err(hdev, "Device didn't resume (%pe)\n", ERR_PTR(ret));
-		return ret;
-	}
-
 	ret = hid_set_field(kbd->mode_field, 0, mode);
 	if (ret) {
 		hid_err(hdev, "Failed to set mode field to %u (%pe)\n", mode, ERR_PTR(ret));
-		goto power_normal;
+		return ret;
 	}
 
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 
 	kbd->current_mode = mode;
+	return 0;
+}
+
+static int appletb_kbd_set_mode(struct appletb_kbd *kbd, u8 mode)
+{
+	struct hid_device *hdev = kbd->mode_field->report->device;
+	int ret;
+
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (ret) {
+		hid_err(hdev, "Device didn't resume (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = appletb_kbd_set_mode_active(kbd, mode);
 
-power_normal:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
 
 	return ret;
@@ -487,18 +495,19 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
 	kbd->saved_mode = kbd->current_mode;
-	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
 
-	return 0;
+	/* This callback already runs as part of a USB PM transition. Taking a
+	 * nested runtime-PM reference would wait for that transition to complete
+	 * and deadlock the USB PM state machine.
+	 */
+	return appletb_kbd_set_mode_active(kbd, APPLETB_KBD_MODE_OFF);
 }
 
 static int appletb_kbd_resume(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
-	appletb_kbd_set_mode(kbd, kbd->saved_mode);
-
-	return 0;
+	return appletb_kbd_set_mode_active(kbd, kbd->saved_mode);
 }
 
 static const struct hid_device_id appletb_kbd_hid_ids[] = {
