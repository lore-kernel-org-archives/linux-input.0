Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794920504;
	b=PFWmnfIu4WjAnR+okAt1COZu3FNUqiNC7qoqYN5L+n7Mo+op+0poi6IUC29OtzBCyKoo
	 HIA9XJTtB4pdQEgCNXFx027QBdPiZQkOFfZnbJAXN9GYFS+NEXvBaTm86z+lh31l5VpCQ
	 RMHdzrezUzp0KTcDwGdY5PsQ1TucaoeaHivm9BPXK9Low4KEQBTXgRDaF5Q54FAFs7xxu
	 QcQ5a93NB5u/JkI4yJ4uyjEiYX1JUKu7eRL/1fXX1SmY6W8X89F6B4c4Ll3RhUD+K4sYf
	 0VHiCsXcdTddQMWTt831MC00pCF8N+Y1IL7zma9Gg0XgNflhfwzplydvsq4/QR0GtOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920504;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RTe+6VcPOf1eouGGB3XNAMNJdYSyIrM32M7JIMS1tWQ=;
	b=so0DxchZ/cC5jRJ/RUj/4HLwTC+hZ3v0UMkQdR0PjMALRHkGfr1zmBwup7+O0qOvSfE/
	 w9kHTsqwRoRTjmHP91M/3U07Wl+oPtiOWW7EZ9VDhi3Kz1ib9SKH9Wc1iCXmqpcIX+BGt
	 MK22+cGxnYcfCwVIKUaRRhUYUndM0KlNA2IBsX0PvFVfyzJY4v6lcy2GGNWuKjUBoAtNE
	 G1aawGhTAIskMnEbWvyxkegkunZtd+POhdhCEtfn+8qxuOaBdFAKpXtqO1ZCVwhBn2p3Q
	 cRmgEltQMGj3+KeBvnUz6pkwFbrsUG9zCnJ4/uBwYZ5RcqNfh/xfPY4Pc2woikBfG+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMR+Yfa4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EFB606A32C;
	Tue, 17 Nov 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMR+Yfa4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794920504;
	b=f1EFEErFvtixIuvfm4QhAhZaJn903JfBTdzVpWusUZoo0QJQ72j7bPsJqz2F3y+d/C77
	 zKZribFre+yb5elztKF51n8oBREg9vo6g5suMyTMpK95inf0DmZa7sXiql6L9a/QUXi3a
	 y/7Ho/sdJOac0SfdxoMaKs7Tj3VnI2g6hqYuRWixBRxZPUse83C1ZgxNmZJka7YXmBmHh
	 9N80IDHyezhfAgqXxiHbYmbN9Lxavn9mjsnpqlW/JVklxDC7gxci0DQxxMAmm8Zzwav0H
	 3bf1tSBtUPt6s6TksN2tLBgGiySGfCy9CJgI3+RvB9KRogWTfVwFjJlXbyBn+OUpmQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794920504;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RTe+6VcPOf1eouGGB3XNAMNJdYSyIrM32M7JIMS1tWQ=;
	b=RyTBvwHvi+unKpgFahPdp8Xq+JeLTG1SEjklC1idDLbUO3dueHVx9RS6TE6ypEsRdAQZ
	 dVJ0qQVXMsKvMcAXQf62QDrDm3FZuBlYJ3qDZDWri5kSp6Ap66Bdr58IvfV6PHfBYyoSS
	 IA+Eci/r7/Ty5nWDCDiKgtbX4PX8+i28yO+6APke7fEzGaU7yKC1r6hqc8wt3OXxG5jgN
	 +Lk+IHjzV6PjK1AYX2pV0Q1GBqP0v8zrGFiQX7tUKTvzjQLIGtV+OBiSQHxMm46W8Xkn8
	 EZdYwvs3WhFaUSWHxZWGcC+cSQODg+g2Q+uhoW2HcB2BNXOR2Mr9vzdLbXmN0zGdPGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7E66F1F000C4;
	Tue, 17 Nov 2026 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920503;
	bh=RTe+6VcPOf1eouGGB3XNAMNJdYSyIrM32M7JIMS1tWQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gMR+Yfa4CpBuWFx+Hm5xplSUCOU3BEtzyd1gB7Rl1piOCMw0+ibzHQ5f426n0uAR8
	 4odl/hdONsqsyOR+71ZgYkdmf34Gwc1B2fjq+Hx7n4+H2cnId267H4WZLJYEV0We2D
	 J8xA7zq/e0RC5gnG1+xo04GmtBiQY6S3kqc/Xi7izSS1xunh1yjv8mo2bGpffDXK4N
	 3PlGC4V4arY0itRTCTMvXCpmAHsgRmNX9Wp6ETly7kNCTk+33tYJX78YGAG2rZbFDI
	 6QadYHcc6u91IDVEZNrBfxxmsborC1PAIij/DfceWBzHB+kmr9Pd8Yznqy+n9VakLR
	 gNf1JPy4rQPDQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0BDFD4A966;
	Tue, 17 Nov 2026 13:01:43 +0000 (UTC)
