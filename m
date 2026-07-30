Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A33CAE73
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412809; cv=none; b=X8vcIY2ELLQ7CRKmTQLbo5nRe48O4makTb1hYAGXxt6kLDRoUDCgbgWzcjJYQhkZLWcfUeTsE+PM5ufMW1NiX+qu6JT4sIxGZQ7abQinUyTQHEMf8CzcQwJpYoLAAq4BzqG45B2AdS4fHWYPBuD6Tf0tGHO/8BA/LB/VvCxVpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412809; c=relaxed/simple;
	bh=8Y0zg9I9JXgVFPHAkNmJWkRNpLBPiV+yFpJKZtcdiSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQ8jXwM6jmp5JcASGcELPLGFCnakehc1DPYtKdEw9AzDodCYZJng1JS5kA2PkOQQq0oGmdA8/mftpaTn9e9qp4c1K1Buj7yhscPioCEJduyEHC1OrRAmJ55zBZvTeimtIaLD/feDj42uh0O9sVoDdcnByyr9T14lDCvtB/Vk4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2042990a91.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 05:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412808; x=1786017608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xkO7ahM06Zo3Is02qQeMPpHg0AM2vLWCsIF0+w1yok=;
        b=osEavPRJfLkXoDRRKFn8lLdt2lRWRNXZWowNL8gsuBcLM77ugGvPi2j/HlZUbFphh8
         DH28fnc4qXAuEWtZtyPS01f8XATVn+Dd6m76PpyQSmJ0S6frTB7ECVlyuwIhzqBwIHqU
         9vlezmx8lmuBnJwGbY1sDNb2BVsdn55xt0qUPD40UEvRK0eC/p/ZtIrIsQYwoomWXVRD
         o728mC40pqVtman+M/K1ye3fMpUnjVWjiLlyLjH4RcN//BQ4u4YIbAq20nYCR22mwzCC
         SRjGDArXlAmz9D9HLJ+tuV/fQviL5U7HL4L0NL5OIJ2Nw+cdyS2GPXh0B/OUTarIllcX
         TviQ==
X-Gm-Message-State: AOJu0YxCGNdAk3W/2FE1aHyy5Rn/1vAHXPEBgj5oDG8tBcJH3hLWdqgS
	1nuKVcMuq5WwCEjWyZlxON1TJ1ZlnvlnmNfHVj+d/YUmMc0WOqJG0/VbknLjGLbG
X-Gm-Gg: AR+sD10b8kdo2CeETW0SfyiEybM1tPpnB5/Iumj1n3DKTTp/La8Wa8EcMKVrqC5rY0f
	Rsc3ru1cG+wY1b+Y74ceYWPhw77OywNHroJiGa5tIjgR8TJSBbr3L3IFz6mBUru3N5CJW5fZCSh
	TXmDsz7mBPEx9Q+pNF4gIoJbXAK+nBNNrysdF6GWLEIvlq+8Lf8eKKIlCrLcCsY0fYLf2ivdzMs
	e7PDUZ4qKiJW65fqpeuA0tz7ZDWXmmglsL+65ya/+vhRe6XeTYi4g+6eSiLLWdm+XAKkDiNJF/3
	DH8BgObA0iypkQ7VMl/VTat56C2qPUDoowASn4DKLcsry/PzTogPKuw0ExnsZXzgn6j0ZKo5DE+
	QEhOGrq3QlsDbDPv+vEGJHlGD73Dn/nuTpJ+K96SK5zM1c3Kvy75P3YDz2W4BXpJUrRaeUnKKKF
	KpmuA+eXSa7cPd7jtakICgFG8oNO1zqee6LwfBPQUykHI=
X-Received: by 2002:a17:90b:2892:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-38f9bdb4dacmr2014640a91.18.1785412807555;
        Thu, 30 Jul 2026 05:00:07 -0700 (PDT)
Received: from manit.. ([2401:4900:d9e6:b0d6:8e08:121e:b0e3:5406])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7265010esm21172674c88.6.2026.07.30.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:00:06 -0700 (PDT)
From: Dinesh dkkhatana136@gmail.com
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Dinesh <dkkhatana136@gmail.com>
Subject: [RFC] Input: atkbd: HP Pavilion Gaming keyboard backlight key reports unknown scancode
Date: Thu, 30 Jul 2026 17:29:50 +0530
Message-ID: <20260730115950.85353-1-dkkhatana136@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dinesh <dkkhatana136@gmail.com>

Hi Dmitry,

I'm investigating support for the keyboard backlight hotkey on an HP Pavilion Gaming Laptop and would appreciate guidance on the preferred upstream implementation before preparing a patch.

System information:

  Manufacturer: HP
  Product: HP Pavilion Gaming Laptop
  Kernel: 7.0.0-28-generic

When pressing the keyboard backlight hotkey (Fn+F5), the kernel reports:

    atkbd serio0: Unknown key pressed (translated set 2, code 0xab)
    atkbd serio0: Use 'setkeycodes e02b <keycode>' to make it known.

Running:

    sudo setkeycodes e02b 228

(where 228 corresponds to KEY_KBDILLUMTOGGLE)

causes the key to be reported correctly by the input subsystem.

To understand where the fix belongs, I investigated both the AT keyboard path and the HP WMI path.

Observations:

- The key generates translated Set 2 scancode e02b.
- acpi_listen reports no event when Fn+F5 is pressed.
- evtest on the HP WMI input device reports no event.
- Only the AT keyboard device receives the scancode.
- The recent hp-wmi commit "platform/x86: hp-wmi: Ignore backlight and FnLock events" (e8c597368b85) handles WMI notifications for newer HP systems, but my system does not emit those WMI events.

From my investigation, the issue appears to be that translated scancode 0xab is left as KEY_UNKNOWN by atkbd, while hp-wmi is never involved on this machine.

Before preparing a patch, I'd like to ask about the preferred upstream approach.

Would maintainers prefer:

1. Adding a generic atkbd Set 2 keymap entry mapping translated scancode 0xab to KEY_KBDILLUMTOGGLE,

or

2. Implementing this as HP-specific handling (for example via a DMI-based quirk)?

I'd appreciate guidance on which direction would be preferred.

Thank you for your time.

Best regards,
Dinesh
