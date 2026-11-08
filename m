Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122715;
	b=vVHGWKWW+5KonIhHKquQTsXVxJpUBDMxMDc7isid0wV0tluE9Cx5IbKJGHjdf+K8OSMr
	 +6Rtcpkv1HIzgfred3koLaCoYHxGSeRxbSmeTTaitdqV+Jae6zQThawR9MV8Dr4cYAaaD
	 d4/WCzAaqTtu9Vs22Ggt7JkTDHdhePKCgqEjJMklHe+cXhVeLVxden1M4mccPfzaDJLGk
	 q1bNnaBzHV/y2jHO61BhGkkJgPoADp9IxPsvnmSA2REmUie1OqiAV7OdgwjREZm0JnEmq
	 yafMzd30/xxfHJdfGoydcNr2IdR+o+n9MviEhi9AvnDuUEFOjdXAN/XEXEeBU50b6OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122715;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zRB7rwqmRY2LuYlyLM/gqxBcgYofPW2PHvkbGtfLE0Q=;
	b=k8FPbmBHkcLDrTVAnIKZvL1BKbOknRy2nGnL2qfZ2BhRv+yZOaLkLTSocq1XQbckEMDA
	 Fd9ad/98HHAVLVYDGdIq/HDa94Wa97JXV0Js5QfcbZd4z83MNCZBuu57KToVfM+jHBEHw
	 63iQEawkXTs9we6eUULWqHkb/YLv8hisToOS3c9hn2U5yl8k7PreZJ48U4UgdQtI9Q8qk
	 TGPQc4GU7/DY+VV6fCI6ypiXQJLC6gyM4KyYDKn1cu6l0d/2vNQ/Jf7dhyuYgPi5dbpfi
	 iyX+WYlOPK+oUfgRl5yWbpJvtBZJMH+fV0QepIHuyUySti7htDSglwbBkWDedeHiL+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtjN5ruZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2C606A335;
	Sun,  8 Nov 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtjN5ruZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794122714;
	b=jmDEABVIc2KwWtQ4TQf9LrPqRKz2rQxjlm8AsPVnh6KjFcnUHCPSo6i4CQKLlWxWIAJG
	 M5rmXuLpV/KiSR/PoyF0E1tt4GnQT69KH2etzNP1Iv+jpne/zMot2uYXPktht8FTGen2O
	 Us4psaTE+mpnf05jYBNs2igxTtCgLp/pBpysffluGRylmD+tel0ZJHcKJd6u/sL11a6F5
	 OaA8+dDixv9M/MS/de1FoA3LUMUbSj8mfp5LmhI7qjVIMQLHFgDKwJGB5c6kLPIIy91Fa
	 jf/43rbjQeX9na2gwfHxD5Cf9/6B32JA1V63lS2mTnQV0U6LprdRzyvYKVEnvXH3Rjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122714;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zRB7rwqmRY2LuYlyLM/gqxBcgYofPW2PHvkbGtfLE0Q=;
	b=ARiZyXBdrEvbxi1KTWQYD0cS8VVsjtM4b9Fb18paoq4Ryqg8XMhNrO7xkxzX3mR0/Nel
	 e0wShtc3Rpv6U7xVdNSz8Vzvwpc5DoHV17KXyqkkiucT0ZkACwb+lExBsJYjc69iUG8Pn
	 aoASS/k6V0GNkhYF4PFsaUwgvTUjhjR5DrB6tTRaMBpDVvfy5IIiEuAvnC5sSnDuFs6t2
	 XsisychgcGSXcbk9op6fPIc6OLplybiY99D8HXheuZ7OPWbbyu0NbKxMzbYrMoBCu+Ety
	 NtfdlWDN/mMStFZVOF9WGZk7EvtafzGkfzuNDPMBvN5F56jOCCle631mAwUSFoFS24g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C15981F008A6;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122714;
	bh=zRB7rwqmRY2LuYlyLM/gqxBcgYofPW2PHvkbGtfLE0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MtjN5ruZPNolCHioKUjEtBaz7Tj9rahkZ/Xe7SptUjGV7Ro8KjkFVC81eHdBhwv21
	 q7b04FZNwkxdFVFxWUR3AEJJwoMtFBV8kTaQl5qv1ITIySy/tUyXLF5iHcyCmcuoeb
	 ZJOA7sFXUWaerl+ZjEogMXiLqSmhcmO6ph6fIm95FoFrERN/UWdr6FZw/z8C0IwDWJ
	 On1mx7Vk2ItGxoLVVAlIdC4CswxmkZwzeVCKOKdFYXD+I80x7lyB9gnpoJ3OAWSR9y
	 C6O0IS0Ty3MeC7kctSw0xc5Te+p/R4JSKZaxEBF4LfAHioRupnh7Ev7kuuLmiXFm8V
	 PleCPHLrRT6Cw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4FB3147E63;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 07:25:09 +0000
Subject: [PATCH v5 4/8] soc: apple: rtkit: Add tracekit endpoint
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-b4-apple-mtp-keyboard-v5-4-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794122710; l=1200;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=mLYyKOITM/jTtMK0WXkDAyPYTTFaFy9v6Ps6Q8WNUHI=;
 b=yiCbQT+t+5q+O7ZI0VPjarqlMZW8OnLxDct5ORNSpQHNzQgVz/BKBVFVL2gHYk0+7LVjY/IwC
 DuvqVYIDKt1CIhwTVmT0nT/RQEa0iR4Y/4CYzSy8yNTkdbc1UFPs8Lv
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

The TraceKit endpoint is a system endpoint used by MTP, AOP, and
potentially other Apple RTKit coprocessors.

Start it automatically when it appears in the endpoint map, like the
other known system endpoints, to avoid warnings about an unknown
endpoint.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 drivers/soc/apple/rtkit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index a3fdac8f6f06..1059b4bd8732 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -22,6 +22,7 @@ enum {
 	APPLE_RTKIT_EP_DEBUG = 3,
 	APPLE_RTKIT_EP_IOREPORT = 4,
 	APPLE_RTKIT_EP_OSLOG = 8,
+	APPLE_RTKIT_EP_TRACEKIT = 0xa,
 };
 
 #define APPLE_RTKIT_MGMT_TYPE GENMASK_ULL(59, 52)
@@ -191,6 +192,7 @@ static void apple_rtkit_management_rx_epmap(struct apple_rtkit *rtk, u64 msg)
 		case APPLE_RTKIT_EP_DEBUG:
 		case APPLE_RTKIT_EP_IOREPORT:
 		case APPLE_RTKIT_EP_OSLOG:
+		case APPLE_RTKIT_EP_TRACEKIT:
 			dev_dbg(rtk->dev,
 				"RTKit: Starting system endpoint 0x%02x\n", ep);
 			apple_rtkit_start_ep(rtk, ep);

-- 
2.56.0


