Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268409;
	b=foP96UHWgQFy0SZU8QBhKlJfLiJuY4Df6pVxkislM7jBVP9L2s6qy+ElhOmjIqj9lVal
	 GZ4KyuSqw48Yw/JGL97iM3SO+ICoTuRIt69EpDe3idK2/VenK29i7u6ROg4t9A+U8FyzO
	 YN0Gy2lu4JvyQvw65j/b3moXGC0UVNMrwe4PTtkMLhF8uLYtPpaAZ24VbHpeh6TKhf+MK
	 A2vlx0V72RYpOG7FJqi1zmIdDCjU5qdFmPZuWVfM377i+TvnQXpjG9HurosKxXlO2MAmP
	 SXrLJcHvgg6YcNYWisPN/VfJMm3w1BiUC09bhH9/4MsAA2ZakWjg/ujGKj68R3GnDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qOF7wYrSiLyxDI9TfUlCsobhSuSMPq8w6f3swfnWMZk=;
	b=EyB6eviDALlmRO76r3VCLJgrf1NT3vrLCWx292fkXUD3EkooXwkVrFB89uDh0A+SQrzB
	 KBTisS26tvQ2qfwyDx4pO7sJHwhnO9MBGXiyatNLGhn2W+v2dI0PwydHWbsn44TISbyGT
	 Y3e7A+swQcMr59g5zZEcebiA4nwH1GnZmR8asyw8Xuu6fhR6EOBAdDzHN7LjXzO7lejM4
	 +Mwp+HhTLPcsjrKg16u1Yd8Sf01Yz4j1S2+qcgK+HG7ZKOJzi8UEQ5am865FfT4AEQF8F
	 QJGeoXkcloNqhxs1jUjmLAEwlXmJiCIvIhrQ7SZY888I5bR96PyP/uW6imOmLypj/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pszdm4fP;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40020606A321
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 10:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40020606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pszdm4fP
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so17153645e9.2
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268408; x=1793873208; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qOF7wYrSiLyxDI9TfUlCsobhSuSMPq8w6f3swfnWMZk=;
        b=Pszdm4fPwGA6z3/h856xxp3nG0CoeMLpKCnNm93Kve5JOa0nPOeF74RJv2oYNtcNZR
         ozCESFFGve7AzGRPZXZEEQOxAwZBxiDlwTZCe/iFU9yMsVG5eQexLV+2KElgyEoheCZr
         y8BTz61Yv8RzXisIss7+bk/o3LkX7T5WlIIDxt9l86L0f+iz3YN0I+m7c94q6EaXd1+6
         k1aZlxk4jv0oW6dgJIvT+nljT4xqCnPWvPs+3DvuAQLKYJc3j7q2mtlVi4yYW0KtgSUs
         ysZMk5hbO2SlhHBgjNdGJ7j/5IciDZQthP6Dm/Lzt+L065agamsUS6wtRefn/NXfrQp1
         ECqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268408; x=1793873208;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qOF7wYrSiLyxDI9TfUlCsobhSuSMPq8w6f3swfnWMZk=;
        b=ylbXzg9F+nOSAob896uufMTwDIZX1j88LmKeVf3aEnOhSdDyTlzYhECanw1c8HMBzv
         QxvIxlJZBxRCqaAbCuiizzT7wmOuGLRNVzUzf6PFfyQtfvB44Pom7m/VygSfZRBiNCdV
         +km/rTtdLsAez6zLnaCulHCn7694NqP4hcTQM/Wk/0+Vym6sqBsvR4LscSbuxqXlcRJ/
         yzAjFlw6M44ocn/3MlIu7QGu96bjQJlTg4SAxsLLUtETnqSL0rUZBCQIbZX4VF+Xd+YT
         G2PJURxW9WdMn/eo+LW05sRlgTWAM1/OjU5/f7oOC5LyC0unIE8FGjd3IBllBg24iJjW
         bP1g==
