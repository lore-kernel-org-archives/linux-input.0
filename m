Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA94A0915
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547936; cv=none; b=KlCDgC6HWhjdAJfBCwpPaHFMV2kSrfRUqkhMFowWD8SqqFQixFhIcAfxH/OoXb0RKUf4Uc+j2ho1tztHrC4duyBE5ZANY1ci+wxEd9Lx9rcOtM3Jg1r2kNeU0W/VCm2v9laj8uJKym3J9oQ0vTeGpZNliV6mZX9X1b6FjDOh1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547936; c=relaxed/simple;
	bh=Cl4LBCNyYjfLcA8M9pFp0MGm50fZVlfvAIPstVNB9dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igPC+EdtH7k4yxumZymIBJX6xVxkfqAmYdeoDKjs1UJT8tFskb3wwhydFydmjGphBA0TjeWPFCogj1Pqfbwz5NS3eIqlXw3dzSaxm4IDLx6wMug1XmdKFk9skel+M7IXXvfiVBxNKV8oaf4ciOSo8oOY7F4fBIKwNs3DXhx2mC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImrFpvk/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImrFpvk/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-88c72646f03so3401873b3a.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547922; x=1792152722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XEWrIzKLR6ifRFKivyWaAxL1i189Pekuk8YqMPtRbiE=;
        b=ImrFpvk/OQZ7GdpERaG1WU9Sxw+6apwn1pKKbhqeZ2mz+QNnHl3YJrZvkfI5xteCrn
         VKvtDLgOJYlfe5UTB7uR3PPabK65y5DhLZ/RC8D8GWPZ2pejLGLTuESFTXtS1vIx7MZk
         x2oQ7onerRrL3sN2XUYnrTh0W+tad0cByq7UW9/RiLUhTc4YkkreEo7DT4yurdJJh1CX
         t2MUHZg1Vym+EvmU28+zgHw27GgXZr3NAnZPKaUewLoH/Dz8v+AJ6+HI6P1hx6CtcwIm
         zCUncBKlY5FnXkZAndhqKNkYYSZ8rUOqlNQaiTl+R4GBmpulTU93ciYPp8dL/bI6Yh6S
         T9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547922; x=1792152722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEWrIzKLR6ifRFKivyWaAxL1i189Pekuk8YqMPtRbiE=;
        b=ajzM8YXpnnAtp/aXtG/lHRS8N32vmqsAJOrXBKjyK0ySTfxjWBjy27R2mWuLuEVj+D
         xOAPZ10/zgJKfZF8pntfZS2dwQXjqn6JEVjXJsMpj1GUll5Sg8H3+p+koq3M+S7Owvmt
         X7CT0m/9s5XpWt9H25d1E4SfaiMCdUbrAf2AesJi7fZbwFFmum3ROkLOCbJjAuXP9xcz
         pLmdlreY4rfcb7B+m06pZvSfLWNjciEuxkKqCr8/TUDAOIxRl+PaMWAvRIIyDnBgx1GZ
         lzDaaU/ZgyFDtnj+PiCdTeDWZVU3rnPrffL3K6uplBidrWnI8dkQC2twjAW10vQH58lI
         sNmA==
X-Forwarded-Encrypted: i=1; AKwUvBwJW8IGR8/YIIiKik/sz08XkSVfxcB9UA2w0lbiaZOsMUv2QvZoCn/ePpm9PVntM1iB9b51b+f5jS2ggg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJSMcHLkl5XCypDUyjZMme5GHpehcckEWn8yspsNcV6npcWxaCY
	PwnLAV81a6r/FVF3goQRBhmIbjsbx9K9lixcvq4iMr/cgQmlQiZja5QXpxZjS/gR9OjxQJje
