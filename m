Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268424;
	b=OPJa8eI2P6Ncj0rp/n0u9UXrECH3/3oOj+lC5SbSgd3ujQxC13LhPbuD3aLKH09iVgmP
	 GcHrhakU4854iBeDzvAUG7ipNK/eTn++7/r+HihfCFG4MZ4ZksgSY0d76AuS9oVqLYniS
	 ul5TEJ5xu5z5xW2yVpuO7+8nyLBLV6AHvz1RhfWUGz+9RED6PTRqN7/LbxpV+k5DmACBh
	 ovpmfHUUSo4YGPHbZaZshcQmSZ6zDXPzXRvsRK1AmpaHFgIXMBI3vU/ntzIBgar6TWe0R
	 ecWMCe2cbIZSeALz+w0/SjHBo0tQgYwxnl2Y6DlDOxfW6zdCKaiEcMdva6wmb5nCAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0SbZPVThhtjU5v2CJr4ClagjjvnIt2bp8J9XxZctWA4=;
	b=TCHaTeip/4Ok4ScERiT1xXmYZCXGu+2qS4T5bEaq1cer9pKTDo3bBa+fShcBzeYXC0TV
	 jxjeSaa58jFp8Ao3N4i2RjcqNN9fJ1aM9PI02kFb5a7SmNr3oMfxzq8HRCdB2kZR7E5RN
	 P3bZH4H4YzKF7QqhR5WxGVli4TWKWh8RmAezPEE3lJdw2bpZ94zsxlq059megTWBkqftM
	 D7w/dRCBcW3qm5GNPzcu0ke0akWI/4mXA1o9Jkte5e6JaiTe4ApkLOaAA+GXl7RQXiPEb
	 0Ph4ONSQ7V9Xp7QPXyCcJZ+BArEQrdC1picKStvPkj+FDDDt3HQofUgWj0UHFykhJRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAFFjDnK;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDC606A31C
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 10:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09BDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAFFjDnK
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a210470b49so15545395e9.2
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268412; x=1793873212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SbZPVThhtjU5v2CJr4ClagjjvnIt2bp8J9XxZctWA4=;
        b=lAFFjDnKXk3yH9RHcKlULdwN/XxVDGn0oMA8mXORaKO4pb2jDfGpEFQuvU2GdRYBrp
         odpaKHZhwiUMxt/EhkksTRDQKBX23YlXeGuXC0spnbFsv4oV/poSijzq+2qP/JhgEc/d
         kU8NIECqSVobeduQxcoT20A1EpeYj4nSO/JzjAojX4gqStiVhWoMojgLLiSH2fpGShX+
         K3p3JmvcAFy+T7yFWuGZT4Gj5Xow/XlQl/KVGMKiReFsU0RZOR2bCKv7Pki2IukrhFwv
         2paWFfgdWETuDBSmNXXM/GNoRDbiJtDQ8mQXuUJ9ku/CPcKcrrg1Cdb/NOBB0OYvmTVA
         Y5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268412; x=1793873212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SbZPVThhtjU5v2CJr4ClagjjvnIt2bp8J9XxZctWA4=;
        b=iZBNsU5cHOilAiVthzbZ+uPVYougYpTejeYHDvcr60tQdVnRIvWER0DC1/DCDtyMWe
         SAHp9hyzEUq/7QFbygAKFAIFICtM7mFGHmYB3whFEbJY/8Dy/lZkJ7POMZveGDGCghvr
         DrpnG7IEPo+gc3K3ce2qZj0eghcT2PtR1wpvMktg6N6YNOTXzx7NYrO9ujL+MKYOFP7g
         Srla6QWNYyb/XNesqtJ0GAYOBc9L023GlyvQhUntKCakWjF4/Ae48ONWehujz39ANd1+
         jpwVd/kmJgDBItDCCGwi1GCD2a9IEA+k3SLAMRTwa6ZWipdi1GmyW3tvPRquKP4GaDRO
         0fvA==
X-Forwarded-Encrypted: i=1; AKwUvBzpBo3w80EsAoFDf9n/LuAi0KOahRWNOc0st8jNeaxyrP0Fu+9KSKCA2lkii780TqFtOSbdlv6f7NNYrA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+Wb4QBu2lSyHJM/n7mZoQhaO5CqLHhafomY3i7ph0GPMGnF/D
	JVZxROqPox7TZ0iKntU6Ucn+0GFwP2kF/1zW/hALrWx1RrK+NTgTSQgK
