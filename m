Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53334D4E4
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793661; cv=none; b=Nb00B0K5IDmaSQg5DxVvbRZpdcYR+sshCfSlATuE08n8+2Gut8H3eRIIDqSG+TOZ+ml3ixvN/aSPGlLRhZk8y+LoaSWv0EFKBp+qRAri2MOhvdpwN6PDzINA0Stf8aFKoAeOBuryj9cbktHq+8drqFmwWHJLc7ybcAuuT6ArC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793661; c=relaxed/simple;
	bh=XZoJJh9iagM+FGAwGy5HzzWjLybmYsra7ggsR9sck18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1JFWFzBK2sq0Ayf1nhKTqM9j3efGaIwyQqoS2c5DfyTbe8cMmtkoothFVJkuikkv6LWSEjCjyE6meWgq+ocw/PHIpTXmVD/+Db4fS/6ddrmteXR1Rhi3NcgmqwlV3A/PjhadgtAhLi56KouiLtFcpp/gpeDLi4ERPXxTcYEv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5ahXN2T; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ahXN2T"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae56f8776dso37078385ad.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772793659; x=1773398459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL1VKM3s/estp6r05irAg1wzzhKUK1/TduaCAbOsvp0=;
        b=E5ahXN2To37I0X54iHOte1JgW3z6eBCkEYMmRUiLkcUqf0DhVz6S3O/MJGTaMY0r+s
         r/RwGMjBsLnHS6h3qT+jPiMszVNGFMca16ND5ijbIX0Kse/UVu4MO7m1z6wrHr5H0QDB
         zWiBDVZgQeNiLY4bpc63CH1ZuUQ8PChOTF1zGCHe/GdQPAK9DOPi1sNkousC4qqfpwT0
         yrdGdGA+j5OS+JARIigr0imVQUpojuraCV55C5T7UFsBB7Cj//MeVYpvmeeHNo8xqI9w
         P//4Of66TypAUxGMKMJq/6T2+9naxhcHeDTI5SkEj8a4V2JDs5q2mXtHH/Xry2etffq0
         jw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793659; x=1773398459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uL1VKM3s/estp6r05irAg1wzzhKUK1/TduaCAbOsvp0=;
        b=vPTCAPAmWTnjgZe7hLPD/1nxBFyLypHFZ5cAplel5qBuFiKb1sDwtjAu2iATDSLzK4
         93/G3gqSpKJAImazezeKRKD5KXZsyYtAfS1uki1iASwvqXQdYuicSIVIMddvjzvo6OQ4
         ARsGZP9r/L+LbCl5fGTqltAGndpE9Z/S29M2qzvPbajvz5xf/fPcg6o343uOlWFXwYqc
         7QL4eFfm045dHx+L8usXkHDISoDqR6zS/2Xl/a8PkWgCmLmq7hoUNGX6mrNL5Hv1FCCU
         bPSlbUifjAjbzAlsAtjrMMpMTL/S7v6rBvn9b73eEG1DtiRgEfqhMddpRfLsT6ysHJ0C
         FNYA==
X-Forwarded-Encrypted: i=1; AJvYcCWVDNwE3YQLNMZWyxUJL26F5529yOYmBlhg+FpsaCiFsqRnyIJeQ6OBMYP+/RsZTd6zd9qvhHTq8aHbSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBsZDuOrfm48kSHtIBT/Vf8n8rGYXEtB7tTXGXufZAUVTbSUx
	MJuX8nlIyi+pxWnxnWgmroN+1zrrAmSpIGyD8QMHubAHbxSJicd0qL/G
X-Gm-Gg: ATEYQzxA06xuhGWr+SudXJt/6Bn825QzdXzrAE+fKv/KuDIQpFW3zD8KgyVp7sqE9Zb
	CyYKNXpi6R7MVtsCvhNpTi012vLbSeed3PwbDkhfNvjDTbhdskEnoNtF8VxBe8TyuRk8eaziyHq
	rl8JyXAsjQ2ok26kWB1I10dKBR0UTiT8gB0GFWpX85lmE7H2DgSyx/yZC/jjIlOxR/mi6zvAdCz
	S6QoRaRlX7AnLozh+soD18aI4EsztvHZryFkkuYH5858WiGg4b1DReiiNSMstaYm+Vf+7ZL1jlK
	ZM7RAc497pGuJ10cI/MB6g9YuvIghBCfkluS3IcUBpQJLeqAGJBbGQsIDfaXmXyw8cFqWDLvuMH
	2W0TYAxb2zD8tj/ZvoorqNZQhZJNO+bb9ltDgFlA6Y9fU2C55dun0gG9SeUVV7kaMkxyPWcmx1q
	6nMlTOctRPNUoYntrEMbqfH1SerLuVOKxbvvTt7zowDyRo+QqZ/DqdbaXYSw==
X-Received: by 2002:a17:903:2f8a:b0:2ae:57cc:63d7 with SMTP id d9443c01a7336-2ae823ff86amr20528435ad.7.1772793659243;
        Fri, 06 Mar 2026 02:40:59 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa2fa5sm16107775ad.70.2026.03.06.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:40:58 -0800 (PST)
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
Subject: [PATCH v2 0/3] Input: st1232 - add system wakeup support
Date: Fri,  6 Mar 2026 17:40:22 +0700
Message-ID: <20260306104025.43970-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113512.227269-1-phucduc.bui@gmail.com>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
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

## Testing

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

## Verified functionality

* The "power/wakeup" sysfs attribute is present for the device.
* The system resumes correctly from 'mem' and 'freeze' states when the
  touchscreen is touched.

## Changes in v2
* Drop description for wakeup-source property as suggested by
  Krzysztof Kozlowski.
* Updated commit messages for clarity.
* Added driver-side wakeup handling in st1232.c.

## Patch series

1. dt-bindings: input: touchscreen: st1232: document wakeup-source
2. arm: dts: r8a7740: armadillo800eva: add wakeup-source to st1232
3. Input: st1232: add wakeup support

Feedback and review are welcome.

bui duc phuc (3):
  dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
  arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to
    st1232
  input: touchscreen: st1232: add system wakeup support

 .../input/touchscreen/sitronix,st1232.yaml    |  4 +++
 .../dts/renesas/r8a7740-armadillo800eva.dts   |  1 +
 drivers/input/touchscreen/st1232.c            | 27 +++++++++++++++----
 3 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.43.0

