Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E913998B4
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888038; cv=none; b=bJuq/JyPaJPhVo0DhyXzB43Cv1HKTvKW3z7ahU4xK+C1QwwkFQGbdYoIoYUiyAO/MZx0NawipiEgTt+/vD83oKcaCiAW0glz5htzMDO2Of8dFPlYBmS3uB7CW8SjlXDvZFxATkIa2Uj4EuGeGb2cFM+pgYZjxdCWjxNf5cd20q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888038; c=relaxed/simple;
	bh=J75o9yQ4QEnGm/Ofm0EAdYOD7d1uBAmCB87/l3oscZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pr0uJ4lI+k88JQFL/q6iys9ddKVhBsh38eV/ybDGitXcGJPJUE4/e0/2F5vOcUacAVTGe9+r5YdVOq7bBnmW43inD790xLDHzaaR8nK9zYqRKvPTQo+uK4gPSByhl8RPXWViHtf/zcLm81+9P7l5Gdx3S8RlbB+qhGOm42qyzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCUziM0J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCUziM0J"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2721771f8f.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888035; x=1792492835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rs5a1E1r4/yCTP7mpX4ij8UiFP5xrJDZBhszngJHLds=;
        b=PCUziM0JBBjpQ5tzs1AiWgDyVQOuP/ElIgPgQIOz7HFkfddbOlYKOMhheim5/PVdTG
         NoBPcGm2hLWOvbnnF1/X0NKMYSc/nHB1vr2ehzce/IPHXbTTDZBo3vEUNgi2q80GEks9
         kBrszLyWmVPgSIP7o8Yc5LIzztWrBB007YIqx+EBgf7bzu0IyRwq2FDWHhGR7KmEByBD
         Cum0kGQTsHwFndXmmJTiBLUTmYmosP96D3FVt0VoFLpBNpyDmVTLHb6GX+JaF0rgBBg7
         EEgJpXBSnAKlTooF89lD6ZA1BaLDF4zu003M6cnxvnc+BHiijNvPn/Pf88SsCEiBnmbx
         dWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888035; x=1792492835;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rs5a1E1r4/yCTP7mpX4ij8UiFP5xrJDZBhszngJHLds=;
        b=Xo6OuIbWucQXaLCTp9wIVWbbdHnfMPdBWpSJBnMa+A1tVAKLvIdtb4+069uzir6kEY
         vmMeC5RoWbj9NssVfYkAYG7uXoI4T1Zy4PujC5W4FcQSrvIFvZsEbREAClLlyDxgG3Jq
         7cpB5meC+fY4YjI1J4il4Rmemi+MDyC1MnZmy6KLapSyOmwOlIAlwIBI2JIH/GTwtpAZ
         wVlDtmCRovL4dr076vetR1IGqzOyitd44iFmrtz+8kERvKUeCxJu2dMZnQ2O8u5rAUae
         x/d2rYLYGcVeoayZZHNrwHUAFLq8R/cKkaRoguxVtZKVsILogMcposfViGbYzBoOxkh/
         mFeg==
X-Gm-Message-State: AFq9FYJ6xe7La/PNyYIGR88rbj34R8uXbnB++ukgtxVK8fUxLJGwk+Ho
	LjTdCBSCxTjK/V7UVQg2FxR2Kpom08d+TIV0xZVM+9KbyPMn6H/yCAR+
X-Gm-Gg: AYBFou0YWJj9aK71vANT/lwwH+7sXQp3Kh+2eLUrp2PEo+RZpd/n7taYucI/mh2u2eN
	AZ2aqAxrmq4veifu2x3ba4UxRDkU/CVmAFl6eQFW0B/gUwJZwjSsolKSoIczwrdo9hrgonvaXEc
	34IUQunWpyk31hXl8HHzYvkSyYJiz0j6wuU7YwBCPNo81gETwoKmQnWffjYY2VqiZMRnmRPm/An
	lsLySyc3yjZOwsOI0Qr32xMaAGeZDKwZPKVSl8deMqTXD4DD+PxGluIqmYqPwE/RxuQB2hS+r4O
	A9WzYyREw/mCqYSNyQfskiMp+RiJA/A4flx+sEQP6F9/Kr98JTAWJA6GzfKQ6UvGhd4qOdiKKPG
	kRKvFqItRwFV3ytulB0faMAaT0AWSsaisMUKCEC5K16Tf9Ys2u7el7jEgMEPdxMR95ZKesBrE2d
	Mz+TASGln8rZq/77V1Jll82Z9KolPKP0I2mFdYbcDwC2kQAl0DWxCSNm6LsvpwSSsbcDQYmcyhl
	OfjzyIkr4QyVnmW0FBf2tPXtDSWVC/NKGnjNJiC8fqAaIbo1EvR8voWcg==
