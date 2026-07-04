Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21857175A5;
	Sat,  4 Jul 2026 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124967; cv=none; b=ZxVy1uMGsYS64L6Nd0dIsx5xyNGHeDs9YrwYoIIzZkNSVP9jZwowhcIXBv/rUnwmzsUzDfH1iqgenFgYp1y2XU0D7PIbSitfX3G1CTNrznQp+SxMTmita+IBXNe2L0mSCgHPpGXNTkMDNDm/KT13urApMJye+iPMw8JYKavzA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124967; c=relaxed/simple;
	bh=akYVF7cIlhPdefmdA6rR4JM6WMQs9ObeL2SpXcE0eWk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=jKUcyPzPqS99Aq60mygWGOO+wcugaeJZ6HJOKn8JVOCuyuNJRemePS/I+TFgwDBHaekh4WMAjzcU5lAZ+ksj1GmGvdqTozIlsXtCOxXZ/nLC6RE6JOBU5rWS3bCFno3fVnTeUAD28k/bveIwMFvhDqIHO6fNAY2rX3HK4wTSyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1101b.com; spf=pass smtp.mailfrom=1101b.com; dkim=pass (2048-bit key) header.d=1101b.com header.i=@1101b.com header.b=PEyyLy7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQJkAf8F; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1101b.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1101b.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1101b.com header.i=@1101b.com header.b="PEyyLy7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQJkAf8F"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 519311D0005B;
	Fri,  3 Jul 2026 20:29:24 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 20:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1101b.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1783124964; x=1783211364; bh=Br
	T1Z710MarRkhLzd96jV4eov64LfG1Cx2Fjj7mXI6I=; b=PEyyLy7t3r4Ow0I0zJ
	1j+kGIJEZPIRvom7/qgGZ6pSoJGxqcMt8dah2EN0iTrMvq/sHyK6K8z4hqKytNt7
	Nf9OSsxatcrOfRQDiWAG4XsFJaTkUejXz9kgyQfrHMx0WMqLCUx5+jxyWK2zZSIf
	zJvF/AJ515W77dQZgs7BJMQoCngh/l29wjbdHTu5rINEykClA/1sXg9a4RGIhZ2E
	6KC2fXI+ymzC8WSm1kaZehohSlRYVVyQyzE+Y/o3VXBSIpNNU9dvosRDO6kf5jAj
	gJ9Q9hK0dRBjmFUydb3UWz4dts3b96WJsY+kRFH8i3VT8kG4lbobX1qTAtUi0VUq
	1zvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783124964; x=1783211364; bh=BrT1Z710MarRkhLzd96jV4eov64L
	fG1Cx2Fjj7mXI6I=; b=fQJkAf8F64pJ11Sa4GOl7TzkY2pStsYx1eU5exr0h5xR
	CQbXJqQ7/znZwxwJMycvn9UHKT1zjp4QUx+suVfRhMNHyQvsNhlUcLB/F0rufbZb
	wLFHQ5SRl2x9KenVIaBgmJKye29bgFBzYVyhdFSoNupIG7JA00XDUoUB/a1Ae4vQ
	vy6owBLraALJlYQA2pwxYn7QyA8tJR1AcFRT8rLJxPvBm8pm8NO8aruy7T64XR6P
	EVutVH/UWDDBOn0P0SEXXhzkFKu9wdSpaZb+jrNfN6COykA2E3npadb7AbT3qbPz
	fGK3dxblvD6W7esKssOCC3Xbxns7gAlOrGGdhCKc0Q==
X-ME-Sender: <xms:41NIak1noaBJ_J9mpd9LYUx75osV5LKADyJG2ji1BLQvYnU_r4iOrA>
    <xme:41NIap79EkQYqo4rUtR8jbi_DbwEzVdwUaYeOyi82CTrU9iuA3xBbROUTRZ5tLRIK
    ymLdWjyo1m3lbleklwAuGdMVOmbld7TkgZZOK_yg4UltgmOtCGozFCe>
