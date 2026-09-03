Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF2486B9B;
	Thu,  3 Sep 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431520; cv=none; b=rrx8fHGNXZijpKWXLrfs2jFajke1ISS28x7Fh3Zu/hVPrl+SDru/UCvlXRkj4+sfV+PMlF0CwzPObnrgt+EciyFso6z1qLhrlWNC0HvIqIVhAiZv1AgbIMXam/fn9omrWXSRdKH6depOFDzZ34tHyzsX98hyP9VhUf9UhafT3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431520; c=relaxed/simple;
	bh=Ehc4EZl2SLZA27hMfqTgeHRd8H54myUhxffBoclnWqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cj8yq6d0aTvxkHlSBw448HrUVidGYG6DfUqqIjhyTJRTTg/6MzzrH34yjTry8UGS/B0rmbEmtMCJxA3VW4LfS3XqlsmgJxdMQXY1CLVv6aV90V/ezQ7cNjqKph22/lOkl1K6kihXBzmlzI3qlftk3NXum/yZPCkW+AfUCM4ZgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Bu63qK3j; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ypUX7iXH; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Bu63qK3j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ypUX7iXH"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hbG9Y1TbGzKmst;
	Thu, 03 Sep 2026 12:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788431505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BiK27gDNsR2NI/ibcQp/wTsdch5dOdFbw9RLGjdnjhQ=;
	b=Bu63qK3j0/pruYAxenYyBN8V5WOraspMBkozBA7R8crf7tHsax8I5DhSgotMhNpfQlKCp4
	Ly43fsx/fSGfIFQw9Shzy115GLINBF8JYllj7Jo8lsXewPKsV0eeXjnY9b4K9tyn338R2E
	J2wBpLHKPrGIkjJWPgVNqCjovRXKjble3Lni+gjnozk2tawfxkYms9bvp114qWVgqkBH+7
	c+HOu8b/YZy1d30RbhwV09HTuvDUB8pTE2Yr3VkfVxHbaajLpm/OTctJg4zyJteQx5sg5B
	eEuYByN7brMF9hcUuPmsVbGHgzAbJZZTsQGcV2vwoyqwtDikP+GCKtAifE6s4A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ypUX7iXH;
	spf=pass (outgoing_mbo_mout: domain of byt.es@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=byt.es@mailbox.org
From: Erich Sartison <byt.es@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788431502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BiK27gDNsR2NI/ibcQp/wTsdch5dOdFbw9RLGjdnjhQ=;
	b=ypUX7iXHffS0jwEjYyt5x5JhXiGEpMm6zNi0p2QaWuEGSqWUA9WbUNZUughIdYJ0G0mGGV
	HDnGoRsOvzz9EDchB+Zu2/b0ybn/AQ0xGUlFBTq8Drx15AXXxbPYM4shtHGaHr1OoNnb4r
	5TC3ZvVsN3ZPpYAJaMkXNwbkaAneqK8s1A9lyJUeIyChKi9MAmLcN5E/6/O8H3t1T/EW3K
	9X4hPxfdKSEGGeCCiWeq1lbT0lE07N3T+Pa6adlMhYDkrU7vq5WBz1Iy768O019RFUMyA6
	4Bg/H976Hl/LQqqPWO/Ty0TNH5IrnVCH545d4cvDYiazhqOr0Cb4nTgM44c2xA==
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erich Sartison <byt.es@mailbox.org>
Subject: [PATCH] Input: xpad - add support for Victrix Pro BFG Controller
Date: Thu,  3 Sep 2026 12:31:37 +0200
Message-ID: <20260903103137.630170-1-byt.es@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 31d3c39caf6fb18a151
X-MBO-RS-META: 91h7r6yjnrq1oh7ew4j8myjsw1guferp
X-Rspamd-Queue-Id: 4hbG9Y1TbGzKmst

The controller doesn't currently work via USB-cable.

Signed-off-by: Erich Sartison <byt.es@mailbox.org>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2da0b7f17..da7602eab 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -227,6 +227,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x024c, "PDP Victrix Pro BFG Wired Controller for Xbox", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a0, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a1, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a2, "PDP Wired Controller for Xbox One - Crimson Red", 0, XTYPE_XBOXONE },
-- 
2.55.0

