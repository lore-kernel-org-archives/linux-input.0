Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6948EC71
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560104; cv=none; b=LXeJv8oqmqanGvP+cEOJnIrW6wAnPV0dj4meqW01iyp4NFfiBY7K12J+ydjxXhqE68Rb8qLc3blv2euDcPr7tjDr2ZzXWcli/c3FJlohEB+H7/mp8z7WyfQcz4UM5frcE7VoBeWBSBeJKTuQnd0eRli9RKK5szb/hpRzfxXUUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560104; c=relaxed/simple;
	bh=+a4U5HVQU3WHYme+hfgT/b23Mzz+n4cGICyxVX0NuVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IuU0fCHeaLNZHe3tK2r8iuwYZOl4MdKPetJ9OR7AxsckGa1UFqtF4ZsfJkW1Bzs94FtaxbXC3+tNJinV954fGtekwqdbDneDbCcuNDBYCIhtp30dYUk8rKVnknxo/7SAinrq5UibyNvQFxUA56wNol10RqjAFPq3oRjFeeSLv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBllLKp0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBllLKp0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso68073305e9.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791560101; x=1792164901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2qvjdjY3J1vFVxGuXAsjXq1vqS+6oUh2fRBwQDdkJWw=;
        b=tBllLKp0ZXDWvy/T2Qu6+s4NyQyX5SfQOwqjuw+R09pUa22oL9vSctkgLDEg5asUCQ
         Am81CKyJB+tZGwnkXAJrdiZOcSfnVwx626dZg1B6aQv1ZQtDfpiu8EEVhbsUPmkxB9uY
         0qKiVMtf+yxSvN3Ihax6DNJcowubxwYWp40lOyeFQqWMS50+Lpm923LiLP8fAtShWo6G
         /U5ehTcxa0ZWTFdiwQyplcFpZq3j4w7n6PRGHCbPmHdzVMAYseYW+RN/0M+8qWUG88qQ
         7vo6W/3joHo0qFz8mIjxyPSXC3g9mNmIfTLbOhT0oRMiZ3Kyu293h9x2D+mZfOqwaePh
         Yo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791560101; x=1792164901;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2qvjdjY3J1vFVxGuXAsjXq1vqS+6oUh2fRBwQDdkJWw=;
        b=EOzC9l6QZJWO0lDTerilb4hSoMpToFirBjj2/A57FOx8leJE273aGyqIFmPmEpni+k
         6VIl+0Xhi3bju88aZ2fUcMjC5XPdO4h1WV5g6EaVZuRQ9/hdgG5DygwOdWFS6nPmCTzn
         dp/gVw5CNAnVQXeqgbQX/K15/pkn6NuTlDeHWky15Fe3VHvr03pnuPbrazLSBbLJuHVJ
         OsMmmb0HoM8TBLKda1xLPJj6908b3zv85B/K5TiiTO5TumzVr4+HMWxXUgBT8vTZIwSj
         fP2sLIpb2UWW95MhN66TX5Jk+6f9qIIX3rn76JTg6CVbg832fxaYP6QYOsLJna6i+9c+
         iyUQ==
X-Gm-Message-State: AFuF++mp4un+5lOanswRLtJ5C92oj2Bq+4iQ/zL9pw2/tjAScWRftlJ4
	s5nIVHwFxubT9Ufh9JslsG5eQIgRq7ICMmc7HLycaotAfAq3dI3NaYql
X-Gm-Gg: AYBFou1XGnNkJC/IhY5ujv8lb0sNfjDuIdMajEtPohb1NSA2HJGXF+mt8I3CX5CaG4E
	XQeazWWxZ2ggvGHFBStjuRT1qG/q0Vx20q59VCCIbp7EevlO9FOdjqTqh97u5cp7wNllx7HowwW
	bj6UCPd7EzwPuIcXXAD6ClnDEm8OacP02stCk1l0jpSvtL7luZusm55ahyJ15NI8kz5BL8Ygj94
	ZMsxTkxVgiD2alob9H7YiTuV8wkkL3rKu8Pzu+b+4Xyyw6U03duDPsvQes+5ekQpNi7z7DVtzr0
	86clFDZZhjnd6jrEI2iaET1D/7RtWj5JDCKtbI/8+BAy3wuDs+DIZAAqtSdGjJBhxEhlgAWQdbx
	XwRVXr1bAC2BJHp1Nq4JlPvz6J6Tk8++LXZ6cxBXHlVRgXuVErelsEthBgWV+eHnHacdyGQfVvC
	Crmjla3ojSpEqqA6jy7X8QLehrBkpFH6bqOWQaPCdqTqKqF+6aOBidrXYZyg8qlgrt2uL94GUPD
	/FKY0q/jgPbs0MQAT7NzF1ZEKSc/9WfkPX8YupPfrIDLuiIvU8QQ8FrVA==
X-Received: by 2002:a05:600c:3144:b0:4a1:70b2:8dbb with SMTP id 5b1f17b1804b1-4a18e4b0347mr42708135e9.19.1791560100886;
        Fri, 09 Oct 2026 08:35:00 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:8516:411c:ea75:bb84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e30a7sm4597713f8f.12.2026.10.09.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:35:00 -0700 (PDT)
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
Subject: [PATCH v2 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Fri,  9 Oct 2026 17:34:27 +0200
Message-ID: <20261009153459.124752-1-p.pisati@gmail.com>
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

v1 was applied to hid.git#for-7.2/asus and dropped again because of a
clang warning. This version fixes that, addresses the review comments
on v1 (Sashiko, Nathan Chancellor, kernel test robot) and the problems
found while testing it on a UX8407AA against 7.3, docked and over
Bluetooth: hotkeys, keyboard backlight, Fn+F profile cycling, and the
touchpad staying with hid-multitouch.

Rebecca Mara Müller posted an independent patch for the UX8407AA
keyboard in August [1]. This series follows it in using
HID_CONNECT_HIDINPUT_FORCE and in binding the USB IDs by group, and
carries her re-sent handshake as the last patch.

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

 drivers/hid/hid-asus.c | 178 +++++++++++++++++++++++++++++++++++++----
 drivers/hid/hid-ids.h  |   6 ++
 2 files changed, 169 insertions(+), 15 deletions(-)


base-commit: 8099f9da59f1c338bf88e25b7aa2a7fdf840879c
-- 
2.43.0