X-ME-Proxy-Cause: dmFkZTGIYMguNtv8M5gP4fcpSk2CW8y/FnOZ2WteRBhYT7z2r6d02jZnPfgL71N2fsO7UX
    mAQc7c1p+aNay2AvmZVRv6FfWa4XFxry93pi4xfrOZELFoA2tz1N+r2v8GgieRlKPvfLvd
    Ve/NGP/KUO6ydzQtBScB9RH3ZZdMnec4Jxv6RWD//2v21Tl7Gs6jqOKHgVLlZn607/mbGL
    vY6KzD+qmKGWFX4CqzNdSEUqllZzY97j/4PR96oHQDE6mcFZ9//ciCdeeu4PMKS1xc5AOA
    Xz4Ff33JP823v/HbB+FkfkYlPryrGrOjI7+RlVfJ/IDD03ckXHLq6uo4Vdolhaj6hL+DWq
    S2wprYh735nmXm3I7MgpNufCf2MYgGS9J9RsAp0HZqOHPy+eZKIEFs4iSYz9XWH2+KxDuA
    VJJW3qalOSSY0koqPaD4SUtNQ0UIicjfnFJmN4NkH6ZNBUv02Kr70ff5Q/v0NmvhmI8PTB
    hegTV2Glf88uGyhRgiRtyMldufrXNGMyNs77c50KfitoyGnJHbnAezlDN78lEOseRwq4SM
    VhfeaRtVoW5xGMGWirpg9L7e29nsy9RmGClmU2mUcTyYPJr7SbCnhMF7Y/OrLYYjNrqxOJ
    sjJrDo4pJOBnEf3sY44DosAyL2PW4oEYqLSTNSo7O2oo4LfLq8NlhqoLHkbg
X-ME-Proxy: <xmx:41NIahCjAPTG7LyhpKY7VT18LdR19U78dw8UAXmTqUC2tbfgXP7aCA>
    <xmx:5FNIaocngq2lyWJvJSEeoWg27SLGBKw7Ud_zlZoQxTL8T26s_bX22g>
    <xmx:5FNIaoJmm6g4gpHSGMJHjtzSmC6UgC0ga71bPDfPx1mPsr3Pn3UiGw>
    <xmx:5FNIar2yjJvJXSaotHXwgtQ7SLDFJVLdeXdDIcxm5iDVpEcspW4Z5w>
    <xmx:5FNIasyaOTkG3t_ICE71gkqsUVgBG8a6ktnj86KEPYE6pLS-OqoaAT1W>
Feedback-ID: ie2d94605:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DEFA1C40071; Fri,  3 Jul 2026 20:29:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Jul 2026 17:28:06 -0700
From: "Colin Blower" <colin@1101b.com>
To: "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <eb945a79-d9ef-4194-be41-2ec81d6d8f3c@app.fastmail.com>
Subject: [PATCH] HID: logitech-dj: Add support for G915 TKL receiver 0xc545
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The Logitech G915 TKL has a lightspeed receiver with a product id of
0xc545. This receiver seems to behave like 0xc547 receiver.

Add a definition for this new receiver id and a mapping for the
recvr_type_gaming_hidpp_ls_1_3 type, the receiver now reports battery
status of the connected keyboard.

Signed-off-by: Colin Blower <colin@1101b.com>
---
 drivers/hid/hid-ids.h         | 1 +
 drivers/hid/hid-logitech-dj.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..0089a5e88ec9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -967,6 +967,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2    0xc543
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3    0xc547
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4    0xc54d
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_5    0xc545
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY 0xc53a
 #define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER   0xc548
 #define USB_DEVICE_ID_SPACETRAVELLER   0xc623
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 381e4dc5aba7..49b96ff2bc36 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -2102,6 +2102,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
                USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
         .driver_data = recvr_type_gaming_hidpp_ls_1_3},
+       { /* Logitech lightspeed receiver (0xc545) */
+         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+               USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_5),
+        .driver_data = recvr_type_gaming_hidpp_ls_1_3},

        { /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
--
2.55.0
