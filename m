Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615C37C92B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795982; cv=none; b=HRttnxZTZ5clzbVCaQIInBx8l9pgBJg+InqEW3y0WVK4T0hGrhric/DK7F9ZFmFJK3kIA4dehLfaHcbl+Y32/TLXcYyd4DGFMsthSr9eSTPGxYzg/aluZaAmtcJrso5B+cDhw2xGsfNzuyX1uE2t8D/3hQi787pO0iujOv5xhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795982; c=relaxed/simple;
	bh=IhHBDjBNblh3SGioE59ahxJ5i5rETskes7udyfMIjwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQFkIkNcGjiuIBArFqhGQILceaTvIMu+laPs0ClcfE4IgaPytadPJe6a+dG6k/N2nA1b501mofrNTS93K1plPVWbhdKmghZcphaVHQbctwRV3ByzOORfPmcu0pZkTX7HR86pNQ6x0XudBiEFUKNBgMPP4IgK7bMdzH6XJ5JYcDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlxhHXd/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlxhHXd/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-827270d50d4so9445058b3a.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772795980; x=1773400780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0jykUN0/tKr1Iorg3HvmMPc1TMCQY6y1V9ModxJUJY=;
        b=jlxhHXd/NGrSQ1nvRmh1oSOT7gotHVvdSYCloX//S0jbrAsnoz873qynDx3PzwI8rZ
         aDtTzT1TZ+7Npl7NeA7K80LDZdafOFQ4r00oBtsrT/55VYcTE72ct267O2E/kK0e+tFd
         MydLm/G2CLy4oEsMptYhCC+Qwm+cvfvk2zdg/TaI4/0assv8dPPyu0WSdnTJvO/148vM
         Bi0dobeBMJ6ElqtQDhc6/XgRt6B1gJtl+hZ4gFUnPbUFcz4yEO0ZEQzq2BbkhEtxDSK4
         zsxWZgMN18H2Tbk8mDDeBaFLlPT/BZoIc9ZL46OqZcDS2Jqv9zQ0aLf5Uwf5dlIRy8P4
         zkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772795980; x=1773400780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0jykUN0/tKr1Iorg3HvmMPc1TMCQY6y1V9ModxJUJY=;
        b=l8+cmn/4t1h+k/OXBtPZiJtAwIUZAmOo/qmBkS5Sy8X5e3evYbQdlf1iDlnV9CppNg
         zZSvrvo66l+XrqOEsZ3Z7jo7pagd/v+bWvNXyqwY9/K2BApUPj9bZ9vc0QskOPyU9KwN
         VMZ2lBgmlbwwt5vI7CRVAyD/C+d2LL2cVbX4zObLjZttcMIAweDyVtsW3U+GmRvmAqZc
         +m0gf67wXlJVWqAaOzsczuKQVffoN+kc/xMbqcF56GS/SHbu7COY71kvXvZXZRxqq7KK
         KKiRAE9v9KOcB/1eHl+NoEYB3f7GFGMFikiRVj2X+pOu5pM4AXbNzpMymSdDasy7mH4H
         LVPA==
X-Forwarded-Encrypted: i=1; AJvYcCUSIZieXD1mzdECTRbxAWWqby7m/ok84vZv6ZQrjyEoFAnLF4xHMSE44VmdzgyxORfEtm/YhkRKQNv1QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwskcZAmVKv3mitOLkdE96EVAk6+EeLerD6avDo5Zhilpt9ap6w
	xFuI377dQ0tNM4XlLkZoTJo77ryeAn0hRudp4OKBVkLM3Eof6ax54g3S
X-Gm-Gg: ATEYQzy/O8OrtbnntDTWz9NqDS/AG2r8GHyJjKKy/PXd52J2RW309VlKXzFJsUPKzBi
	txeY6lA/JklJRfDeCOgy7Nyt8RwMnKeDJYDJ+A7w9O9R7Q5WOfgE2Q2LMIs3g4Umz4it1tQRWvt
	3mML8u0BN0B7QLbtjgb+7n3Ssvx5U3vChTLIKs4cW9AQKoNpp6fr50GpQKoZ1+TpG4OoV9KI7zd
	G2eYucNItH+Z1UxtBZMLlOfuxsK9wRrAkCVttGUGz9pc3wuwWOmDe62tTUV7KY/Vk6NWZDmGpPB
	I/MS7vUdOeESXDEuaU+ME8PrOIdPIaABjpSg4yThdvNRVgnQ3Cg5uW1OyURXhwVPPBJVqowLjLl
	/6RN1uQRJMfb43PtquOuM6LvFO/UvPCWpfFODFNWYdjJJhjG+/skGKumvSJNw6gx4IrZ+dwpmaF
	u7Q9g5YKKTbml1QNYrx5ttIKKxp+vBM1GdvWBfYxQpnqAauTo4bwa4owwS6g==
X-Received: by 2002:a05:6a00:1c84:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-829a30c2008mr1778823b3a.52.1772795980067;
        Fri, 06 Mar 2026 03:19:40 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636cfbsm1475973b3a.13.2026.03.06.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:19:39 -0800 (PST)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Bastian Hecht <hechtb@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3 0/3] Input: st1232 - add system wakeup support
Date: Fri,  6 Mar 2026 18:19:09 +0700
Message-ID: <20260306111912.58388-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306104025.43970-1-phucduc.bui@gmail.com>
References: <20260306104025.43970-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This patch series adds system wakeup support for the ST1232 touchscreen
controller.

During development it was observed that the device did not expose the
"power/wakeup" sysfs attribute, preventing it from being configured as
a wakeup source for system suspend.

To address this, the Devicetree node for the touchscreen is updated to
include the "wakeup-source" property, and the st1232 driver is extended
to initialize the device wakeup capability and report wakeup events
to the PM core.

Testing

The changes were tested on the
Armadillo800EVA board based on the Renesas R8A7740 SoC.

The system successfully resumes from suspend when the LCD panel is
touched.

Due to the interrupt hierarchy on this platform, the parent interrupt
controller (GIC, IRQ 24) is recorded as the primary source that wakes
the SoC, followed by the device interrupt (IRQ 35).

Example kernel log during wakeup:

PM: suspend-to-idle
PM: Triggering wakeup from IRQ 24
PM: Triggering wakeup from IRQ 35

Verified functionality

* The "power/wakeup" sysfs attribute is present for the device.
* The system resumes correctly from 'mem' and 'freeze' states when the
  touchscreen is touched.

Changes in v3:
* Patch 3: Removed debug dev_info() log messages for a cleaner
  production-ready implementation.
* No changes to Patch 1 and Patch 2.

Changes in v2
* Drop description for wakeup-source property as suggested by
  Krzysztof Kozlowski.
* Updated commit messages for clarity.
* Added driver-side wakeup handling in st1232.c.

Patch series

1. dt-bindings: input: touchscreen: st1232: document wakeup-source
2. arm: dts: r8a7740: armadillo800eva: add wakeup-source to st1232
3. Input: st1232: add wakeup support

This series depends on the following patch which has been
submitted but not yet merged:

drm: shmobile: Fix blank screen after resume when LCDC is stopped
Link: https://lore.kernel.org/all/20260226054035.30330-1-phucduc.bui@gmail.com/

Feedback and review are welcome.


bui duc phuc (3):
  dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
  arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to
    st1232
  input: touchscreen: st1232: add system wakeup support

 .../input/touchscreen/sitronix,st1232.yaml    |  4 ++++
 .../dts/renesas/r8a7740-armadillo800eva.dts   |  1 +
 drivers/input/touchscreen/st1232.c            | 22 ++++++++++++++-----
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.43.0

