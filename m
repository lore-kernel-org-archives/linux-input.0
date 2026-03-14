Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B923183F
	for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450340; cv=none; b=ht6uh8gcPjP911XmhicJmPbEl4PCxMv9xu4wT529ca3mVJSDiyVadnqjrpOy7YJrKHEjn/BHzOFMe6c1AaD+/tkn3NYZn0n7R43MnMm3Tqb9f/Mf4JlLvQcyaA/YTaJ0P4dvcpqyDUhYWvlKbzIZX/oXYeCHmkAci5IwG2s8cMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450340; c=relaxed/simple;
	bh=QD8IJvX9VZieY8pcCZGgkNtS+hRqgT9Cvfmiv+Ifzpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QG8ilvg5CGP1raCrJZzZl7u1HfOAOlG6EdluJoXx9g/ZRdhtFIoDNuoXEbbDwOpUHvyg0cpDH/HRik23n+xfAhJin+O8zj0bWW4Px9LiospVXNtUMYbbIIeMvpRb00x/M4aSoKbnjqq+FSl6MmOD7+hpQmtqvNWHevTOdgVzKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlQ8RUXW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlQ8RUXW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso21692715e9.2
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 18:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773450337; x=1774055137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QzqL9Iv/Ww5wZvqSt/AhzZpe019G8OQviCfvAtV7Bk=;
        b=JlQ8RUXWJvqb+IZIm5avISRcPAjnEkppax5N3f9nOhWetdXDezQggAiptkpRDbOd0V
         cx03xY+3cEq+ike2og0Br8YN/ylmMfWEcblCnfMZXHu1/QGRHGGCyiWzz+mmwcrG4t6+
         1OxXiZJUKzHPtiXnxYGLsKgUGG9FEWyA1jPGwectEIl2gjlyq5hMxOauEHlkUMGbY/OX
         dgP2VaPEboSMkhgP2FtTHB9yfCs1rG+AktGyVQNKBSe1zIiMdFJ/k94MR2wOG6wryEeE
         qccNocTPAEF5KYnCOLFgR8+QFiUzMcYvr3FRRT7JIrsBW6Vtr3XfLS1A4rZT8P3WSGGD
         PxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773450337; x=1774055137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QzqL9Iv/Ww5wZvqSt/AhzZpe019G8OQviCfvAtV7Bk=;
        b=DzHVt2p5NC+rjukHQFAllUZXLaQbo7aosavRyvKfCqjrYSxkv7qp/5/ZfEQOdTBEoj
         jpvpMq2EpcULa7hS+p6U1nn8k2sZgyviNAZaaeBEEW3inz1SAHPcwPN1JfKDDxnUgkEd
         hgrfSpZsHsCbN/N2P7tC826ZvI64vLA9O//GgEDodL2425EVrNlAMhBBeeC8VTCQJ1sB
         MCqe+wfhA1Z+k2Ke8RAvR/6WHLpL91zuPypelLcXxWOddbgx3nO939U42023IfcNUla3
         wfsW8492SRCazbLTecX2pzIZBFkcb4dnSdQXGMXCxB5rWYZ901oYWEyE38WfXWzSY+nT
         3DRQ==
X-Gm-Message-State: AOJu0YxeD+2jjPITv2wT9qrT6Ugb1KkXLGgxO+qfclCR0q0WDkit1IMX
	HCsl0gF/ksuINd9ACmffF99lZxKQQ8aFlkrGiR+/tkauWtClfp9getaDXgS7kEOzn6Xs
X-Gm-Gg: ATEYQzxVYWlffdsNomnVKZHBRyoQKgvC4ynFHT/cXEFEBNQPUPWPrFYIy3Zk+7kW43q
	e/mB/oiV338DLuExZPq2U+CoApqFGIdjKmXNf743etEcsdkEfXzx8j2JURfSiI0uCviaWeVvg4C
	OR1gBPfNzLBdpY3leXvMmRN7Caob3rm2pl9f89CqBi2X2ekYCIrqyokQcMY+XVYsowO0kTENYY8
	TfJ/vnuER9GYtD5Ig8198bQZ6g7iAc6NZjE7oljM+gNI/vqM8hWy4L+UqOO/+8U5atv1ilUJBmr
	vkLcebu8HoxYX0jqjQeHwzuu+4GgLUprirdh9IFN/meFvP8v2bE4S5+z54XhyOUaBYJFb4HEkS6
	Fss3exXCJWIOUDjnQ1FDMpMHgq/GGeT+qA2i6CBVS+cz/FALd9GLD2CFMHykw+Q3kJW1eP446RF
	Ce3ep6jQ8jo91FfqxGUTEo10PSpFPuhXqMBegig0nawezT4h7ge3JSGWej9LxUC5dR5m4IElqj5
	TR4dYCvxslnRuLFXx8cpvoo1EN7jWYqkZEXjfBfmOQbISSqIwu6UcDzdZjj38YTU8SwVjXMavJ3
	u3EcwE8cV1C+4Jc=
X-Received: by 2002:a05:600c:46d2:b0:485:3a03:ced1 with SMTP id 5b1f17b1804b1-4855672737fmr91652075e9.28.1773450336455;
        Fri, 13 Mar 2026 18:05:36 -0700 (PDT)
