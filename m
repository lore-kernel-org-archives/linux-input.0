Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B426A08A
	for <linux-input@vger.kernel.org>; Sat, 16 May 2026 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778905726; cv=none; b=d8HuEPMq0JZC/rLNVqWcUw6SexFELsOz/rjB88vtaLpLyRIau2DB5FOpA4XNqhq4rjewjTMzBD50Ex5Iye0e0fYmWah2cJ+XIkhc9WERPgqQpEBoeQIQOJBLQ9uxQjU5R46s2o/EGVteCqrhrkuQmT5Kefd8Al55Hfe/KXlO0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778905726; c=relaxed/simple;
	bh=Efyjxo5sRkOPGzC5lMp76gRG3i74abRPSbUI0KNH+x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5nkbBijGn8t1ZskYBzOIqd17nVMLgYT94Y1M/3KuWPY+YeHFOXChaW0lOrdQ2+h15+zWmmu4m4Rs+Cspsv5VF30EIRpayRKQX82gc0SQrfahizvB2rMeC50buewkblKWDvTGJ4pin+UDW4gv5GEMIEpNsR4wODb9GzqpKcnbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsLmeGP9; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsLmeGP9"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12db2e415a7so210945c88.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778905724; x=1779510524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2L3ArsydMM7ZwsesN+agD5A9YE3EDEMAVNN2HLzX8TM=;
        b=RsLmeGP9AJsaVW58bN3SRFc7SHXhgemfweY9jgdOIEjgOvYAb+GDv0oHPqE2j1Ebl8
         H73FXQMiRriNfZtGQ3lpAru5HwGwfdSWIvXyjEGvl/mww0bVDCCOqRvXfHmh31o3GYo7
         BTUzlau1xWQ+MX+kkyy7owlBlt7ubUcYEa6pJCnr8gBoKZ2dUII77jq016DrGiXXe1iZ
         /MkfLZO1LX7PEoF5nf02fmy8yNaa5fwWEq9aNUiDKIJtHw24CuBsFyEEbu+MkbQe70+L
         od9Yu+Lj2jfSnsktuyUZCWUkUyZcHelBqp3lr4nHKHUhW4dl3JsFVAbI7TNaroBkX4+t
         QCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778905724; x=1779510524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L3ArsydMM7ZwsesN+agD5A9YE3EDEMAVNN2HLzX8TM=;
        b=Vl7kPNTYKMEx6cYZ6GJtHSdBrLsg982tCQ3x35kg+3EsqjLsGmhm8Q6xaOqNEcpWph
         BMWV8vioK/6PH7/lET+qDiWWdx4dVQ0vCS9WUjUfS+XO9IrPHlu8FGSRuYe8Sat/+wef
         Hoi5d2fwQ7fp9WrDItc75j09//hEG4SQuxQ+1Xu6uL7xN42co0Ls+fwVTyuk4uDR3vlF
         RZAmzRXC7XQelt/7dug5Ah3gYFWCUqRlcam0vAmzpORgoTr2uxmZTv+V7jCyibfmD5aU
         NYB/V8WaupZxEsX/V4gTgHILBTD5z913l4IFe32C3j9muXKJBLAbTyXbqkh8OnJg7s1I
         9yIA==
X-Forwarded-Encrypted: i=1; AFNElJ8BBdsIH21x4Lqesa2/CYVqYu4Bc8zGNDJxRgJeQ+4ueLDKcLncRhwUauWCfHUZLt2+hg61HRPbK4NWdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1RA4WD8lZMsJ/gLp2GqKs3Td2RroOk8hsk1WiVYGAHt+6OQs
	yngWf3kOuUtaatz+hzfF48F3stTn3jZw1uImqlZ9nnmScjc6d2lPvVkK
X-Gm-Gg: Acq92OGy3zrJa2r+xmoek1VLjWPOeZUUKePTxKhy7fHX3Fz6LWh39iOFJgw+ITQTaBy
	zJnvOKlVcJSBozvfW1OIJUNYi7kjT82rrSjJGoSr+xkgapbaWWQ7MoIzO8AaXx89eh4K+AM0oZf
	ljCErlCoqa3VzymN+LNrEhKXH1sU/As2DoSBerjiyk98A2v38isHeD42r+eD2QqOl10ZGmTg099
	zFhC7yErnGiUzkOs7mYB51eDyN8luv6SpmRFzzDQHF8irNA5dI52ucPRknVzH4NvlB7rDtph9wS
	oPeB//yJX6xJB+sywwbLW3JG/v5Jvtgki+3U4IW+nFKbDfvTUqtKiFOuylae/ibgV0IXruMPUm9
	9lT1u0estsMvwH9cekLW7I/IaNKDcwR/XuP7Bjw2D3Xv6pnn07jqj+X+XM5ekJv1mUTbYx6s3Q3
	ndq8ufD0PHH08JiVIvMHSLVStmni++ImST5qCniR2uIiJbWhxLCLt/U1Qv+4lw28sIvo+IZiOgT
	lB7