X-Gm-Gg: AYBFou3Vd9CeAse8HqpD9QCxVmoYQ+W2ECa1jxepCJ0HOKg6Ael57MjxALcBNUoJnsE
	FBQ8Xhqo+Pr/hYqpyrhebOL2qM/Bx2f8hRwM/aZHa0b4k8Wnf4m9rEnlULNugpFDZjCMj+32z0q
	qCOF1NANuvZWj1fJjwieptiazxqi2umIhzsoKpeOHuKl+9PEfpLCNKghSDfSZIUlU6DtPKibLpZ
	vfx5Hkn8YgqsXHRkHy87HJial43BfIAeZMZrEh3qE3cMh1Q6rgDl5lmtdsTkOrtIalHg+GKWURA
	WnUEasJdmPX9ELTBYTbonNbnKhEO/ERS1oa63vAY7N5Bjye1x2kmoI3czOm74djOziqhsBiyT+b
	GoPEfOkmhhmz9TpfvHjw+XyDD5O7lDjbfupqSVy92DclT7QuUIje57YeDZc5Wfm4vL0ZTtvhoNz
	CANUToQM/IynZP1pbGafjxz5lxy1MFY8lZJcWdKffPqpLE+PdUAgBg3HATOkM8WQlfoNIkozUk7
	k8=
X-Received: by 2002:a05:6a00:bb8d:b0:892:2279:1008 with SMTP id d2e1a72fcca58-897c40f1e1fmr1597858b3a.5.1791547922019;
        Fri, 09 Oct 2026 05:12:02 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3eca287sm786243b3a.37.2026.10.09.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:12:01 -0700 (PDT)
From: Yibo Wang <wyibo6109@gmail.com>
X-Google-Original-From: Yibo Wang <2024312277@stu.hit.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH 0/2] Input: add support for OnePlus/OPPO Pad pogo-pin keyboards
Date: Fri,  9 Oct 2026 07:11:41 -0500
Message-ID: <20261009121143.550498-1-2024312277@stu.hit.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

This series adds support for the magnetic pogo-pin smart keyboards of
the OnePlus Pad 3 Pro / Pad 4 and the OPPO Pad 5 Pro.  The keyboard is
built around a Tinno MCU attached to a tablet UART.  Both sides share a
single data wire, so the host gates its transmission onto the bus with a
PMIC GPIO for the duration of a frame, and every host frame is echoed
back on RX.

The MCU speaks a framed "one wire bus" protocol over the half-duplex
921600 8N1 UART: 8x 0x55 preamble, 0xF1, src/dst addresses, command,
length, payload, CRC16-IBM (poly 0x8005, init 0xC596), 0xFE and 4x 0xAA.
The protocol was reverse engineered from the vendor kernel driver; this
is a clean-room serdev reimplementation that replaces the downstream
platform driver, which depends on a private msm_geni_serial callback and
a user-space held tty fd.

Patch 1 adds the DT binding for the "oneplus,pogo-keyboard" device,
describing the supply, TX-gate and wake GPIOs and the touchpad geometry,
with a MAINTAINERS entry.

Patch 2 adds the driver: keyboard matrix, touchpad, function and URL
keys, caps-lock LED, attach detection through the wake GPIO plus a
100 ms heartbeat timeout, and the keyboard backlight as a
"pogo-keyboard::kbd_backlight" LED class device so UPower and the
desktop keyboard-backlight controls drive it through the standard
interface (the level is cached while detached and restored on
re-attach).  A sysfs battery level is exported for the keyboards that
carry a battery.

Tested on the OnePlus Pad 4 (iceland) running Linux 7.2.0-sm8850
(v7.2-based iceland tree).

---

 .../bindings/input/oneplus,pogo-keyboard.yaml |   81 ++
 MAINTAINERS                                   |    7 +
 drivers/input/keyboard/Kconfig                |   11 +
 drivers/input/keyboard/Makefile               |    1 +
 drivers/input/keyboard/oneplus-pogo-kbd.c     | 1109 +++++++++++++++++
 5 files changed, 1209 insertions(+)

-- 
2.53.0
