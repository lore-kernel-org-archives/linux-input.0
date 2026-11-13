Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794596438;
	b=cx4FALzHLantsh2aHtQZPyp8eG1BaK0p/UIgvTkLznImj6knqAeZEdkHlKzxkt7Fz5Er
	 7JvmdYna2KRuir6S0sv7eLbCz9jQtjHhgeRVvZgtgfOKYkkYVlRK3ouo+wVPqM5QgYy9Y
	 532P6PHZJDlsoTH7Nvudj8DcH0S1DxOVrcRXSOA/kpFzr0G2quPRYXGAQKAZuqrRDp8FX
	 so78QnGZzjm35nY4NslSr2qRWa90o7WS1tJgMOX9QsxES70aUaKjNV2PuYEZsxkgc3WCx
	 BQFUnO8r6CE5OmovhUcf8G9chw2rVttZUY9qvKs5niY3p/RztIoBVc68AYe44Tn/LHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596438;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kn5PAsnZW8TXFNEUl+sl8GjPfwcOb2qpC59iAcrDm/4=;
	b=zbR7QS+usdF3hdVjMv21YXoo59dMcVv/dyxwg/zidpcNe93kGd3X+ImSwsVxKl4W0b3N
	 5bxEhWdsVFVMdruxRUYTVWOf28ZBumvuRvD9aDTLswJ7sV3s/sXfmf4yIGkntWdfZZtiZ
	 PLu5OCyfFqvfZKxb+KVbRIsV5cTOWa6NIgjkpmYqEAErgKHdqV8i9jQ+gNKqLn6RP/v0s
	 UiM66FYQQ4E0nBphbvCWk3iFFAWJXBwzw+Vk3BT6cdR1jSxRr5qLur6LZF7qWTfV70aCL
	 QLZ/tmxXSurFTuuH99eXE0zPh5wnpfO5WCRYKxY5LEtn3lJDVOcEUOYSPbcmtupVYbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afZHlUrm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E8606B36A;
	Fri, 13 Nov 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afZHlUrm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794596438;
	b=kLcp4m2FUjpB6lCZo1yYxiFhHp6tjkmoeEmPO4PM69vj9G12yymIOCpFjCQ105XoRS0G
	 42mEjnMGY59KYg94TBkLxt9aKdZmkS5MLpjLh5X4FvpaoyDBTXw5OKk/z0ETzIm1Ga14r
	 OgMMqm3wqIY8dQiyY3U5CfwqLxeZLrhSLqn9nON5IYv10/cRRCDauSnw/XVraX+McIOdq
	 WQwKB77p1FHm1SyamjR3tgkAxvcksTs8uvvnXHMHPdLwxI6M+L1MbzYrXjnL8Che0mW4d
	 blNFNkfQ1fx1/T9s+spX0hQ8RNzxKD2s3yv9z1BP78cZW22KmTwO2/F8UeH+qLtMLCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794596438;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kn5PAsnZW8TXFNEUl+sl8GjPfwcOb2qpC59iAcrDm/4=;
	b=XfRwCahR6dVYaq602aEHiYBOdNZnq6rq+H0Xd44R322hh+tDU1CNugvRV0DHVrzsxOO+
	 fl0ofB/8J4fXkeQ+LkMb575y3a332FVxNEKEBbFwwhdBb/JX0HoOMqCt3um+sOYkre9AJ
	 gpBOzk5wmnFKwh1X5LdJ5Sf5vPiCn7ydVw0ho0xVVCK6F6uB2bX8gz61C9VSk4Sy4YBch
	 RjBH4YqoEYnpANznz2hvgvmfVqJjoWE2VhkfhwHlp7sgGFE0oQSDWskIF5wqlCfBxsEE6
	 b8EYiJTRah2tw9jhvZe2htftbRwZju5yzvVMkqNZuEZd2Js37LguGlErrpacVrDbFFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 627131F000C6;
	Fri, 13 Nov 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596438;
	bh=Kn5PAsnZW8TXFNEUl+sl8GjPfwcOb2qpC59iAcrDm/4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=afZHlUrmFcvKg84dazMCC4Aqx8qwosdVkMUc+X2z6/LLACLfby0xPAdK2YBsJ0e9u
	 QgN1dmds1xJurLTcVq55FVj/pF2jxSNtVGGcu+LR4h1wIKrtapMc58tLe/OkipmSp7
	 Gy2YKJpQPb2zZF3WCHphKlpjAiubBHYVtAeYSP8UT5NDJSAWHCcEz4U1CU61jppe8p
	 7LgmrEFVyE9FrC7ftOWxjxKwyJgg5Lq+LuYwyKFeduPAncS69D8a3VWZBf5vEFH0YM
	 jSEc7WY6SqiyyhG48aiH921WuBHbqzNZdUUfomkIBUHM8kkmeUYFzyYUlN7oDjbo5c
	 MA4w9N6P1my0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E71B749A76;
	Fri, 13 Nov 2026 19:00:33 +0000 (UTC)