X-Gm-Gg: AYBFou253VPqzm2ojhn/jzEL97ymfx73x/TcSRk7ND23YaVADlm+Ty/8cRM5C1c6Jfu
	cfLTWtjexnVeL2UC1EtcdLvdsciPvGAq0ckFLaTAtqL1u2+mlabfFe2fBQOBay/tWwCwO9omD48
	UPIvxsilGIrEgqh7Gl0LMClB+SpaqyAhEs2iC0RjNGYpUBc4B6eAslpnSt/yFlJ4e/YyvqVmX0i
	CAJ9tb+kSzbhHKPcsji55HdbQxVixXoD6ikbrkPB8oGLUbcWMksL+uEF0F4/fmt8u4fcO50gsNV
	gIBChBZBuZ8Km2ogCWNzvq2/7BBouLP8OwH4z35G8lpTUKN/2c0GnzOOX4lgWjW62nzruAWslby
	YWARVTorMrqDAcrsmku8xFb5uRvv8yUzIVMv857pLm8wsgdQFG6hBxQrwFS1v5JIBZVun7sN0gv
	Ub3e5cVoGj0I9XERXYnpQ+0+PIUuZ1bsSucCLEAjWHhl4qOlpDecrspzYzaMgrJ5qnDeNQSjC3i
	xeOKloI0QQG5sMLku+CzUJdHpmPy4hUTleYAfoke7piujKJbxuzTRycCngk4RmxWMm5m2VX8JeO
	vvPvUpci+7GnxIOCLjzNhV82TTlJkfjJx+YdYIfLX4ztdC+6q8OMkZMOsXb1vO1Ak1+pNWK4rMo
	/dV6uTaTf
X-Received: by 2002:a05:600c:4ec7:b0:4a2:a9:ed5a with SMTP id 5b1f17b1804b1-4a9660b5041mr117976975e9.8.1793268412452;
        Thu, 29 Oct 2026 03:06:52 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm53082825e9.11.2026.10.29.03.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:06:51 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 29 Oct 2026 11:06:26 +0100
Subject: [PATCH 4/4] arm64: dts: rockchip: put the PMIC into sleep mode in
 suspend on RK3588 Tiger
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
Message-Id: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-4-cb12621c1fb4@cherry.de>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793268406; l=1641;
 i=jakob.unterwurzacher@cherry.de; s=20261029; h=from:subject:message-id;
 bh=SDfGdhdTbDViPNWR7gWVkSFVjA2d78IFMYAVeDi6pgc=;
 b=+lV6mFqZezu/+F0xruZF+cG3BHg9hNr6TFfbzH6ls2C4+aEQv2qB9TmeiX4sbnF59e3EHmvUT
 spRbBmKPD3LBiX00XMbFZ9MHPNkvGrR2KGQSbwdMr2iUT+IH87yeXEr
X-Developer-Key: i=jakob.unterwurzacher@cherry.de; a=ed25519;
 pk=0v1L7pjG4d7PcaYPMOmzP4SjaRtnB+8bMzZLZCRzB8I=

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

The RK806's PWRCTRL1 pin is connected to the SoC's pmic_sleep1 output,
which the firmware (TF-A) asserts when the SoC enters suspend-to-ram.
It is configured for no function, though, so the PMIC ignores it: all
regulators stay on in suspend and the regulator-state-mem settings have
no effect.

Configure the pin for the sleep function instead, like other RK806
boards do.

Measured on RK3588 Tiger on Haikou, suspend-to-ram with the logic
domain powered off by the firmware, module supply current (5 V):

  PMIC pin with no function: 0.218 A (1.09 W)
  PMIC pin with sleep function: 0.086 A (0.43 W)
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 161c89c62bcda..592a2d11b36b9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -471,7 +471,7 @@ pmic@0 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_slp>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		spi-max-frequency = <1000000>;
 		system-power-controller;
@@ -492,9 +492,9 @@ pmic@0 {
 		vcca-supply = <&vcc5v0_sys>;
 		rockchip,reset-mode = <RK806_RESTART>;
 
-		rk806_dvs1_null: dvs1-null-pins {
+		rk806_dvs1_slp: dvs1-slp-pins {
 			pins = "gpio_pwrctrl1";
-			function = "pin_fun0";
+			function = "pin_fun1";
 		};
 
 		rk806_dvs2_null: dvs2-null-pins {

-- 
2.47.3

