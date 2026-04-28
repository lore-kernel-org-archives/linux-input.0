Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AD3AF674
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376605; cv=none; b=Y4mZNmbNSHCOlQjIzrbdOceODlECjvvD3Pub7c+Q/xHE9aMK4l/oBUgEjvzFgztsGrF7zETl6JTu56XbUftPhRuLDdhrBANlqi85IwewkYu0vT/erjV6MXXu8xYbuaTY9OICOkbDBpi63yqbMhcdbW5N0NHU/9SMp6HqP3tBh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376605; c=relaxed/simple;
	bh=QNJLWDEII8SiucyVK45MApojL+ztZD1a21kqxia/FB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfW7qqsc80ay/UHpW1cK2bh8wkrDlEzPo21BcjcNl6mHNC4kWy4E9j1Ry+XsytgLuuS7/TRohdgVRRYMUbRhXt5CiALjMvKXeHSKn2lYIIRv7rZqQ04JVPUREv4xuCmjQtIIHGirpCB64WNSuSA6hrP7fzfZbJD2XMP8EnCgUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rach+uG5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rach+uG5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7e23defbso6619559f8f.0
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376603; x=1777981403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M42tzBm5+OpAo/m9VxQz0z1ChxGPGEHmsrbw6NShkY=;
        b=rach+uG5EZzFcO3LweKE66qUQIttqJ3rVPS+PWhvkZaE2Tl2b5kAe+wHt7vlXlcleS
         BuwM0orivclAnCxjHw/Mz+MGrNP/3E671/cciI78nqrSsmZwGkVN5lm8h8Y1pjxo5Q0t
         hgjc8h7qpmbsi6jBG98lzB9xOj5UGctAHvhxm3c21MO+PInvsG+4u64l4SwP8BzcO4W5
         Qbrzez+bJiArJS4wvXtVn7BRGRT3qwmMIvlbXxc3pIeK8B0OTUK8uDE86mTqwKpgO08o
         5O/VEo1b/iiT0dMQ/otF34INBKj0yNIv08YeMsYi2eBjzY3LWjmoB35G8yhQ/TJTqf7u
         hf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376603; x=1777981403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M42tzBm5+OpAo/m9VxQz0z1ChxGPGEHmsrbw6NShkY=;
        b=ej0b/58fIcCZbymT7SdYsjfqluxj+/E3dQmvq6x9fRmBIQKR/n/cpft0QqzeVbZcs+
         PI9oa43VNBgswdeeq8vvI7t+yvHOF4ECwYREQ1YGm4Hz9S+HHeZjZRmf1uitVBY08tYX
         fv4NjdnfHBXN6CaZR+hIglJKeRbhP2rumLs9v0BMC4JOEG+NebzjeTaA9wNvPq62+jKv
         PxV89PAuwXgJ89+zoj7nVxUBPSa+B25Yl+TJV1C4jh8slnkK7/NqJ71cAMW8F4iuyqes
         DMUGP4WUZ31aRXLYA2+USO8qC7/f7d6WgbSR0OPE+ytxbRQ6gOVVDtNQCtr093jSBmEW
         HSfw==
X-Gm-Message-State: AOJu0Yyfo94W1c0da9/YFKdMK/R3fL8sOlA647oamUK/znDYhTHC/z9x
	xblkS7SPRwU0IqnUviE9z8nTkFZPxZwSADY3+MUWejn/CZi3dT9UWWEE
X-Gm-Gg: AeBDies/Y54XWUIeY4G6bZE/iCxy9PMS5UhkV6G8h1CzeGSrw1L8byW9bpQtOuqErX1
	pol3/rLF6dMxqsvisbioZnuSjiO3gUFg0moFUQJnZyXXFSqQRkjCdalQBxBvtxv1zLQHCs3bjPT
	rx2k7J29phC77a24+iwxVOuFUY8XXRmIwj2uMERPUu1DtV4ksLwlBFpr3YNDw9vC7ywPDjIgqv+
	8nkAz03iECtE6oQo7S+5t32bB1CiPnQK/PZsY+mgqRagDPm+ZnE1yw5k8y2AQhdsChmTAzuFRD2
	C6SYXg2RgVHDcEFyHzfUv/eDMfOB7atjTtaxTrGb7FwaSNzDxINhQVx6+l55JClNz+NQYJV5IaT
	Owmuu8uT61Jxr9CRTeHYTWnG3mdRjE9/DLPB4M5n9piTeRUvxoSjQlHthf5d5wZ7MO6tkYkxyg5
	YQ0HWlIrOlj1TykIOXk3kfV8Y=
X-Received: by 2002:a05:6000:250c:b0:43d:7946:badd with SMTP id ffacd0b85a97d-4464a913497mr4983599f8f.35.1777376602052;
        Tue, 28 Apr 2026 04:43:22 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463ff5a1acsm5589842f8f.33.2026.04.28.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:43:21 -0700 (PDT)
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
Subject: [PATCH v2 0/2] input: misc: add support for Imagis ISA1200 haptic motor driver
Date: Tue, 28 Apr 2026 14:43:06 +0300
Message-ID: <20260428114308.113253-1-clamor95@gmail.com>
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
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/isa1200.c                  | 507 ++++++++++++++++++
 4 files changed, 659 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 drivers/input/misc/isa1200.c

-- 
2.51.0