From: Lukasz Leczkowski via B4 Relay <devnull+lukileczo.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 20:00:32 +0100
Subject: [PATCH] HID: quirks: add ALWAYS_POLL for ASUS ProArt MD301 mouse
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
Message-Id: <20261113-hid-next-v1-1-864859cc8fb4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDUxRSWuIha0U8aipEWaiLsrl
 l/yv3dBIM8UoM0u8HRy4NUlYJ6Bngc3kWCTDLKQChFLMbMRjuIuKmm1wtrQiA2kfPNkOX5XXf8
 7HONCen/3cN8P+ezjiWwAAAA=
X-Change-ID: 20261113-hid-next-42fc615deb17
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukasz Leczkowski <lukileczo@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794596433; l=2708;
 i=lukileczo@gmail.com; s=20261113; h=from:subject:message-id;
 bh=vrTaXFIOa0qeMNOjtZQ1MaWdE3vzSUbRqXS61MDKra8=;
 b=YtJKq1kuIz+V9Y5IJYi9616ZLEmt1o8L5jcyvcPlwa0q6oBdMtK8Y+EtJ0AuLcBPhgtI7JyEb
 tTHHHyzz3U9CNy6VwzAXmIimpkYFgoElJ9KzABTTeZ08aF+s7Un1Mud
X-Developer-Key: i=lukileczo@gmail.com; a=ed25519;
 pk=MiftsQwzsESpOBi4MFSEM/GdQ1AqhJDTUoKXLsZIOBo=
X-Endpoint-Received: by B4 Relay for lukileczo@gmail.com/20261113 with
 auth_id=1514
X-Original-From: Lukasz Leczkowski <lukileczo@gmail.com>
Reply-To: lukileczo@gmail.com
Content-Transfer-Encoding: 7bit

From: Lukasz Leczkowski <lukileczo@gmail.com>

In mouse firmware version 0.00.31 and receiver 0.00.20, the receiver
of the ASUS ProArt MD301 mouse (0b05:1cd3) delays button events
by up to ~500 ms.

The receiver exposes five HID interfaces. Besides the keyboard and mouse
interfaces, interface 4 (vendor usage page 0xffc1) carries a copy of
every button and wheel event as a 64-byte vendor report. As this
interface has no input handlers, usbhid does not poll its interrupt-IN
endpoint unless userspace opens the hidraw node. The firmware appears to
hold back the mouse report on interface 1 until the vendor report has
been read or some timeout expires.

Add HID_QUIRK_ALWAYS_POLL for the receiver so that all of its endpoints
are polled continuously.

The issue was analysed with the help of Claude Code (Claude Opus 5.5),
which captured the raw HID reports, identified the unpolled vendor
interface and drafted this patch.

Tested on 7.3.0 with this patch applied;
clicks are delivered immediately and double-clicks work again.

Signed-off-by: Lukasz Leczkowski <lukileczo@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa65..e638afb1d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -236,6 +236,7 @@
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
 #define USB_DEVICE_ID_ASUSTEK_XGM_2022	0x1970
 #define USB_DEVICE_ID_ASUSTEK_XGM_2023	0x1a9a
+#define USB_DEVICE_ID_ASUSTEK_MD301_DONGLE	0x1cd3
 
 #define USB_VENDOR_ID_ATEN		0x0557
 #define USB_DEVICE_ID_ATEN_UC100KM	0x2004
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 793db001a..952e1aec1 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -37,6 +37,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_MD301_DONGLE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM), HID_QUIRK_NOGET },

---
base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
change-id: 20261113-hid-next-42fc615deb17

Best regards,
--  
Lukasz Leczkowski <lukileczo@gmail.com>


