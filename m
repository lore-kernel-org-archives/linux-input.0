Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414133B6C1C
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679976; cv=none; b=f8PEZpret70gRtm38QKTqIFKL+rArvxnNXhQ408C+19zYRJi0Fop5ahUXOM2qrzRd6c2xbnv9uNjQKujNu8WBiRR0FfAQWhB1MEiNrlTOZEn4lDb35Z3AhWRg0NpMcb7H1kq1vpCw1UJVKaesEJa3gxx7ExZ7PxbWoOJSTy/Rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679976; c=relaxed/simple;
	bh=ywM5fxAP7YLHk3plDUVugejdL0ti6Z+u86nyhpgQsGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOBAandAwq5ZLJLLR6bX+dQbVL985WwKHPjP7r6ZbbP+5NrtMBOELr5qXm5/zX2SWiig8G+NWRBhA6mUrraglgptW4GIaHgd/01uWUPYzMIveBz62OnkiDVW16ssadUwqxvNy7aqtpENzPa0HPa2+mFxF7CtdvMT9YgADbSFeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmXVYytQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmXVYytQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec354815b9so507043966b.3
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679974; x=1782284774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh2zmRfLqBJkX6ljmJ2Zzgk6D+llpzzKDQIImg15hLw=;
        b=lmXVYytQtldzCj5PPlvIQBDcms60DS0kfG+qPdeM56zEyEMVfnx9OT1ZHcS0tNM+zk
         gc6XZZWy2bPgTSXqRdvQ2Y0d0q9sxHATyw97v7HNZsaXqvUhZhpMscnCkovj1mlkWvSl
         tD6078nmE5yOwAXHrgDfJ1nZ0yStXNIC/ZxbAIPfP0uFRehJAiS9gMsXRAoQaBzfDqg1
         +Kv+kzMZyrGRdwJq7pOBkCU7iALhcYawTNP3jppuBmRnzD10dhv2biXuc0CCsD1HcZLD
         5jaaRuBIB+Engdbrac8x9l2lMWP+17veO8pvoUVy8aQjsccHFZEZ11ezYd/BK47JmzL9
         EMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679974; x=1782284774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh2zmRfLqBJkX6ljmJ2Zzgk6D+llpzzKDQIImg15hLw=;
        b=HFBeJTuCy2BvvR55ED5+H6vm/YyeFpyNc97C+OxR/gAxEFFjsY7A09XcglHo3pjm6W
         OtwnZya8u1TKil/nyh+UbUix7LZBaFji43Pn4saCfw7Zd/G/YNqA+olM3tvtPI2Z95Pq
         LXfWcnivXHdQkxy0j0LSYAeZUpMgkCALhViUnyHEfY6zC80ggkryyaY3n8i6tFJBbSuX
         WpxfkMpX96O2U9aydB8+GMzlYu9t6oFIw7gDWI89yzs3oUflO3v5DkqkIMB7we69QqIw
         B0K01dpVtxYiNtjKQYF3dlsKlthnHVe3qH9ybhLqcsDscnfMy3p9XaGkQt5m0YfGa+hO
         7Uqg==
X-Gm-Message-State: AOJu0YxeACh82O/c/0nyxGaRHf5ecXFRkabQcrBJhiJIgjaRUpunQBnM
	VWbG+ORRWwnvbDQlMsEGFjDPo7fsTZEkiMT3U0uJmjnKgd8qo6DdWvNf
X-Gm-Gg: Acq92OGsjSJeQC4XhHoxlOfbOIpLg7vnMnac7KSRUL0IWL+/6Hu3rKvpaBIQSfWN0x4
	EZVdHHNuPsuHFxPTaBkZN4Atry/ECxmyMoOkVRohcX/qYvYk+0dQnsh6Pu8DxbSS3o2laNtTBCd
	ckXNNLDMRVRwjtTutXvCd+Qvyl6liOx/U36TED+9KHusNOEZxV/TY8fwsvKpxJlJwsCTUs/qpuQ
	LpyIabXHqbsKg7ZJa11E1rUiBsQLSNf+Cg6B5KhsMthNKTkbc3Mm+XRJuM+iGUa+EA3EpE3DaOz
	WQiMv/fEWgg+x82eTstlnJhIXmMYEUhc9VG0gB1NQFJhEHdk8RpGdH74bdFJDeSOp+v/Wj27UKk
	kqiDCzzmekL3McwCHjjv9e+wLUAdW91SpOs6E7Rj21pXovRKsGowzjWs5v7LMp6GWUEWnVOeebM
	4ANQ==
X-Received: by 2002:a17:907:7606:b0:bf0:701e:b148 with SMTP id a640c23a62f3a-c05d2a7f421mr83438566b.27.1781679973266;
        Wed, 17 Jun 2026 00:06:13 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6e6c9sm752857266b.39.2026.06.17.00.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:06:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] input: misc: add support for Imagis ISA1200 haptic motor driver
Date: Wed, 17 Jun 2026 10:05:25 +0300
Message-ID: <20260617070528.35006-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISA1200 is a haptic feedback unit from Imagis Technology using two
motors for haptic feedback in mobile phones. Used in many mobile devices
c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.

The exact datasheet for the ISA1200 is not available; all data was modeled
based on available downstream kernel sources for various devices and
fragments of information scattered across the internet.

---
Changes in v6:
- added minItems for gpios
- included changes by Dmitry Torokhov

Changes in v5:
- added supplies to private structure
- clk_on dropped
- ret > err
- added active flag to track status
- all hardware manipulations consolidated in start/stop
- dropped mutex from work
- dropped active check from isa1200_vibrator_close it was
  moved to stop directly
- dropped hw maniplations from probe
- bustype set to BUS_I2C
- adjusted error strings
- fixed cancel_work_sync in isa1200_suspend

Changes in v4:
- added INPUT_FF_MEMLESS option selection
- fixed missing clock status set
- guard start/stop calls in isa1200_play_work with lock
- clamp ldo voltages to allowed range
- fixed imagis,pll-div parsing
- dropped Tested-by from schema adding commit

Changes in v3:
- added clock state tracking
- dropped level check in vibrator close
- added clkdiv clamping
- added comments regarding registers 5 and 6

Changes in v2:
- imagis,clk-div switched to accept actual divider value
- dropped DT header
- adjusted imagis,period-ns range
- initiated hctrl0 and hctrl1 values in isa1200_start
- fixed situation when PWM might return -EPROBE_DEFER to be
  treated properly
- added chech a clock or PWM is available
- fixed regulator voltages check being off by 10
- added chech if state.period is not zero
- added action call to disable clock and gpios on error
- used managed version of work init
- added work cancel on suspend
- PW calls are done under mutex lock
---

Linus Walleij (1):
  Input: isa1200 - new driver for Imagis ISA1200

Svyatoslav Ryhel (1):
  dt-bindings: input: Document Imagis ISA1200 haptic motor driver

 .../bindings/input/imagis,isa1200.yaml        | 141 +++++
 drivers/input/misc/Kconfig                    |  12 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/isa1200.c                  | 536 ++++++++++++++++++
 4 files changed, 690 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 drivers/input/misc/isa1200.c

-- 
2.53.0

