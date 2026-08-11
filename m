Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB8443E5E
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450878; cv=none; b=TUoUUAk51Fv361NgnApSURHiImvxXknrSWI21iRxUAn1DYUPhX76/Hyv768jDUa7ZNAr3qeqGTvs0z8uK7+vJ59SwEroLoy8VML4pNJSNqLOc/0zdZEJ5w1XdFw7vLY2d35QMVeh8NJWwopdpuCdEb7I9R4JnMEFbU6p9ErmZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450878; c=relaxed/simple;
	bh=zw9K5bulR5RCbQzcch5UFQFm1ClqUI2Eu5cBqRJdZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGALX0YA8Nx+ySTZYY9Kx4b4VLKL1l711nTs4SultSU2rkxQt/V1TxPJkSMYiPen6wgUq8EG1jbbby82LIze13G5Ck1e1BKPLfZ89VgglhOgsguvo3f23vTrQyDKjtn2fUpn/jNNBzECbLEtjHvuTfJ9SZHd0kr/UO910t3vOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R55gbYpG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R55gbYpG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so3276778a12.3
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450876; x=1787055676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5LbZtLdzstzREZ48zu7bbbJyct6fe22QDz6/0rMi/0=;
        b=R55gbYpGy9ivCS9D6o20yhuvitL8znHDWJg9vGlJX7pc61gdH+juU7lECmzUNwxalZ
         X7ngyHVEG78QYf/gDywHghwSBg6snPASWUBoMkrYSh01D7Hv5ar7wcoKThZtwcVMNCeN
         WCOuw0GFCnRP/BYWSrGlNbLUfBiebsCV63CsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450876; x=1787055676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5LbZtLdzstzREZ48zu7bbbJyct6fe22QDz6/0rMi/0=;
        b=GiSH9uelYkBpnAZswQ9MJhrs0aWoMJHGzY2WLVUOjwmD8upG58PL5rUg/MVyLSLzc9
         zX4f66ts7gaAD/LHtR8HtX+WHp0+KrieC3zbQI7p7eaieKeHczxoBwh28yx4pnY1A/MC
         /RbuUxHegJdWOmYs5pdPGY05cWKW5U1dQTtYrsbEegv+2BGadM/Md8mSj4hbBv+HevMm
         p9q4rLYoWrjiD2U0Fph/ZxmwmtualwXOMNdfdAoR5U9IFtwxl8f3comg0lh0Q1KXCh2+
         im/C89K9YS+ufXotTVJIOVx3TufX1lrJW7jFYmfxwSQginjtqwYJbXvqBChiiGWdirA6
         L/Lw==
X-Forwarded-Encrypted: i=1; AHgh+RpuRyED2tIS10uqe+1SeDvGVuPrWH5wublXhwCadBx9J5sqCtz5h0TWfNo0eW4mwUndDB+lFk/AFu+l6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKrGRqXbRGzJHmHOXjFMn7XrVdf2jrneR9ecJGpKoaMvw3ssM
	xgGIW0ejxdvQUuEueCe4SEDOHTvQ3355BUliNKiZ01dyYYLG/8p2ydERvZ9LCX9uVw==
X-Gm-Gg: AR+sD12n1Ok1EFFa2eQO5fh20HjUDZX+U8x3bWYkq9e5bFMz+flQHcyRsQSKOuvpyjG
	/M6njvJ7lCyYzbGm1G8Pgm4YTN/1psMdCFiL/ZwiBxErX2UmD/sVuQnUbsUS1nENakh3+s6ehVA
	1hk4kU14XdN31Vkft1hakYIB0FUGq3xAFV7JfFfnVdK9rU0W6LQA/7s7iy6rw2NRI0pegtEmD89
	9Yk6LC66rwYnGIQ/5ePdm0MT+wcUrgKPzhggk/ckshsLyQOFH/Ga4dYWNiS627/KIqMNw9uPSpP
	jpBx23bUH7XWo5WYTZO/yEXRAZRftyjvadT7S1fXmSHQeoKvkImvn1kkDgNmP6eIgFZn6xrjOjx
	Jxbb2bb4OXvNdMoDkewHSs5HRiiNTUUmGE/XaLZFmLcBVwxnrdCWyhQghUR1PuNBJQI6Sfhgu3j
	JHEvVQNiXyExkQ2UOozb+YGraKSSyaQyCiMN3EXV8p0m721qp7nUUXA+kh91Iwq3Qb+VYDEALen
	G8ukNfxQLRozekGyAnvIPHrrSydvXpKQZMpXuGaAdSCuA==
X-Received: by 2002:a05:6a00:234a:b0:84e:915:d7eb with SMTP id d2e1a72fcca58-84fa8889f0amr2532844b3a.37.1786450876479;
        Tue, 11 Aug 2026 05:21:16 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:21:15 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v4 9/9] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue, 11 Aug 2026 20:20:09 +0800
Message-ID: <20260811122011.3539250-10-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
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
2.55.0.679.g6767b8d81c-goog