X-Forwarded-Encrypted: i=1; AKwUvBwsAlDH1IRBEhiSNCKpPTMNIgxu3FF64XoD+uclVUP6gJtEHQh7p95+XDlZYhq55C7EpSiZUasNtnKsBg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdUrJkb6gBtKUA3RKd2HBK7rhsJsJ9SSMMqNcJzGi5cx4gXFOZ
	dY4aQQ8Wb7WBY22EyKJjPOmRnecmWyZdk4NKEBBkplwhj9hwF0R/jsvg
X-Gm-Gg: AYBFou20uN7HuWMU78oW3efIj72I36A2tC2KSNXf/c2D63TkbAprow4kbG4T7ytWkgv
	UjxjPt2MXPrY7YXMX0V8I5jn4uOFYxLVOJvylHDtSHvYrNTWfTytu37Aa9iONPLqzU70WdV6L0p
	B2hvHFE2zi/Dg8eAl1gHcgtC9R0hYIfaR1BxHPQ2h+ldvtAp5T7+LtyGlANCK+aJcRZyp7/DsGS
	YEN8973EH9caLshysGJXbQXlwPOZAMmbpg9tkmN1Fd7NcjptVAE8i9XpBuCAfojKqgAuMl77AbU
	Vo1WIMOYr6kccvz/y/Hz1pp29wSQ8EGs/m14JbsbRipEqKbZysS6ZXo5tqYLzq5bkJQBtzmYbDK
	3bP7OPwsIWxZCZ4j9zymHJZsH431ZOiMjyrZEgFZ0w1UPjKrOXAKf3Nnfi4DzLZaNF2g6ugySg3
	LJS2JzAyGJoLuNgilKiBsm4QCQ33s0ZTr+jUexc+DF9rdFcSVUI8xqG/Bg4PlANf6x1g92/4L8f
	P8AMaPNyNHNf/xEiaw6ECor+9Z2sHhZu2Z+FRhVo0IvmudRh56xmuBiPEWdH9Uyn/2pbyRdgxDW
	JXtEb7zjLGDG3BxUCH+MNxjJ38/zTPxK+L2cbRQOVsIxOWXUmylwlMfMCSwUZ11PjS9rbhA65mx
	1iZPhOYqV
X-Received: by 2002:a05:600c:354f:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4a965ec95f6mr117257515e9.10.1793268407430;
        Thu, 29 Oct 2026 03:06:47 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm53082825e9.11.2026.10.29.03.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:06:46 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Subject: [PATCH 0/4] Suspend-to-RAM fixes for RK3588 + SPI-connected RK806
 PMIC, enable PMIC sleep on RK3588 Tiger
Date: Thu, 29 Oct 2026 11:06:22 +0100
Message-Id: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
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
X-B4-Tracking: v=1; b=H4sIAKAa42oC/z2NQQrCMBREr1L+2oEk1lq8iriwyVj/JpZ8DULp3
 Q0KLt/MY2YVY1GanLpVCquaPnIDv+sk3q95JjQ1luDC4F0YkVjx1JkF9YgeSyH+3S+3ly3MCVM
 Pv58GRjemEA/SJpt90/f37nzZtg9J1T2zfgAAAA==
X-Change-ID: 20261028-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-13b6ec08d2c5
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793268406; l=4078;
 i=jakob.unterwurzacher@cherry.de; s=20261029; h=from:subject:message-id;
 bh=whpYEratljGVTl7QjkhsaCvIr2bv7FesbGf4wTNyJws=;
 b=Yjo1Vrkco613l9dyLnzMqeGxox5caUTel5ElHqC2L6eZEKaikGN7q43RGAGZwNloLUj1zWdDJ
 d8fDrN+nWEGBzxgvmtwK4wP6dL1VSzL/h4dTP33hHfLhLImeky8gg6B
X-Developer-Key: i=jakob.unterwurzacher@cherry.de; a=ed25519;
 pk=0v1L7pjG4d7PcaYPMOmzP4SjaRtnB+8bMzZLZCRzB8I=