X-Received: by 2002:a05:6000:4a15:b0:48d:bc33:fa82 with SMTP id ffacd0b85a97d-48dbc33fd9cmr20808675f8f.11.1791888034492;
        Tue, 13 Oct 2026 03:40:34 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:e22b:cb88:4091:8aab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm4434024f8f.3.2026.10.13.03.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:33 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Tue, 13 Oct 2026 12:39:57 +0200
Message-ID: <20261013104033.36079-1-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the detachable USB/Bluetooth keyboard of the ASUS
Zenbook Duo line (UX8406MA, UX8406CA, UX8407AA): hotkeys, keyboard
backlight and the platform profile key, over both transports.

This patchset is a collective effort, gathered here:

  https://github.com/NeroReflex/asusctl/issues/25

Tested on a UX8407AA against 7.3, docked and over Bluetooth: hotkeys,
keyboard backlight, Fn+F profile cycling, and the touchpad staying with
hid-multitouch. Rebecca tested v2 the same way on her UX8407AA.

Rebecca Mara Müller posted an independent patch for the UX8407AA
keyboard in August [1]. This series follows it in using
HID_CONNECT_HIDINPUT_FORCE and in binding the IDs by group, and
carries her re-sent handshake as the last patch.

Changes in v3:
- Queue at most one platform profile cycle at a time, so that a device
  repeating the key cannot grow the worker's action list (Sashiko).
- Bind the Bluetooth IDs to HID_GROUP_GENERIC as well: over Bluetooth
  the touchpad is a second HID device with the same IDs, which hid-asus
  must leave to hid-multitouch (Sashiko).
- Say "15 data bytes, 16 with the report ID" where the feature report
  size is discussed: hid_report_len() counts the ID, so the 16 byte
  handshake is sent whole (Sashiko).
- Add Rebecca's Tested-by, and Assisted-by on her patch at her request.

Changes in v2:
- Rebase onto hid.git#for-7.4/asus; QUIRK_ZENBOOK_DUO_KEYBOARD moves to
  BIT(16) as BIT(15) is taken now.
- Fold the USB descriptor offsets and the padding removal into the
  descriptor fixup patch; fix the padding removal, which read past the
  end of the descriptor and could write past the end of the new one,
  and move the whole remainder of the descriptor instead of 12 bytes,
  as the Zenbook Duo collection does not end there (Sashiko).
- End the fixup's branch chain with a plain else so clang does not warn
  that rsize_orig may be uninitialized (kernel test robot, Nathan).
- Drop the MyASUS key mapping, which is upstream as KEY_PROG1 now and
  matches asus-nb-wmi (Sashiko).
- Use HID_CONNECT_HIDINPUT_FORCE on the vendor interface instead of
  injecting a fake keyboard collection into its descriptor (Sashiko
  flagged the malformed padding item).
- Cycle the platform profile from the driver's worker instead of the
  HID event callback, consume the event, and only build the call when
  ACPI_PLATFORM_PROFILE is reachable; v1 did not link on architectures
  without ACPI (Sashiko).
- New: cap feature report writes at the declared report length; the
  Zenbook Duo does not answer the 64 byte writes the driver sends for
  the backlight since 7.3.
- Bind the USB IDs to HID_GROUP_GENERIC so hid-multitouch keeps the
  touchpad interfaces, and leave Fn-lock out, see that patch.
- New: re-send the handshake after probe (from Rebecca's patch).
- Use the "HID: asus:" subject prefix, write commit messages for every
  patch, and fix the Signed-off-by chains.

Not covered: Fn-lock (see patch 6). On the UX8407AA the screen swap key
sends a Super+P chord by itself; the 0x9c mapping is for the UX8406MA.
Sashiko also pointed out, on v2 4/7, that the worker's WMI fan fallback
takes driver_input_lock while hid_device_remove() holds it around
asus_remove(), which waits for the worker; that predates this series
and is better fixed separately.

v2: https://lore.kernel.org/r/20261009153459.124752-1-p.pisati@gmail.com
v1: https://lore.kernel.org/r/20260513163248.16483-1-p.pisati@gmail.com
[1] https://lore.kernel.org/r/20260811125548.1975748-1-rebecca.mara@posteo.de

Joshua Leivenzon (4):
  HID: asus: Fix up Zenbook Duo report descriptors
  HID: asus: Add missing Zenbook Duo hotkeys
  HID: asus: Force hid-input to bind to the Zenbook Duo hotkey interface
  HID: asus: Cycle the platform profile from the Zenbook Duo profile key

Luke Jones (1):
  HID: asus: add prod-id, quirk for Zenbook Duo keyboard

Paolo Pisati (1):
  HID: asus: Do not send feature reports larger than declared

Rebecca Mara Müller (1):
  HID: asus: Re-send the Zenbook Duo keyboard handshake after probe

 drivers/hid/hid-asus.c | 194 +++++++++++++++++++++++++++++++++++++----
 drivers/hid/hid-ids.h  |   6 ++
 2 files changed, 185 insertions(+), 15 deletions(-)


base-commit: 8099f9da59f1c338bf88e25b7aa2a7fdf840879c
-- 
2.43.0

