Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793405581;
	b=YnOPIHCI+7AvEhiNFMjFY2Ox8o9a9k+2iodAqHY7lJVti1c93DdsFeqFbqhbXbJMw9Zx
	 mIo4GEeJx2c/U2O8YX4WzGcZklbYF1e6IoFdau4Ceu/H7uf5rRYS6pPULRwCtRpWGp+Cr
	 0y10KRqe2CZBT79PxxoDr1DxeZvQYeAe7Yu3d8WWUPdHBrR3R/PDl/t4IEGvZVq6eAEWi
	 jKp7VurlejUxQt/cyAShhzffkqAawtNv9XoErOv4QxyLTf/61XHBZYctQp8Ob6yBe5t9v
	 00H8fgJbZs7RnGfxdKrSkkAAV8/Z+uwqKPUzNMxyJLUL/zXy7eJubjpk5hz6d5/xDUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405581;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k0+1HTucd5ooGWl5x2VMRoiExqNg9wNqq7cj1noWYek=;
	b=OPG4tBM6LATsUm4a5PtNln5eb4JvI9hT+8hI+Rudi63t7oahFk4DjiavSgsx1+wcLM6D
	 rrrZHgaD0JjZe5r8f1APtEYR2vQEWPkvcee5qwts0/7mmjMjNsM7t7OAuazfdZeGmpmV9
	 L2pE742vR5N9Ibxb/f+KzTT0N+SJnP/Z1CZr4GLftvHMVfGM3GP86+VAo8Q4hhoil39h6
	 EaOliMsPkcAQU5RSrYzEIZmAH4BgXJ8BenP7M3+N4T13mugmamFgjYgzXZemDBIgYBZXL
	 WawGOlS2cH3HWM0xM0VnVqSsphJFXNsV8vnjNG9vMkjiNXqgT1TPcWe7J+OB/CTJbCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADOsE028;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067B606A31A;
	Sat, 31 Oct 2026 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADOsE028
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793405581;
	b=GIb42yQKmGZ8Am1uWey+OU8Dpbc9okloxZkhPQLzGWVHyKJJuhOP7rO7kzXNAqRSJxEc
	 N6ti7ae60yAlkgB+WRWRev66asyUvCDEP8/FPDBvt/eXKSNR9CxO2Sc4r1LM2P+R+Rxox
	 aNNoNwmP+tIDt7/4ZIEgMQMtju5m09+zdOaTZYbYtXN7sxy3w49M3awrfwzhwVM2aRWiU
	 Z+cIQ+yFteHeN0PB/luWO0+RJm5lAAoDlAVmdTOqcvayWSCvHOXhcVvclnCFiryqzBRxk
	 ZZukooM/M6giHOVOIgyu7Jr4v7I0gNAht8snP28p/JsO9OlJuCH4AWPThu7aQG5toRA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793405581;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k0+1HTucd5ooGWl5x2VMRoiExqNg9wNqq7cj1noWYek=;
	b=k8dUv1R9VawI0dI474rlSfPXays57Of2mt9AxS6QNPYv3dGkapn+S8jCyiGMTByb20Ss
	 1bYHlmrLwUbofoBCIs0eWr4F8b5l7T0PkCMgI+06cvx40es/d4R1O9zRxdhszgAFy7tF8
	 XfEu0AIiXUQbaqKYbr2/sr5mL6jlPg1FH4FLr8AJSYUKFZc0kfRaEBkMAuFDhQ/GCDlHj
	 Fpanfk8rKqBMXBF3SqIjgHWUH3mybF/fb81PKxoun+qmY+Jy/ruWRp+O+8fQGz9N0QEj3
	 5h417Ulamg9YRpGlvSqZHaYmdJaEnEbf0Gw+WB51jVXIutr7EFnEsp0Tdjm5nlE8kgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7E16E1F000C1;
	Sat, 31 Oct 2026 00:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793405580;
	bh=k0+1HTucd5ooGWl5x2VMRoiExqNg9wNqq7cj1noWYek=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ADOsE028FOYjen/NnkUyW/N11POc8O2J6KZ+8W6qDUr3JLTnFL3XkSflHy84ZcxfT
	 iY8o4gAgc0uyIaujMKWV3QJp7zHCLGcRsnqWDUGPJjSDiizpoRSE51+7aWAl9HxGZV
	 bCHtg3xCzk1/QrWswOsVyrPJCZie+OYOOtt7+sP0QDHoh6LjZ02UcJm5mMwIX1oyVp
	 uM3CdUMK5o70au/GAfXGVi+uCQA+vZfntNMRznv7GsCR8sMdZ5Z332DHpmYfAED7La
	 vFJL/MkiqmiejhSO0GydDDjN/FYdQ2RtnmY7F70ccG45VHMt76eg3LbX4Oj2nxGPmL
	 M0+6oT31FADJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0E54D442E0;
	Sat, 31 Oct 2026 00:13:00 +0000 (UTC)
