Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA3362143;
	Thu, 22 Jan 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068276; cv=none; b=VPnUMf8W1m8jKwLHItQeCI2yW83cBRvhwq5sY6Z/anW7ZnlxJf2KuuIt7X+f0kj4QjrgghpI/BPZVKTw/is6NV+xuiR46mjGbkFSkgpMKhnSnz6tjSj3EG/duJ86rxAgie+Bsom8sRD7SL43Cr5PpS/UCU6kaHhWy5jJwJgMHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068276; c=relaxed/simple;
	bh=OKgrNCrTCpHsWEKJfPea3QKFly6T2HqOPXtGdNSac9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vb6odT9Lf05H/W9sbFPZBCknNfaBI1eqvsHIDFtpxyl9rEfaHY4DD6hgMcWOz92lGvq9GzriXJF4J+FUHjW2cQVuF1jI6d2XObJ0lVFTQa1+c3puBRg9xXl8PfCqVRcF+X9d9q6TpU8OGtFuM2+qYHKXi50kKfTvYPqFW9+bgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=iiN3Pj7V; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="iiN3Pj7V"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id B3C4140A83;
	Thu, 22 Jan 2026 07:50:53 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 4E59B409E4;
	Thu, 22 Jan 2026 07:50:52 +0000 (UTC)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c3:fefd:0:42c:a43d:2848:c282])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A4E831FC563;
	Thu, 22 Jan 2026 09:50:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769068251;
	bh=B+97gXruRUTKukOsEZlu5pjkE0Jtm2KdRRXBD3s+t4s=; h=From:To:Subject;
	b=iiN3Pj7Vk9Dh98sQdNzVplkr9paLiu/KnME4LIV2e+5jninIK8BX6Do1RPqg/lY7c
	 X7wIMlyGpnKWLY76RJbbyKet9iYZnPTMiDzlymZgWfez2++X/BNHU7XK0TW+/9CR1V
	 8L9WT8KVwJPXzlek1uTHL4hrgvYb6ruf7xY+ybQIW5LXQ14OcXboTSnlI8dLM1ECoZ
	 KXQbvF3ulULEH6tYJ0mrfAQl1KU1GdRTgQKLziGCJlW50pplpJTcIRU0c18FlexfIO
	 j1/3YqqLO8BgS95QBUfCu4khIKkTaXpQCCR0nZMvD5oWR0+l9vaFC2YphxVn7JmEWD
	 5nlPpWecuzs6g==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c3:fefd:0:42c:a43d:2848:c282) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v12 00/11] HID: asus: Fix ASUS ROG Laptop's Keyboard backlight
 handling
Date: Thu, 22 Jan 2026 08:50:33 +0100
Message-ID: <20260122075044.5070-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176906825130.711401.7733013217562804493@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

This is a two part series which does the following:
  - Clean-up init sequence
  - Unify backlight handling to happen under asus-wmi so that all Aura
    devices have synced brightness controls and the backlight button works
    properly when it is on a USB laptop keyboard instead of one w/ WMI.

For more context, see cover letter of V1. Since V5, I removed some patches
to make this easier to merge.

---
V11: https://lore.kernel.org/lkml/20260116133150.5606-1-lkml@antheas.dev/
V10: https://lore.kernel.org/lkml/20251122110032.4274-1-lkml@antheas.dev/
V9:  https://lore.kernel.org/all/20251120094617.11672-1-lkml@antheas.dev/
V8:  https://lore.kernel.org/all/20251101104712.8011-1-lkml@antheas.dev/
V7:  https://lore.kernel.org/all/20251018101759.4089-1-lkml@antheas.dev/
V6:  https://lore.kernel.org/all/20251013201535.6737-1-lkml@antheas.dev/
V5:  https://lore.kernel.org/all/20250325184601.10990-1-lkml@antheas.dev/
V4:  https://lore.kernel.org/lkml/20250324210151.6042-1-lkml@antheas.dev/
V3:  https://lore.kernel.org/lkml/20250322102804.418000-1-lkml@antheas.dev/
V2:  https://lore.kernel.org/all/20250320220924.5023-1-lkml@antheas.dev/
V1:  https://lore.kernel.org/all/20250319191320.10092-1-lkml@antheas.dev/