X-Received: by 2002:a05:7022:60b:b0:134:feba:3b7 with SMTP id a92af1059eb24-13504945c88mr3434138c88.31.1778905724079;
        Fri, 15 May 2026 21:28:44 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm13260185c88.7.2026.05.15.21.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 21:28:43 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add MSI Claw HID Configuration Driver
Date: Sat, 16 May 2026 04:28:37 +0000
Message-ID: <20260516042841.500299-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an HID Configuration driver for the MSI Claw line of
Handheld Gaming PC's. The MSI Claw HID interface provides multiple
features, such as the ability to switch between xinput, dinput, and a
desktop mode, RGB control, rumble intensity, and mapping of the rear "M"
keys. There are additional gamepad modes that are not included in this
driver as they appear to be used in assembly line testing or are
incomplete in the firmware. During my testing I found them to be unstable.

The initial version of this driver was written by Denis Benato, which
contained the initial reverse-engineering and implementation for the
gamepad mode switching. This work was later expanded by Zhouwang Huang
to include more gamepad modes and additional features. Finally, I
refactored the entire driver, fixed multiple bugs, and refined the overall
format to conform to kernel driver best practices and style guide.

Claude was used initially by Zhouwang Huang to quickly parse HID captures
during the reverse-engineering of some of the features. Since Claude had
already been used, as a test of its capabilities I had it implement the
rumble intensity attribute after I had already rewritten most of the
driver, which I then manually edited to fix some mistakes. I also used
Claude to review the driver and these patches for any mistakes and bugs.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v4:
  - Add msi_suspend/claw_suspend.
  - Reorder claw_remove to cancel all work before removing sysfs.
  - Add mutex lock for removing sysfs attributes.
  - Add mutex lock for MODE command data read/write.
  - Change dev_warn to dev_dbg in claw_profile_event.
  - use __free with DEFINE_FREE macro for argv instead of manually
    running argv_free, cleaining up scoped_guard goto.
  - Fix frame_calc validity check to use >=.
  - Use spinlock instead of mutex in raw_event and related attribute
    _store function.
  - Ensure delayed work is canceled in suspend & canceled before sysfs
    attribute removal.
v3: https://lore.kernel.org/linux-input/20260515033622.2095277-1-derekjohn.clark@gmail.com/
  - Add mutex for read/write if rgb frame data.
  - Ensure claw_hw_output_report is properly guarded.
  - Remove setting rgb_frame_count when reading rgb profiles as it always
    returns garbage data.
  - Ensure rgb_speed is getting drvdata from a valid lookup (not hdev).
  - Use scoped_guard where necessary.
  - Reoder claw_probe to ensure all mutex, completion, and variable
    assignments are in place prior to setting drvdata.
  - Ensure gamepad_mode is set to a valid enum value in claw_probe.
v2: https://lore.kernel.org/linux-input/20260513231445.3213501-1-derekjohn.clark@gmail.com/
  - Use mutexes to guard SYNC_TO_ROM calls and pending_profile calls.
  - Rename driver to hid-msi and add generic entrypoints for
    probe/resume/remove that call claw specific functions in order to
    future proof the driver for other MSI HID interfaces.
  - Fix various bugs and formatting issues.
v1: https://lore.kernel.org/linux-input/20260510043510.442807-1-derekjohn.clark@gmail.com/
Derek J. Clark (4):
  HID: hid-msi: Add MSI Claw configuration driver
  HID: hid-msi: Add M-key mapping attributes
  HID: hid-msi: Add RGB control interface
  HID: hid-msi: Add Rumble Intensity Attributes

 MAINTAINERS           |    6 +
 drivers/hid/Kconfig   |   12 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    6 +
 drivers/hid/hid-msi.c | 1708 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1733 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

