Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366D395AC7
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581498; cv=none; b=HyEzGVl22YH+LfvnwsPyMU13N+FTU7rpJfWQlT7O8rb/ifApyYBPkmK3ktwddHjYHcAB1ldS+JfWPrJoduFbMnKr3Uirv3eLlNOUBxuEjinnBJKnaQ2/gIgS6PQghO6pR+Vo9i0H8VjA772GDLif7j3FZ1wRnf/c/Lpu4Qj9ryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581498; c=relaxed/simple;
	bh=VkIQe9enrKprR/AxY6Dkc2FlX7laVOPhA0/xwB9AKbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUgRY7uh80Wyhw5VYaVaPv9jcxB/4Xi3JwpAV4w/JXd/BBkezXl17STNdjAANFQnYlpStLJUxwBogr7oriqhU3npj5ikxHOr+bb5J2LnrqR2fGuV6zW4Mv6E8E6P7D48pWdPRMSlurJWqm9drm3EGoSwBXg5Zm3uFbZpV71l4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Uyfgo1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Uyfgo1"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67e24b8ef55so7450214a12.1
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581495; x=1779186295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GIwyDALF/QcCK3UD/Zg1ohofSXNNGV0cy1CpSwLCB4=;
        b=A4Uyfgo1S2Z7Am5B+0YwdeaXxU4vSiS+LPC3Q6Ijd4Y/IaV/OZUucDsDPbN0nd5MqD
         iVrn8gJchGO6AWukYkJUg2M1HZHHt9eg1ecZ6kVwWlj/WsC0Avgv7UFlY2efTuhgMmQG
         1NIU4qHLmA2OycBCOMXTI6V7tL03iHj2oUykpQbAAH+/Mr1i05c1gckZk3FJTELJF6hS
         EjSNYjYeYOUV4gwwvs//DLcnQxSW2+yuvZEsgvhyOvK12aTWw3ntwiG97S1VoNn86A/F
         Y55/udzmoEo05J1SRw45hFdjGK/eZZlGkYGA9fyf/Gog0AdhGN7JJAExu2K5BfZrikZ6
         D3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581495; x=1779186295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GIwyDALF/QcCK3UD/Zg1ohofSXNNGV0cy1CpSwLCB4=;
        b=GMTzGmoTh++4OZ17Kr/3amg16RFtAUt73c15CSEJ1J2RyEBLNCNYhy74JcMnrAKydd
         u+hmIfRI9XJfNrnJmFhBW2lt0y7jQCShUGjtlUVAEFPXDE0YC9YDHGVZgm4aMGd7B69f
         j/Sb8p949PCDh84W12W42muUzgPLx835bz4/iV5Haa5XT//j2lM53HMTd40G3Mz2+DB/
         EXMe5EtIdHcOzbietqPVgLinNTfeyF1+FshkpqyulLpzjGg6tKl+sr4Hx3YXJPTGYme4
         AIHjLmpmCQy8XbgYy/opdeydhIPKLtsTSgaUiyo12Q9yxADAm/0OjgprdTLrB+spwfji
         EuwA==
X-Gm-Message-State: AOJu0YwQhBOABzhGUYL/HE5asUNx58HxPjkeNlN87rSEyLtccNZWvA0Z
	iDhQZUosH1afIePKpXdUkiemGnU44IN4c/8BpoCdoC7iEOEZytriSmuc
X-Gm-Gg: Acq92OFQKKMhuzQ7i957nQJAhyqi9emrUIcm27ctUcniEaup2i848EdhvkWiZJGd+Po
	dkJE95un+ULCJLH3EPfUgMXmlxqwWMdZnQLksxA/kSajbNOO1+Rj9cJG+bH+tO2+v8O2oaGCbp0
	yG2v8+QjDprJrHeTToh4iv3OAl6Ps4vy2yOnDHJ1sxStpRbvqDK25o7QTDy7FVt0iu3p9thNu0o
	288IGUm6TXPw/RNgpksncJlgtb3Zensm6HCneW0LgYiaVRbcAdF23t+uvyJiBALhx0a8116Rsby
	8TsSSV1dUsQKS/OaT44DnzEtyTgoEsQWOTei5eWJP2eqQLPVUscYCwVPddwIzluhQ7cBn4ocA1o
	7uZRYsC0HofjH1Qr5teAzua/cqs21Lp/yU8oTJgpf7XyAqW4gmkOdmG6Yv7ac0huRM4jypPdcam
	9o/15+IFw2W2+wQNn3R91Ur0M=
X-Received: by 2002:a05:6402:158d:b0:677:15b6:4d6b with SMTP id 4fb4d7f45d1cf-680d02f613cmr1288570a12.26.1778581494941;
        Tue, 12 May 2026 03:24:54 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b6a534sm5032792a12.9.2026.05.12.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:24:54 -0700 (PDT)
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
Subject: [PATCH v5 0/2] input: misc: add support for Imagis ISA1200 haptic motor driver
Date: Tue, 12 May 2026 13:24:43 +0300
Message-ID: <20260512102445.55372-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

 .../bindings/input/imagis,isa1200.yaml        | 140 +++++
 drivers/input/misc/Kconfig                    |  12 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/isa1200.c                  | 524 ++++++++++++++++++
 4 files changed, 677 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 drivers/input/misc/isa1200.c

-- 
2.51.0