From: Jason Lee via B4 Relay <devnull+jay.ruby.im@kernel.org>
Date: Fri, 30 Oct 2026 20:12:49 -0400
Subject: [PATCH] HID: logitech-dj: Silently drop the G602 vendor report
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261030-hid-logitech-dj-report-log-v1-1-11e33ba05106@ruby.im>
X-B4-Tracking: v=1; b=H4sIAIAy5WoC/yXMQQqDMBBA0avIrDsQUwy2Vyld6GQ0I8XIJIog3
 r2xXb6/+AckVuEEz+oA5U2SxLmgvlVAoZtHRvHFYI11tbkbDOLxE0fJTAH9hMpL1HwlbMhR1zx
 672wLZbAoD7L/5q/332ntJ6Z8HeE8v6QZ1QF+AAAA
X-Change-ID: 20261030-hid-logitech-dj-report-log-5c6ca59bd628
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hansg@kernel.org>, Jason Lee <jay@ruby.im>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793405579; l=2837;
 i=jay@ruby.im; s=20261030; h=from:subject:message-id;
 bh=I1de0OPh3QAdhK16Qx/LZrN+CVkA1e95vFNyssyrv9w=;
 b=5LhGD3dZwizDh75sDmST6C8U34zl9TzgSCgfgxcxF2komIOZsiw/PMmDys2mSG11ujDCAnVzT
 IMCaJfGrUcRAhoMoFGbQLqGt546sHRuyiWWQ1ItHJby2PpPbmq9EQZJ
X-Developer-Key: i=jay@ruby.im; a=ed25519;
 pk=nwVVsNgYUApfCPxmvZyTv0afv7bOSDky/hRrOjJKzys=
X-Endpoint-Received: by B4 Relay for jay@ruby.im/20261030 with auth_id=1367
X-Original-From: Jason Lee <jay@ruby.im>
Reply-To: jay@ruby.im
Content-Transfer-Encoding: 7bit

From: Jason Lee <jay@ruby.im>

Since the G602 receiver (046d:c537) was added, every mouse click logs
(as logitech-djreceiver 0003:046D:C537.000A):

  Unexpected input report number 128

One user counted 2353 of these lines in a single boot, and the bug has
been reported against kernels from 5.10 to 6.16. Some users blacklist
hid_logitech_dj just to get rid of them.

Report 0x80 is a vendor report in the receiver's report descriptor.
logi_dj_recv_forward_input_report() can only forward reports up to
REPORT_TYPE_RFREPORT_LAST, because it uses the report number as a bit
in reports_supported. Nothing in the driver needs this report, and
logi_dj_raw_event() returns false afterwards, so HID core still
handles it on the receiver.

Hans de Goede suggested in 2021 that the driver should recognise this
report and silently discard it. Do that, and keep the error for any
other unexpected report number.

Fixes: e400071a805d ("HID: logitech-dj: add the G602 receiver")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215796
Link: https://lore.kernel.org/lkml/cb14d9fb-9928-4c62-a087-b1a54202d65a@redhat.com/
Suggested-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Jason Lee <jay@ruby.im>
---
An earlier patch for this ("HID: logitech-dj: stop G602 mouse dmesg
flooding", 2025-02-25) checked the receiver's product ID and got no
replies; this version follows Hans de Goede's 2021 suggestion instead.

Compile tested only; I don't have a G602 to test with.

An AI assistant helped find this bug report and draft the change.
---
 drivers/hid/hid-logitech-dj.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 6e8db01d27..a433e2ac76 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -40,6 +40,9 @@
 #define REPORT_TYPE_RFREPORT_FIRST		0x01
 #define REPORT_TYPE_RFREPORT_LAST		0x1F
 
+/* Vendor report sent by the G602 receiver (0xc537) on every click */
+#define REPORT_ID_G602_VENDOR			0x80
+
 /* Command Switch to DJ mode */
 #define REPORT_TYPE_CMD_SWITCH			0x80
 #define CMD_SWITCH_PARAM_DEVBITFIELD		0x00
@@ -1245,7 +1248,13 @@ static void logi_dj_recv_forward_input_report(struct hid_device *hdev,
 	int i;
 
 	if (report > REPORT_TYPE_RFREPORT_LAST) {
-		hid_err(hdev, "Unexpected input report number %d\n", report);
+		/*
+		 * No paired device consumes the G602 vendor report, and HID
+		 * core still handles it on the receiver, so drop it quietly.
+		 */
+		if (report != REPORT_ID_G602_VENDOR)
+			hid_err(hdev, "Unexpected input report number %d\n",
+				report);
 		return;
 	}
 

---
base-commit: a9547379cb381e2a036e3261a6becc17973ac470
change-id: 20261030-hid-logitech-dj-report-log-5c6ca59bd628

Best regards,
--  
Jason Lee <jay@ruby.im>