Changes since V11:
  - Rebase to review-ilpo-next
  - Legacy to ID1/ID2 and reword "HID: asus: initialize additional endpoints
    only for certain devices"
  - in "platform/x86: asus-wmi: Add support for multiple kbd led handlers":
    == -> >=

Changes since V10:
  - Fix conflict with ccb61a328321 ("platform/x86: asus-wmi: use
    brightness_set_blocking() for kbd led")
  - We are on v6.19-rc5 mainline again
  - In "HID: asus: initialize additional endpoints only for legacy devices"
    additionally remove the if checks to avoid bailing if the device does not
    support the init. Those inits are purely done as a precaution, we do not
    care if they fail. Dismissed Denis' review as the patch diverged
  - In "HID: asus: fortify keyboard handshake" do not bail if set report fails,
    as noted by Benjamin, but only print a warning. Also, start printing the
    report id in errors to identify them and use hid_warn for both non-fatal
    errors. The changes are minor so the reviews are kept.

Changes since V9:
  - No functional changes
  - Rebase to review-ilpo-next
  - Fix armoury series conflict by removing the file asus-wmi-leds-ids on
    "remove unused keyboard backlight quirk" + imports
    Dismiss Luke's review as this patch diverged
  - Reword paragraph in "Add support for multiple kbd led handlers" to be
    more verbose
  - Use kfree in fortify patch
  - Fix minor style quirks from --nonstict checkpatch run

Changes since V8:
  - No functional changes
  - Move legacy init patch to second, modify first patch so that their
    diff is minimized
  - Split "prevent binding to all HID devices on ROG" into two patches:
    - moving backlight initialization into probe
    - early exit to skip ->init check and rename
    - Remove skipping vendor fixups for non-vendor devices. It is not possible
      to read usages before the report fixups are applied, so it did not work
  - In that patch, reword a comment to be single line and make is_vendor a bool
  - Dismiss Luke's tags from "Add support for multiple kbd led handlers" as it
    has drifted too far since he reviewed/tested it.

Changes since V7:
  - Readd legacy init quirk for Dennis
  - Remove HID_QUIRK_INPUT_PER_APP as a courtesy to asusctl
  - Fix warning due to enum_backlight receiving negative values

Changes since V6:
  - Split initialization refactor into three patches, update commit text
    to be clearer in what it does
  - Replace spinlock accesses with guard and scoped guard in all patches
  - Add missing includes mentioned by Ilpo
  - Reflow, tweak comment in prevent binding to all HID devices on ROG
  - Replace asus_ref.asus with local reference in all patches
  - Add missing kernel doc comments
  - Other minor nits from Ilpo
  - User reported warning due to scheduling work while holding a spinlock.
    Restructure patch for multiple handlers to limit when spinlock is held to
    variable access only. In parallel, setup a workqueue to handle registration
    of led device and setting brightness. This is required as registering the
    led device triggers kbd_led_get which needs to hold the spinlock to
    protect the led_wk value. The workqueue is also required for the hid
    event passthrough to avoid scheduling work while holding the spinlock.
    Apply the workqueue to wmi brightness buttons as well, as that was
    omitted before this series and WMI access was performed.
  - On "HID: asus: prevent binding to all HID devices on ROG", rename
    quirk HANDLE_GENERIC to SKIP_REPORT_FIXUP and only skip report fixup.
    This allows other quirks to apply (applies quirk that fixes keyboard
    being named as a pointer device).

Changes since V5:
  - It's been a long time
  - Remove addition of RGB as that had some comments I need to work on
  - Remove folio patch (already merged)
  - Remove legacy fix patch 11 from V4. There is a small chance that
    without this patch, some old NKEY keyboards might not respond to
    RGB commands according to Luke, but the kernel driver does not do
    RGB currently. The 0x5d init is done by Armoury crate software in
    Windows. If an issue is found, we can re-add it or just remove patches
    1/2 before merging. However, init could use the cleanup.

Changes since V4:
  - Fix KConfig (reported by kernel robot)
  - Fix Ilpo's nits, if I missed anything lmk

Changes since V3:
  - Add initializer for 0x5d for old NKEY keyboards until it is verified
    that it is not needed for their media keys to function.
  - Cover init in asus-wmi with spinlock as per Hans
  - If asus-wmi registers WMI handler with brightness, init the brightness
    in USB Asus keyboards, per Hans.
  - Change hid handler name to asus-UNIQ:rgb:peripheral to match led class
  - Fix oops when unregistering asus-wmi by moving unregister outside of
    the spin lock (but after the asus reference is set to null)

Changes since V2:
  - Check lazy init succeds in asus-wmi before setting register variable
  - make explicit check in asus_hid_register_listener for listener existing
    to avoid re-init
  - rename asus_brt to asus_hid in most places and harmonize everything
  - switch to a spinlock instead of a mutex to avoid kernel ooops
  - fixup hid device quirks to avoid multiple RGB devices while still exposing
    all input vendor devices. This includes moving rgb init to probe
    instead of the input_configured callbacks.
  - Remove fan key (during retest it appears to be 0xae that is already
    supported by hid-asus)
  - Never unregister asus::kbd_backlight while asus-wmi is active, as that
  - removes fds from userspace and breaks backlight functionality. All
  - current mainline drivers do not support backlight hotplugging, so most
    userspace software (e.g., KDE, UPower) is built with that assumption.
    For the Ally, since it disconnects its controller during sleep, this
    caused the backlight slider to not work in KDE.

Changes since V1:
  - Add basic RGB support on hid-asus, (Z13/Ally) tested in KDE/Z13
  - Fix ifdef else having an invalid signature (reported by kernel robot)
  - Restore input arguments to init and keyboard function so they can
    be re-used for RGB controls.
  - Remove Z13 delay (it did not work to fix the touchpad) and replace it
    with a HID_GROUP_GENERIC quirk to allow hid-multitouch to load. Squash
    keyboard rename into it.
  - Unregister brightness listener before removing work queue to avoid
    a race condition causing corruption
  - Remove spurious mutex unlock in asus_brt_event
  - Place mutex lock in kbd_led_set after LED_UNREGISTERING check to avoid
    relocking the mutex and causing a deadlock when unregistering leds
  - Add extra check during unregistering to avoid calling unregister when
    no led device is registered.
  - Temporarily HID_QUIRK_INPUT_PER_APP from the ROG endpoint as it causes
    the driver to create 4 RGB handlers per device. I also suspect some
    extra events sneak through (KDE had the @@@@@@).

Antheas Kapenekakis (11):
  HID: asus: simplify RGB init sequence
  HID: asus: initialize additional endpoints only for certain devices
  HID: asus: use same report_id in response
  HID: asus: fortify keyboard handshake
  HID: asus: move vendor initialization to probe
  HID: asus: early return for ROG devices
  platform/x86: asus-wmi: Add support for multiple kbd led handlers
  HID: asus: listen to the asus-wmi brightness device instead of
    creating one
  platform/x86: asus-wmi: remove unused keyboard backlight quirk
  platform/x86: asus-wmi: add keyboard brightness event handler
  HID: asus: add support for the asus-wmi brightness handler

 drivers/hid/hid-asus.c                        | 214 ++++++++---------
 drivers/platform/x86/asus-wmi.c               | 223 +++++++++++++++---
 .../platform_data/x86/asus-wmi-leds-ids.h     |  50 ----
 include/linux/platform_data/x86/asus-wmi.h    |  28 +++
 4 files changed, 325 insertions(+), 190 deletions(-)
 delete mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h


base-commit: 2ccbdb612d0d95f25c38189b83666ff0fb2bfb47
-- 
2.52.0


