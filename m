Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621F3AB5C7
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788043865; cv=none; b=qtdaQ6s4DdyANP66oUXE3vby9LuXykTND2HNDDLw5lhWMBZXldSA020etIMavKem8mfTy/VJ4Fs1KC6qwIMBltpofgiL/kLiDNQ04DCyPkF6diQnuVx4xFBxbIyn92AxcqNCy5biwCKR8yhSnPmqvHP1INkkbwqCtuY5UqSvmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788043865; c=relaxed/simple;
	bh=shQX2wo+f3M8UgqTq6bRgvEBOC3zQrskEH31c6+PGsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRfzH51D5EtVwpaFVxH72gI74qEvOHZKLO78+XaPyEOarn7Uf6c4YgYcRaVNnzNONPtMic2IBRYxa3nyOyU8ClfWsOmELhIMoIwM9cqypeKVJ6WDJ1xQt9OI4OHrWI5r1T9Zcgfs/1j/Li2iSWYO2WPz4gdiYA1cp2uJqWRDIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppqna2eT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppqna2eT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so20467685e9.2
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788043861; x=1788648661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZgKfK0BXySBVGINlvx9UFrNadPZLdOTWQIvm5BNrYc=;
        b=Ppqna2eTKeGOAm+xwilERiUez3h5wBiUm3eYTgXtM/eZlm9x8rwbsJIxMmDjgl4G5g
         OikmwyJRqF/W5rdzv6E1cZH2iWtmNO9wn6Y+Y2wnGO5q6Njs29/72/nURccClosnSeIF
         yWpRgU2B22Ip9+mSlvT2DN2BDPxzn0RYYJeaqqrlBOhdd6GwFvAhzQYeZJ44JVzNbgI+
         5mRIEXjj//mTMGmp9+sSAdtjNl73ztCZ0/F69Xc7lO6YureIkXe+k9popUfGe7a7uzel
         absiq8ZL8RLQvi+JzZK6DnhWW8qua+4Z3Y04NHXw/HZ4nLp0g4fD1OeUO4w/gdt0jaZA
         Fa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788043861; x=1788648661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZgKfK0BXySBVGINlvx9UFrNadPZLdOTWQIvm5BNrYc=;
        b=p8nIZ8WrAhOomEMtPWtC6QmW2F0PRRWbCCXLD7kwVu9zXCcYhRWnjN528xeAGsbFcA
         NAc1hpKOwODn8IiidMBMQHH3A10kW4Ws935ShvisQd3JlMHisLBq7pa4ZL2E4OMH74+0
         CaNIaEB/IFtKjBPlP06t4JenFeVz1XQ4+LX7prNPupKJhM/4BaF6MvunfcPW2k8f8sji
         Dui58JA7B54FGSbWvhqpOIE/loTyjzfwdlcLH2jbtCfxtMJiEgXKsXqZqMDWQ82qA8mW
         eltTYVvAe72B9h1riQoM8ONzxdM0M/BhQdGFNBiXA8O7+tKM4O+A8kwLw7ZYC5eyrrSA
         v5KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlwJjOKoQqExR9P1emkSe/Q9UMri/8k6zxRKs0yJTNN0qtNTy90v35uJiH/fiUGbuLLuxoF93tlz9/MQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lrrEQnsEmYskP+KqUs0yNgTNqU5cPYTNlemQqP17STBN2fwRfK
	ya4juoPhiuIDS1yRVkYZ73VPErEGAAzzGd/IQ3VC9YRU5uklK+szI3ke
X-Gm-Gg: AR+sD12TjeWJIfrKQOB152wsARUMXnxQv+tt79sa6RAgdbI/ugA8zstFX0AFlMI3Xno
	jZeOUtKD8j4Mxw1V9DtKKz0IcPbrAdb7K/WXfdjEmYWdTM1tWz3T2rb006e1CKWYbLWWxPZbyws
	zrRZLjciNaj2YQnZfb6wZyogqty62UBYuTBEtOYZoOFduWYwCIf5cHvS7mZ7DxMqfhKP0KrlJtp
	ToW2MLgdQEEMG0etVstYcZkxr47V37fC9zIoil0GcBfgzRv7tBp6DhTmXuPHKVAfnjbi0wwEV1P
	XYqC3npvqQwH7Eah+/PqX2srhGPjlxIFo5Bsh9vlYXv0+aKZFnSqtD9IJmD3sKvAiGDS162yMKa
	62LS9zesjKfPoHwA3pHBuillf+x/nScLUnHMl93vuumcEIApwDYOv0Yex5piDsMyh9UrNHj7ndS
	wM9ctJMpZbNyAlDYR2demUfCjXMjm9WZ0ChMO1lOGkXvkyvoL6zy3n2Y5X6oaglRWPNxQqHAsrS
	buGxrfOH9M7wQKtIvPxr/JhnNe/RAuiQJKaoM+aNwEE
