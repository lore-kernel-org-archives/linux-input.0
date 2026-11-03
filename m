Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680700;
	b=SMjHLIn69uBnhkOxFcDFFtIcH7A6WPcfch5ESpUZnD7/R9LQLCpC6DuceNi9d704xA72
	 7wcn2K/EkLZP+vsqzqRhj4MWy1cs1qyAEtQyyZGqVho4CGZh1o0E9E+I105toly4dVmG2
	 uwVSN4Ny2nKTnizwJkFuU70xtubdpTuuT5NuqlnSwuu6VPOmm+i/KH7mjXPIp8Kim96zC
	 3L8/aebbW6+iePnJZxfAsHrslaV6RfCA8s+sK4MOEI9VwlWZiJlfFlnCA4Q4Mx5f9w/1R
	 7GSB5OjkKrx+eiJcB0+6UCU4rpXxUIbUQn4HmGxfSYNxq2zVKNbBz25ayAl1f/UxH0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wOgLDWMrbGue3Y3ijnkKX9LYoTRtoFaZwaUPNmihNOI=;
	b=zHyLDQ6IMzILFaZdn2I9SOqHxxxwCoKV/15lV7EBe/g7859Gr+rqCh9WHbSFV+pi6a/G
	 x1U0YheTJ/WALoBmioz4n/L4s3Gur+HTyourqWBLCwNjHiyCTcu8i3bBMdxIjP+tknb16
	 qasIMmpxSfi9MuKPxL3OgxtLTBs9/PLrO7twMJkAQ7K9xIQVEwLVurJUCDOjdyZqp2XQ6
	 fo8+/AiKVBQaxZ16mSUL+yPcgxw8Ln2SLOdKh9PKwpMHznxBUcb7vKBjDp8fxXfD/AO6k
	 ocgg044bnep/ICjW29Ucu34WfNc+69XvGK3+upTnNFPpVt+KRbOU+hmrXZJtOK7o7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XElVPPXI;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AA606A32E
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B92AA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XElVPPXI
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso143263a91.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680699; x=1794285499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOgLDWMrbGue3Y3ijnkKX9LYoTRtoFaZwaUPNmihNOI=;
        b=XElVPPXIpP6fosW6+7K3jVrmtXYfBRPTpzAlgEI6/7G5HJ+9KEJPQ3UoWAaex8SJ47
         n5pY1ZRXvWc8XMYoR0maYVkdsXoSj0uwAHnNUnJyH3KKaMRiAFJdNbx6yD/d+aqssFad
         NSUa4WrlOGyXMenr619P4qq1AQplaGBT6NfEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680699; x=1794285499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOgLDWMrbGue3Y3ijnkKX9LYoTRtoFaZwaUPNmihNOI=;
        b=V6slfVT7wyFy7ZNmLvXuoF+o6U+9qckmnZyUWcOzI3uJHzZ18Imqm3zEEJBE++3WBu
         4k0CeCtje34AaCfDIt4AFIg+RMBEi7VZYhH80OtIAy/D/0jfhwr0kExjIkubhDEFdu8/
         MbcuuoY6AEzJEjk9KjMuU+5str4xuX5EfJ4LMttheQ6hu4Ht+tD+gtdRF8B5lZCO8iFg
         ENuF+5su3LfV3yOdAu5KhgpC0/T7JyqQkLfufLFrMHh0TOCZwK1+CSgk4ZRhzqnWjRB3
         BV8fycYaAx7e8rURGGK77MG1xJuHd4BA+c/84/Lic2YRrc8ZwxtndYrC3a9K4RsI8Moc
         itwA==
X-Forwarded-Encrypted: i=1; AKwUvBzKrtCtonQbgSatIJ75pawhgeDYU/m7e78AJCZ7M6dNwxsX2yJLN2g0WcJrTPcsN6FWZ+yNGmvF+ezJHw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/g3U7URsXaR1jwcd3lRQDXYbH96f81WRaaec3FuHy5bPcB0eu0
	LiKN1fsVY8fYfhtHoHL+N4aGK0HSLa4uDi6THla7fMwQl4ysDGQpkYwB3pHgPW17nQ==
X-Gm-Gg: AYBFou2rQwc1DebGSeYF2SXoYJbusR4UybCrFzPEQAf0m60dMCyNSYr+GPqDJUItZO+
	2Ck7SWJFkkJUSS34RgOkA54xr85tSPqoScqu6Nb91hFDjQu0GF3y7X6FA3i6lF04pwGKR0AC/wl
	0CS1Jrjfrg1H6lVCmkfayMA9ZANN9m634GgqusdJkc0mBCFpnyTCdnVdQiIT1sa2emPEyDsZytB
	NjMxDtaJp1b3aV9VzDCOTUBwCTp74y7MnAFA62ZdGrBx3Bk01ofxaC5SBnu1XxB9KOvaZK0MzAm
	wHtxSQVJkV70n81KtCag4vCXEljEft4m9jtlCdgjXcv7gVmDfC3n10JhmPrsZ217zUs5fyXIKfw
	AKT6TAwhEFXuTyF3TPSwXDsj4rsX4Rco9VsMS9mqSBjWS5mI2X4QVasJLuMx8Avcp4pEYbbs7sL
	eqkOWpGOWUaY9Bk6eSavjg3Ft0qp67LDkMdqWVjQ/deBLpc5T7R1vrUoGOOG62jMGEGWj1Bi0rk
	+i/NzlSZ0tBtEf6oWV5XbCpo245ycuF4VaFWbxtqwf482eybC5sUrF/wF8bkBgK95WTFcXX/B9X
	3G6ii4BwUjBd2J/qyKKv58f4CFif1jUhX3+YL5moUdRxfH9rvHYNvIW6IiMmdKcLzegWziZpjuH
	YLJ2ybIlU6bLGrxD4oLrISMCTe58TTQm/Kg==
X-Received: by 2002:a17:90b:280c:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3ae8972a6d2mr6631601a91.18.1793680698982;
        Mon, 02 Nov 2026 20:38:18 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:18 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v7 8/8] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue,  3 Nov 2026 12:37:32 +0800
Message-ID: <20261103043734.2179858-9-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
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

The Synaptics trackpad, like the Elan trackpad option, is fed from the
system 3.3V power rail. Add it to the trackpad device node.

Also add the correct post-power-on delay, even though in practice it is
not required. The Synaptics trackpad requires 100ms after power-on (or
deasserting the reset, whichever comes later) to fully initialize. The
power is always on and the reset pin is not routed out, so the
implementation could try skipping the delay.

Cc: <stable+noautosel@kernel.org> # Without driver changes only lengthens probe time
Fixes: 925ebc0cd55c ("arm64: dts: mt8192-asurada-spherion: Add Synaptics trackpad support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
I think this shouldn't be backported, as backporting it without the
driver enhancements just delays the trackpad probing with no real
gains.
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 68caf4c58cfe..8adbfc307fca 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -94,6 +94,8 @@ trackpad@2c {
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
+		vdd-supply = <&pp3300_u>;
+		post-power-on-delay-ms = <100>;
 		status = "fail-needs-probe";
 	};
 };
-- 
2.56.0.385.gac671c819a-goog