Received: from sissix.lzampier.com (92.40.172.137.threembb.co.uk. [92.40.172.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm13059963f8f.36.2026.03.13.18.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:05:36 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lcasmz54@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 0/3] HID: Add support for multiple batteries per device
Date: Sat, 14 Mar 2026 01:05:27 +0000
Message-ID: <20260314010533.110278-1-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for HID devices with multiple batteries.

Currently, the HID battery reporting subsystem only supports one battery per
device. There are several devices with multiple batteries that would benefit
from this support:
- Gaming headsets with batteries in both the headset and charging dock
- Wireless earbuds with per-earbud batteries plus charging case
- Split keyboards with per-side batteries

## Proposed Solution

This series introduces struct hid_battery to encapsulate individual battery
state, replaces the old battery fields with a list-based approach, and adds
support for multiple batteries tracked within struct hid_device. Batteries
are identified by report ID and named as hid-{uniq}-battery-{id}. The
implementation is fully backwards compatible with single-battery devices
through a helper function. The series first converts the battery code to
devm_* as preparatory cleanup, which simplifies the subsequent refactoring
and reduces risk of memory management bugs.

## Testing

Tested with split keyboard hardware (Dactyl 5x6) using custom ZMK firmware
that implements per-side HID battery reporting. Each battery (left and right
keyboard halves) reports independently through the power supply interface with
distinct report IDs (0x05 and 0x06).

Test firmware available on my personal fork at:
https://github.com/zampierilucas/zmk/tree/feat/individual-hid-battery-reporting
If this series gets merged, these changes will be proposed to upstream ZMK.

HID descriptor and recording captured with hid-recorder:

D: 0
R: 162 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 05 07 75 08 95 01 81 03 05 07 15 00 25 01 19 00 29 67 75 01 95 68 81 02 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 26 ff 0f 19 00 2a ff 0f 75 10 95 06 81 00 c0 05 84 09 05 a1 01 05 85 85 05 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0 05 84 09 05 a1 01 05 85 85 06 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0
N: ZMK Project Dactyl 5x6
P: usb-0000:2d:00.3-4.2/input2
I: 3 1d50 615e
D: 0
E: 0.000000 3 05 00 56
E: 0.000977 3 05 00 56
E: 1.490974 3 06 00 52
E: 1.491958 3 06 00 52
E: 6.492979 3 06 00 53
E: 6.493962 3 06 00 53

The recording shows both batteries reporting with different charge levels
(Report ID 05: 86%, Report ID 06: 82%-83%), demonstrating the multi-battery
functionality. This can be used to verify UPower compatibility.

## Future Work: Userspace Integration

As suggested by Bastien, semantic battery differentiation (e.g., "left
earbud" vs "right earbud") requires userspace coordination, as HID
reports typically lack role metadata.

This will require:
1. systemd/hwdb entries for device-specific battery role mappings
2. UPower updates to enumerate and group multi-battery devices
3. Desktop environment changes to display batteries with meaningful labels

This kernel infrastructure is a prerequisite for that userspace work.

Lucas Zampieri (3):
  HID: input: Convert battery code to devm_*
  HID: input: Introduce struct hid_battery and refactor battery code
  HID: input: Add support for multiple batteries per device

Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>

Changes in v7:
- Rebased on top of hid.git for-next branch as requested by Jiri
- Adapted to new battery_present field and HID_BATTERY_QUIRK_DYNAMIC
  quirk introduced upstream
- Adapted to kzalloc_obj() -> devm_kzalloc() and __free(kfree) cleanup
  guard changes in upstream

Changes in v6:
- Split v5 patch 2/2 into two separate patches as suggested by Benjamin:
  - Patch 2/3: Introduce struct hid_battery and convert existing code
    (no functional change for single-battery devices)
  - Patch 3/3: Add multi-battery list support
- Renamed hid_get_first_battery() to hid_get_battery() as suggested by
  Benjamin
- Added devm_kfree() calls in error path of hidinput_setup_battery() for
  proper cleanup if devm_power_supply_register() fails

Changes in v5:
- Split the monolithic v4 patch into two logical patches as suggested by
  Benjamin, devm_* conversion, then struct refactor and multi-battery support
  combined

Changes in v4:
- Added missing hidinput_update_battery() stub in #else block for
  CONFIG_HID_BATTERY_STRENGTH=n builds
- Reported-by: kernel test robot <lkp@intel.com>
- Closes: https://lore.kernel.org/oe-kbuild-all/202511201624.yUv4VtBv-lkp@intel.com/

Changes in v3:
- Squashed the three v2 patches into a single patch as suggested by
  Benjamin
- Removed all legacy dev->battery_* fields, using list-based storage only
- Changed battery naming to include report ID: hid-{uniq}-battery-{report_id}
- Converted battery memory management to devm_* for automatic cleanup
- Updated hidinput_update_battery() to take struct hid_battery directly
- Added hid_get_first_battery() helper for external driver compatibility
- Updated hid-apple.c and hid-magicmouse.c to use new battery API
- Simplified cover letter based on feedback

Changes in v2:
- Split the monolithic v1 patch into three logical patches for easier review:
  1. Introduce struct hid_battery (pure structure addition)
  2. Refactor existing code to use the new structure (internal changes)
  3. Add multi-battery support (new functionality)
- Added detailed testing section with hardware specifics
- Added hid-recorder output (dactyl-hid-recording.txt) demonstrating two-battery
  HID descriptor for UPower validation
- Added "Future Work: Userspace Integration" section addressing Bastien's feedback
  about semantic battery differentiation
- Added hardware examples with product links to commit messages (per Bastien's
  suggestion)
- No functional changes from v1, only improved patch organization and documentation

 drivers/hid/hid-apple.c      |  10 +-
 drivers/hid/hid-core.c       |   4 +
 drivers/hid/hid-input-test.c |  39 ++++---
 drivers/hid/hid-input.c      | 197 ++++++++++++++++++-----------------
 drivers/hid/hid-magicmouse.c |  10 +-
 include/linux/hid.h          |  57 +++++++---
 6 files changed, 186 insertions(+), 131 deletions(-)


base-commit: 73965d0aefc8ef6504552e5805f645d58a8727b0
--
2.53.0

