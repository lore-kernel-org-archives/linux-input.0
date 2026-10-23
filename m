Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757625;
	b=oLIomtd2onAcVmlaepc+/o1N/rpHwkJ3vjt+T4oDNMoYPuu5AgJ10/1lL69qDJthxNOH
	 JtvfHdvF3FXaV8r9IGWJKNSLK1DfioWsc1vosmy5A3FntWUHD/vWlH/nUlvD9qjNO+PWB
	 KRiY1pE84/KwYoQPWujjSZbMLrlnA6yAt0swhh3jEJtpVLxus6FIYGm8bPm41IyKsE2Qg
	 G3U5ADGBJ2+awAM86ZwnmUR/Dy+4qU7dD/4EtyUJsdDF0UJ71zrE3++T/S16/Sul+sGWT
	 YMkmMGoMFZehROITDgIYUjeCCgtEWZvcEYCH6HZ+9oFrvL3yIf38N0hUBFOtvMKloMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757625;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=esf6+fC99Past2jiKpp4MOmbHxT+yS3Uz3kj0K1GZI8=;
	b=OF4j/u+taBVWzXrnKdP/XkDJqoZJeSp+PQqSD2ULJY1ou4w/D5axoZLYeT+MwiHiqQJF
	 yvF6xlsOFKeEUr0y9Fk+wX8DOUWbRSz6QvAMp8iwv/CUDeWSaXp+EKj5zCTRXi6HLFK7O
	 cHGf98pSLDc1uqjd0VR3tPdS/RssNIRZIqZRu1M96PHAn+nUJ+ttm5t82FQ42WmYzH7ed
	 m9Zr5k9PMq2OP9aQ0nUSgi5XMZytOjSBOmjoyUDZUciHf1fYf3n2LV1Kv1GvxrP124U4k
	 83LUtznLD43x6RCsn3RbCRGdTspujZRxMAiJb5SslRQ+djAH3I8xNpldQWiwaIalxAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phnx47.net;
	spf=pass smtp.mailfrom=phnx47.net;
	dkim=pass header.d=phnx47.net header.i=@phnx47.net header.a=rsa-sha256 header.s=fm2 header.b=TWhtFd22;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lqe1GtOX;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E7606A31B
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 12:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phnx47.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phnx47.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=phnx47.net header.i=@phnx47.net header.a=rsa-sha256 header.s=fm2 header.b=TWhtFd22;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lqe1GtOX
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01C3B7A0187
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 08:13:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 08:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phnx47.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1792757623; x=1792844023; bh=esf6+fC99Past2jiKpp4M
	OmbHxT+yS3Uz3kj0K1GZI8=; b=TWhtFd22q5Zv1xus9JJG4JLOYlwXeuOGXbFpd
	SoDZ3PfnGjsOhvQsJUPEq5/rnjUHukzmA8bbviBSrX59PMicrFmpWD9KAqyROznM
	pu2Adj4Y/AzifSJa3PusiyAH99lR8N3frSOzxwyEohblH5x9rK9TV+atABAqzQme
	INPJgn7QNFWE1U8KV2+GWsQbH2P99PoJc2T8414xsHlT1luH7IEqPyteKzlrv1yS
	QK8osOrsAUrZefw1DpOw1DDZGtsiKDZ0oJiU+EMT71PXk+4AQSJxhRgU2H1fW6nU
	9r5uEvTvQqTI66Nkmwntba/Lq0YB3F4BW8NJGIbxfuKRdWR2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792757623; x=1792844023; bh=esf6+fC99Past2jiKpp4MOmbHxT+yS3Uz3k
	j0K1GZI8=; b=lqe1GtOXe4Kzn18E4gr8jqB9bv7gRbAvRtiQr4e2d8bTvhCoO1Y
	GLzCTyL7/HWMrpOCCa1T7eahGXwCBHwkRDldIzskr25zl23dnwLYAaZ7ZSnaqd3S
	04PdIkbcqWTaUluLsP+ada390SvFR5RAEc/hzRWbfGzRInROYeWSbs4CS2M1O7I3
	actTtpTFViWjkyV4ao+r4Yl1O1z/oaqoSgP4f6AL87wxsE1QU678ORnf/lD+SD22
	rLPitIqOF2/aqlab1NvR1OQcmOZsKvcNLdAiV9peCmFY8ayGPZFt3HgXRItjLIjr
	1jTH0jsceNk7AtpNueaJuEOnaSIOvT1S3Eg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=phnx47.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792757623; d=phnx47.net;
	mf=PGtlcm5lbEBwaG54NDcubmV0Pg==;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:D44idULFZG183pIeA4N3CQzvIi1hYBBkdadaHaRyCELdCx+
	KBz1YZaV2k5/kG0fJs/MRr06u03GScmxdgDmsOIjjvO6mKm1EDw89Ph9Qk3sEKc1
	yP9L9FHX86rxv+Xgm2oC+1UNnE7Ho7xEGyBdr+xQcClxlY/T5TYRtEPU31Iwe8Kt
	SW09yQR2PaoCG+s0xhAJnHLxUiMKYhnJnj03GaicLqomlCgMpNTlt1X8zlJCzIJk
	D8Nlm77iB/2NgLwNJNkZGqdGSn7kbZPCQz5q6VakrF9HB5KKVrxtNM6QNGucrqmc
	OpCkWDp9JC+KhuE899baXYooPtgtZCcQ5beVqFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:zMCKGN+7nZw9BrOsKewU8wdiATUO5OCUQhoWuNRxttU=:Uj34o7OOyqkQfa/OFAa7bzD5YP+KKaaSTAlIzb+TP1w=;
