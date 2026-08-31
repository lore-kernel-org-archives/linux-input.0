Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23427405C2F
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199882; cv=none; b=BXDf27B4snBcl+bcIHaZTQVyYDhzkk6vrNaxmVSDt7S/rlH2MyTdAP6wdivMyu08D5QJsBbSRqAfpUw8lEwKWV0GvyMmMCLI6JBWYcTGhvm9Ki8GW2VWjcflal6aJ0yiBB1LuB8bVYwCj73yPqOqioCxH8If69AM9NVQ+qMN6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199882; c=relaxed/simple;
	bh=degjQC+zjZgSfRxP9sOwOQK5Cf9llwpDDwc6foUp9Rw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Br285R+mJCPAqlZUihe+iLxbej+roZ0eKjYJAQJBa0j6HiaqEksMRCwvUOyEkulxluh/MpFRzq/LJBXjI2SiOxyNICFlcXBQR9rlxUzknwxHLe7xxkRwpDaVJn0SC4TldeGj2BEl25B3ediC1HKkhcGyFOiLPiwNpJQflPnPRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LozW1NON; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LozW1NON"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d715f4a587so55094835ad.2
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199879; x=1788804679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auz+mSkwNmUJblKIK/SlZzO4mv+o8fMJykvfsBMXi1U=;
        b=LozW1NONM4DwW+QwagEX73asol810NEGPGl9L7R53qvFyqRksJeEMlLjwJF9xstCry
         b2VgKfqyo8UqsMfzLNM58HLFfRj5rnzZYxp9RQvBCAssXH40FeGr/KoZTxtCzAF7gwrD
         gBRxgDYwEyMP7Wa9BTa66ciCwsV1fuEcXWVLZIGIlq6ifeE4hBc9aLrHrOJV9kJQHUQQ
         5eGVtDmdQdxkDMhT4fuPWFGtcTHcOgCSM9HyGqWVw/QPb6M8snzfOECeBDj8qYsBROna
         Lg6FU2CIeCslLnUCd3FoIFm8+d+UTZOOlo+ys/RzKX34ap41iV4TC6CrmW5qckaYLNqk
         bhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199879; x=1788804679;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auz+mSkwNmUJblKIK/SlZzO4mv+o8fMJykvfsBMXi1U=;
        b=sN9FRLMAlGC9o7t0JIIMSfdLgCRPGVAZW09PBfUFREpOsLL9wq1RIhsfyvPxSM+Jsf
         QjaqNS04QnWlpVenEMIJWPcpPtmvmIVWb9frC3Y7KqNsMBYx7hxc8ZysZtCeN4coSCpp
         CXU3Npe3QhvNpNx3JyWN7HOCPZ+ZVqS7AMIrWPFI4uHr+3X5QlPpAC5VbTvtsRxScsJU
         NoY0OHn06tsLMlwzpjq8ul6HRpP61KCfNxndk+6Vt1ulqHMvOQIP3xjuztDo2FsZ6CeS
         Ok6m+ah2vFtplPnsUr2LDv+XsfpPyVPv+WuOdRNNXnFsD+MIJdoihoRYoJssZPwpQUhA
         vhyA==
X-Forwarded-Encrypted: i=1; AKwUvByXoABTkVMDyozcStdAvJZ7H6APijQA8V2cNSH4KuPVSb7p1gmFbBVH1CDQm96qDXdeHOW0vUUvjxqnRg==@vger.kernel.org
X-Gm-Message-State: AFuF++lwCVpeJhFRT6kYEeA2INKdmxNSptFjBM+K/lL6TO99OACqzbq2
	VrM7uSbDvvInTXCN59MmZN6tQ93bqqUQ9BOB1SM1zPJvK3x5QZkER58XVM/d58aQTR4=
X-Gm-Gg: AYBFou3VRAw1K9H9qeDXoW99fBVrAEGgwQ+G1cYOYPzADBPk+bGNaJ15sSHHjk7VluG
	JKSYJ5bzRQYYAbWlWNTFieYSnEM3UDkhP1zJHWTbv9NUv1WxhWFIgdZNkyjTYTbafLEa15+lExv
	w3fRhQbKpltp1GR1mFeRn4mg90rjiuwfVG4Pwv4X6jUNOpZfkuP6lzxe0cIoogxnTXQYJfMuEO6
	2nG7YJc+8Lv1k1/AZyZleq6CdHVNnTYvhNi+dcUWkwEups07jIZ31Kk/gIspLxJL4lt7dr2LAV6
	qkkrvvBSG3+yoNfe63G9etHtKNF4Vc9Ca4XB0qErwbAVzwUryJADv/fkW5pgy+flt6KZLAuPc2O
	KTpGnVo9e1QGWr29UCR3E88PWcigaW7aPwxJEogMgpA/yoABbBDiOitu94oQCGZMjVGcA1c7IJb
	t3oJM+g6Dc3WQ9NkzGey8NC1txUUM7PAWjLoWk7lu5B5WhJ5yTRLRLIAIzhw==
X-Received: by 2002:a17:902:e74c:b0:2d8:d4cc:5bb2 with SMTP id d9443c01a7336-2d8d4cc5dacmr273920805ad.18.1788199879349;
        Mon, 31 Aug 2026 11:11:19 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d7594ffc94sm39417335ad.5.2026.08.31.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:18 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
 m-chawdhry@ti.com
In-Reply-To: <20260719133730.3551691-1-egbostina@gmail.com>
References: <20260719133730.3551691-1-egbostina@gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: input: Convert TI Keypad
 Controller to DT schema
Message-Id: <178819987834.2869653.4643547927480344616.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:18 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Sun, 19 Jul 2026 13:37:28 +0000, Eduard Bostina wrote:
> The first patch converts the TI Keypad Controller binding to DT schema.
> The second patch updates the OMAP4 and OMAP5 device trees, which is
> needed because the schema requires the matrix properties.
> 
> Changes in v2:
> - Added 'interrupts', 'keypad,num-rows', 'keypad,num-columns' and
>   'linux,keymap' to the required list.
> - Dropped the '|' from the description.
> - Added the DTS patch, so the OMAP4 and OMAP5 boards still pass
>   dtbs_check with the required properties in place.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: input: Convert TI Keypad Controller to DT schema
      commit: 6980da9a69f59b3d061c317ed12d11fe4aa90386
[2/2] ARM: dts: ti: omap: Disable keypad and enable it on the boards that use it
      commit: 8d36324171f982c8e1d7f2df428faa5b05e7b1d4

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