This series, together with a few out-of-tree patches (see below), makes
suspend-to-RAM on RK3588-Tiger work, down to a power consumption of
about 0.4 W. Patches 1-3 apply to all boards with an RK806 PMIC
connected via SPI, which includes most RK3588 boards.

Patch 1 ("Input: rk805-pwrkey - enable the wakeup interrupt during system suspend")
arms the power key interrupt as a wakeup source, so that the
power key can wake up the system. This is done in the regular suspend
phase, because the SPI bus to the PMIC can no longer be used in the
noirq phase.

Patch 2 ("mfd: rk8xx-core: keep the PMIC interrupt disabled during system suspend")
keeps the PMIC interrupt disabled across system suspend, so that its
handler does not run before the bus to the PMIC has resumed.

Patch 3 ("mfd: rk8xx-spi: add system sleep PM ops")
hooks up the existing rk8xx suspend/resume callbacks for the SPI
variant, which so far lacked them.

Patch 4 ("arm64: dts: rockchip: put the PMIC into sleep mode in suspend on RK3588 Tiger")
configures the RK806 PWRCTRL1 pin on RK3588 Tiger for its sleep
function, so that the regulator suspend states take effect. This lowers
the module's power consumption in suspend-to-RAM from 1.09 W to 0.43 W.

The patches do not depend on each other and can be applied through
their respective trees.

Testing
-------

Tested on RK3588-Tiger on the Haikou baseboard, on top of the v7.4 merge
window (a8530b69fc4dd): 30 consecutive suspend-to-RAM cycles, each woken
up by the PMIC power key, all resumed without errors in the kernel log.
USB devices (a SuperSpeed hub with an Ethernet adapter, and its
High-Speed part) stayed connected across suspend.

Out-of-tree patches
-------------------

To test this series, out-of-tree patches were needed and used:

1) Upstream TF-A does not complete suspend-to-RAM on this board yet, so the
tests used Rockchip's BL31 (rkbin v1.47), configured through a small
out-of-tree driver. The plan is to get suspend working in TF-A instead.

2) The inno-usb2 PHY has to be resumed when its 480 MHz clock is enabled,
otherwise EHCI/OHCI resume hangs. This is addressed by Sebastian
Reichel's inno-usb2 series [1].

3) The GPU and NPU domain supplies were kept always-on. genpd powers
these domains on in the noirq resume phase, when their regulators (on
I2C/SPI) cannot be reached yet. I'm not sure what to do here, yet.

[1] https://lore.kernel.org/linux-phy/20261001-phy-rockchip-inno-usb2-clock-fix-v2-4-e01bf509359e@collabora.com/

Known issues
------------

PCIe devices do not survive resume; this depends on system PM
support in pcie-dw-rockchip [2].

[2] https://lore.kernel.org/r/20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com

Tool use
--------

These patches were developed with an LLM-based coding assistant (Claude
Code). It ran the suspend/resume tests on the hardware, analysed the
kernel logs to find the causes of the failures, and drafted the code
changes and commit messages. I reviewed all changes and tested them as
described above.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
Jakob Unterwurzacher (4):
      Input: rk805-pwrkey - enable the wakeup interrupt during system suspend
      mfd: rk8xx-core: keep the PMIC interrupt disabled during system suspend
      mfd: rk8xx-spi: add system sleep PM ops
      arm64: dts: rockchip: put the PMIC into sleep mode in suspend on RK3588 Tiger

 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi |  6 ++--
 drivers/input/misc/rk805-pwrkey.c              | 42 +++++++++++++++++++++++++-
 drivers/mfd/rk8xx-core.c                       | 19 +++++++++++-
 drivers/mfd/rk8xx-spi.c                        |  3 ++
 include/linux/mfd/rk808.h                      |  1 +
 5 files changed, 66 insertions(+), 5 deletions(-)
---
base-commit: 8f6620b65ae2458c36cbc9569a26fc2d777593a3
change-id: 20261028-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-13b6ec08d2c5

Best regards,
--  
Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