From: Robin Tetour via B4 Relay <devnull+git.robtet.dev@kernel.org>
Date: Tue, 17 Nov 2026 14:01:40 +0100
Subject: [PATCH] HID: logitech-hidpp: Add MX Anywhere 2S over BT
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
Message-Id: <20261117-hidpp-mx-anywhere-2s-bt-v1-1-e35f46d3c668@robtet.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMTQ6CMBBA4auQWTsJU+MPXsWwaOlAx8TadAAxh
 LtbZfkt3ltBOQsr3KoVMs+i8ooFdKigCzYOjOKLwdTmTEQXDOJTwueCNn7egTOjUXQj9pZc05y
 8O15rKHXK3MvyP9/b3Tq5B3fjbwfb9gXKGpztewAAAA==
X-Change-ID: 20261117-hidpp-mx-anywhere-2s-bt-fa1b995db380
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robin Tetour <git@robtet.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794920502; l=1331;
 i=git@robtet.dev; s=20261117; h=from:subject:message-id;
 bh=Ev+AfgsKii5S0dicVZKg/JxOksO8loG6ebX12jOZnYg=;
 b=LlC0m+6U/LVGNy32lI1wgeoOUn+lncpo2FYX52P/nWGG1jDRCgWMgi6viRHuj+yO/IYCoqTYi
 HZS3to78x6fCcGqgeJj6+kXtjvZRkn9Q/iehZkGo7x8iwZAlsKdxEcn
X-Developer-Key: i=git@robtet.dev; a=ed25519;
 pk=BJPkYl/vUfMfH9kETH7XwcLHLfC45Gy9+aWTTMkyFSs=
X-Endpoint-Received: by B4 Relay for git@robtet.dev/20261117 with
 auth_id=1549
X-Original-From: Robin Tetour <git@robtet.dev>
Reply-To: git@robtet.dev
Content-Transfer-Encoding: 7bit

From: Robin Tetour <git@robtet.dev>

The MX Anywhere 2S (046d:b01a) is missing from hidpp_devices[], so
when connected over Bluetooth it is bound by hid-generic and its
HID++ features, including high-resolution scrolling, are unavailable.

Tested by adding the ID via new_id: hid-logitech-hidpp binds and
detects the hi-res scroll wheel.

Signed-off-by: Robin Tetour <git@robtet.dev>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 27d83b8bbaa..4b266997568 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4936,6 +4936,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb015) },
 	{ /* MX Master 2S mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019) },
+	{ /* MX Anywhere 2S mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a) },
 	{ /* MX Ergo trackball over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01d) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e) },

---
base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
change-id: 20261117-hidpp-mx-anywhere-2s-bt-fa1b995db380

Best regards,
--  
Robin Tetour <git@robtet.dev>