X-ME-Sender: <xms:d0_bai98uP8cI3imZh08igk2YQ-ZReKLAmFsQ988jvbueADDAa4C4A>
    <xme:d0_baqIRRZA7_JnqLD8QxANyY2tUDUpopUAoD--2ZPGa5r3tMQ3AIaUupJDsji0fN
    _s4WqDm5i2am6oQ4B-iQjhhbBCijD-MJRuqhhBDALskyvgCWbqm6u9m>
X-ME-Received: <xmr:d0_balYWFm0xTs6FgvqjOnz486bLuGyqlriV6xH9nJ95jeSyYAQxvyY>
X-ME-Proxy-Cause: dmFkZTF/wF3MS6jU5JDXoIyymrkoQ7s4RWPwASGl0QP9jb8R80hdbXm8Uj1Ogyqe4WvrtN
    DLEQ3jktpIpDLzGEOaw5p25O/d5YZHkL1Cy6Nbx9w4RwZBOVu0Ngn71rFxBZFNH4VfO08u
    jmw6IlHc3ccXa/QE1E9LdJhr3O12Kxmiz9d9Dy9/iFH2hOMN7qxXU0N4wjcwkWsLxo0ZI/
    8y4AQhBlqfuZYtWueb+ZIbCQBo3K/arDxkrrnemDoZWDJTr9FVKin3peXdhwBAd1vJDe7Z
    D3NcLc0ViuVjUk/4QYyighIWqHeqio8BMLBf2SC98nScrK0DtW66N4+/CfhrMa+CjB4sUA
    dDcsL1dx742zxMFNxUqQVtkSYkzsJwU8C3tb8CUHGia3zSpuufgmIeL+cYPMgk8pVlLRXB
    NsM/R4UwYV//vAyIDPWAVA+pKtrjbn3F2Zgdb/2qJg+y0ozT/OFzHb56qTskmtsgGDu4Zg
    o9AEhRCZeEeyqK8xFv7WGlXkdRkqr6Q4nYmo6GhUR1yDUzaaMbZUOU3Wtgv5TLkvCk40uP
    q+F876LcHjoz2l0/tvmryYtOFG9PYSvNfZH6mLxqf+is490FwxUDwb0MEMiB6/VDxJv0WV
    xmWDGCCnfT8mIfe2JtszXl7WuLxTpQa/LaL8CfU5EOK36gVgrMyOYE1GaxNg
X-ME-Proxy: <xmx:d0_bakJKi15IervUGcu-pv9qTJaabbKNoptSZ53MSU15Gny61J11GQ>
    <xmx:d0_barBlP4EfjBGyQ0ifOmPtJs6mJQQNi_6MD8kgiQNGcj0PdNQ-sw>
    <xmx:d0_bahrtK2ZCtqpoNVFH6AkxhV6UI63UpsRTEHCR9n46g3uaKYU2gg>
    <xmx:d0_bauhZhIWHc7gw3Nhh-KzbKhVE-uWUnSgdwux_c5DrifeQ_Uqbmw>
    <xmx:d0_bamJa-mkpggeBk9T0sm_y8Hg0NrQ1AJ3kMrTOLgse5VzofbhzXx4H>
Feedback-ID: i8fe64a8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:13:41 -0400 (EDT)
From: Sergei Kuznetsov <kernel@phnx47.net>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Sergei Kuznetsov <kernel@phnx47.net>
Subject: [PATCH] Input: xpad - add GameSir G7 Pro support
Date: Fri, 23 Oct 2026 19:13:14 +0700
Message-ID: <20261023121314.8024-1-kernel@phnx47.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the GameSir G7 Pro (0x3537:0x109c) in Xbox mode, connected through
its 2.4G dongle. The controller uses the GIP protocol and was already
bound through the GameSir vendor match, but showed up as "Generic X-Box
pad" and its Share button was not reported.

Set MAP_SHARE_BUTTON so the Share button is reported as KEY_RECORD.

Signed-off-by: Sergei Kuznetsov <kernel@phnx47.net>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d2eb48d98fea..53fd3b562f41 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -409,6 +409,7 @@ static const struct xpad_device {
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
 	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x109c, "GameSir G7 Pro", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },

base-commit: 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
-- 
2.56.0