X-Received: by 2002:a05:600c:3103:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49b91c4fa9amr227707475e9.9.1788043861140;
        Sat, 29 Aug 2026 15:51:01 -0700 (PDT)
Received: from 1Z10 ([37.161.113.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b961820ffsm70466735e9.3.2026.08.29.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 15:51:00 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maurizio Casciano <mauriziocasciano7@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] Input: drv260x: Restore configuration after device close
Date: Sun, 30 Aug 2026 00:50:57 +0200
Message-ID: <20260829225057.386976-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apLAjoZPxp9JJTrl@google.com>
References: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com> <684969b0f53a9e5f83636b219c139e904e74e14f.1787872237.git.mauriziocasciano7@gmail.com> <apLAjoZPxp9JJTrl@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Thank you for pointing this out in your review [8].  I reviewed the
DRV2604 Rev. C
datasheet and the regmap implementation again, and I am withdrawing this
patch.

The configuration-loss premise raised by the initial automated review
[6] was incorrect.  Section 7.4.1.3, "Operation
With EN Control", of the DRV2604 datasheet [1] explicitly states:

  "When the EN pin is logic low, the device enters the shutdown state,
  which is the lowest power state of the device.  The device registers
  are not reset."

The same section says that a complete reset to the power-up state
requires DEV_RESET in register 0x01.  Section 7.4.1.5 further describes
DEV_RESET as equivalent to power-cycling the device [1].  Therefore,
drv260x_close() deasserting the enable GPIO does not discard the
configuration established at probe, and there is no need for an open
callback to run drv260x_init() again.  The mainline close path can be
seen at [3].

This datasheet applies to the tested tablet: its firmware exposes two
present ACPI devices with HID and modalias DRV2604, at
\_SB_.PCI0.I2C1.VBR0 and \_SB_.PCI0.I2C4.VBR1.  They enumerate as
i2c-DRV2604:00 and i2c-DRV2604:01, and both are bound to the
drv260x-haptics driver.  The TI Linux support page also lists DRV2604
among the devices supported by this mainline driver [2].

Independently, Sashiko's follow-up warning [7] about the proposed
implementation is valid.  drv260x_init() calls regmap_register_patch()
for the selected actuator mode, as shown in the v7.2 source at [4].
As [5] shows, regmap_register_patch() grows map->patch with krealloc(),
copies the supplied sequence after the existing entries, and increments
map->patch_regs.  Calling
drv260x_init() on every input-device open would consequently append the
same register sequence repeatedly and retain that growing allocation
until the regmap is destroyed.  Repeated open/close cycles would thus
cause unbounded kernel-memory growth.  The relevant implementation is
quoted here and linked in full at [5]:

  p = krealloc(map->patch,
               sizeof(struct reg_sequence) *
                       (map->patch_regs + num_regs), GFP_KERNEL);
  ...
  memcpy(p + map->patch_regs, regs, num_regs * sizeof(*regs));
  map->patch_regs += num_regs;

The related concern about haptics->mode being changed by playback only
affected the proposed attempts to call drv260x_init() again during open
or resume.  Once those unnecessary reinitialization calls are removed,
the suspend/resume fix does not depend on re-running mode-specific
initialization.

I have therefore dropped v2 patch 1/2 completely, with no replacement.
The forthcoming v3 contains only the suspend/resume sequencing fix from
v2 patch 2/2.  It disables and drains the work item before suspend,
balances the work state on error paths, restores power and communication
before leaving standby, and does not call drv260x_init().

Technical references:

[1] Texas Instruments, DRV2604 Haptic Driver datasheet, Rev. C,
    sections 7.4.1.3 and 7.4.1.5:
    https://www.ti.com/lit/ds/symlink/drv2604.pdf
[2] Texas Instruments, Linux Driver for DRV260x; supported devices and
    mainline source information:
    https://www.ti.com/tool/DRV260XSW-LINUX
[3] Linux v7.2 drv260x_close(), including standby and EN deassertion:
    https://github.com/torvalds/linux/blob/v7.2/drivers/input/misc/drv260x.c#L260-L274
[4] Linux v7.2 drv260x_init(), including regmap_register_patch() calls:
    https://github.com/torvalds/linux/blob/v7.2/drivers/input/misc/drv260x.c#L315-L379
[5] Linux v7.2 regmap_register_patch() implementation:
    https://github.com/torvalds/linux/blob/v7.2/drivers/base/regmap/regmap.c#L3417-L3473
[6] Sashiko's initial review, including the configuration-loss premise:
    https://lore.kernel.org/linux-input/20260827182855.DE8E91F000E9@smtp.kernel.org/
[7] Sashiko's v2 follow-up identifying repeated patch registration:
    https://lore.kernel.org/linux-input/20260827233020.416711F000E9@smtp.kernel.org/
[8] Dmitry's review rejecting the EN-reset premise:
    https://lore.kernel.org/linux-input/apLAjoZPxp9JJTrl@google.com/

Thank you, and thanks to Sashiko for identifying the memory-growth issue
in the proposed implementation.

With Best Regards,
Maurizio Casciano
