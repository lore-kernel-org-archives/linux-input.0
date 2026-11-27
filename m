Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795741898;
	b=ZT2ZVBsgBFHkSi3Cg4LGdQoAT/2HyZsNuICFj52LzHHQpRYfCDjVXSDyei/+i38nCz9F
	 /IwEifZJ3v9etDypOzr4ZWXa5hToT5tiTrOSbbKj6wybwGnXSWAL5u/8rx7Z4zr1gBHwf
	 jAT7kuQ7WomSrNR5e+zmOY7bS31OGX1jJQ+YQxT2NjJ8sjd0PJbHJutbrBNi5UPDugvSl
	 VpOSfo4MxhJu/lqREbh7y2zOmE5m8GocgTgYHxAEFV/JDoBCL0Nav41V5WjZuA4NWit++
	 7eKgc3jTgFkaUAShT8jI+9c5Bglq2bUTTF5X6CYqem/0tC4AmxTofmeDUoM9/DTuPmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741898;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=I7wd8YBab4NQRi8qk+9Nq5Hm+sqxsp5LHKtCHvf0z00=;
	b=33BDY/1sllM/pNM0Cao8elv119S7Q/qvc+Oof+r23zCUv6aXVaBRnljJjPD2eJo3Epbh
	 i8EIWdyBulnXMiR4UhRs1kVK5htw5Ybi8zwXSic8peRIONTCV5GEdxuAtCrvX8RUKQyxc
	 7/zcPWwLa3EF5d5pS5DbD2IarPDOiuseKnQId0UAz2rn5Kkx0JF3WxqYQd3O59vfUeO2J
	 kmKg9mRJP7FsT8vCHimjMevYrMCmolefnHlTfTrH1t51yKf4BokDQ/Tw+nzsZCJ0zHflA
	 7HRqLodEPbQJv8EbfwU88mTSQCkVPDaT2rIZ2xYOGAzE82IAHXQ87tkdyTOa0Cu0ZLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDk+kIQW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D026606A31C;
	Fri, 27 Nov 2026 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDk+kIQW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795741897;
	b=UTvkWFvHa/NuhrpGw2g69euX2GDwK/oDw9Z3Ssf2Qtl2nwgR7J0TSBomTcIt1YacIsMr
	 fMZaDALZibY06ay5QzICuvWi9tQT3gU/StOiwgahI1pew/IL1QD+PI92ECNVSM9iRx8C4
	 Ttk0tM7lPIUbHcgS/lJGORZMk7Okfj+hmrahqReo+KEPnKMRuqr04ZrRR8is+dZuhSRIq
	 qTWnApUM/oRqG1IzBD7UPUS8sswA06OH1zf2IhTV4nT+/WCkGI5jpIwagKZT05lQkFPaF
	 8366zz5OolU3su/mlyUJZV6bTob2iyrkclJ1ukZbFpU8NMjZS+1XLqiHD1HQ6HHvWPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795741897;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=I7wd8YBab4NQRi8qk+9Nq5Hm+sqxsp5LHKtCHvf0z00=;
	b=Cr1L8gV90HDxAom2gTOI+iJtfAG+oDUczTlppBptv3FfwPiNnX6fdVlOhRMJFMZTqei7
	 eHZ0sQ81DaBsB9R7ObmfrK5BLd5pjEW1UgC5c8Ozpt6ZZngFWRHKrCNGrzIjjAIfSNQqc
	 OZQts3S/oFjQe6slQgxummAXbIXFCEFUXCwjZmMkvcYnutvjkzrdD345YrJdIKZuWPScE
	 /iisY1tJ4pgBoF8MbnLgyHl2wwnqxUONZdCJSuwmredgSmY6Fa31TDcNs9ReV+EnklKiw
	 HJsCq08pY5JpdmkDzrKwrZkQ513cyv+mQJOrVhNehb9SZIJwJay2ARuVhwfCX6L5O2A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3F79B1F00893;
	Fri, 27 Nov 2026 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795741897;
	bh=I7wd8YBab4NQRi8qk+9Nq5Hm+sqxsp5LHKtCHvf0z00=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GDk+kIQWCvjnlX3jPrJgaCTz/koNoGNgHqR1WAXSZ5WRk+yZO+lsgSDAUGWZJEgHd
	 BeNkADDJXjUnn7ob8VfEjG9zUKVHWGZdINGALJ/wgXwpWeaMgMPKBI25D2rhAvc4OI
	 2J9hF9z+50BEpAZrlvwLHQpNxiB76/cmaVZ75Ew5d9KI9iWJbqOvYw2wKUcSSTZqho
	 NzFPLGFMOh0838lfXREs89+gAAXDU5Pc9Hr2Ws7hq1wS/UJu/FJR+PVFttt1V/8M0O
	 J3yp77luvuJbXsoeolXVEqT2Aaw1W6RYHdPHtwventStaTQzAAH8FckCUedAnzttE8
	 gbjQArgv0lQfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B2EB34B4CE;
	Fri, 27 Nov 2026 01:11:31 +0000 (UTC)
From: Ciro Pedrini via B4 Relay <devnull+ciro.pedrini.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] Keyboard backlight for the Lenovo Legion Pro 7 Gen
 10
Date: Fri, 27 Nov 2026 01:11:10 +0000
Message-Id: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf8V07Rha5KEr/8O46GNaJoFiWkIwh
 H+3ZcXCuDzJveesLGIgjOx+WlnAmSKNPkF5PjHdSe8QyCRmohA158UNenRpAj25biLvIFgNRpe
 C15WxlTAsPd8BLS279flKrGREUEF63WWXHQN4XKY87ShOY/js/Znnw//UzKEA2TbIjWp1heXDD
 ZL6ix4HllOzODh48dshkqO9Vo2opVUN10fHtm1fdWPvVRUBAAA=
X-Change-ID: 20261109-legion-lighting-rfc-dc32165df52d
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Rong Zhang <i@rong.moe>, 
 Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: David Cemin <dcemin@nvidia.com>, 
 Werner Sembach <wse@tuxedocomputers.com>, 
 Aaron Erhardt <aer@tuxedocomputers.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Ciro Pedrini <ciro.pedrini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795741890; l=4542;
 i=ciro.pedrini@gmail.com; h=from:subject:message-id;
 bh=n6ZZHbFpHE2QvKDfMUFjU+60/18Xn8WyvZbla0npvuc=;
 b=vxhfV237oYB+dNCIQjpJPLLNEofcL2OcjPFdsTSxVwtr5bEb9ROmcQ35OLLikzcK7R9bx3Kw+
 bAYIFaVYljZAaL+FI/buQs6OOvsAJP7UAb+boBng+SQXXummh+Du7fP
X-Developer-Key: i=ciro.pedrini@gmail.com; a=ed25519;
 pk=TOSFlPBon1xBHfTrhODxatabgwEJdgKEzG3jMoMQcbc=
X-Endpoint-Received: by B4 Relay for ciro.pedrini@gmail.com/default with
 auth_id=1468
X-Original-From: Ciro Pedrini <ciro.pedrini@gmail.com>
Reply-To: ciro.pedrini@gmail.com

Hi,

This is v3 of the Legion keyboard backlight series. It has the changes
Ilpo and Rong asked for on v2, and one fix I found while testing them.

Short background: on my laptop the keyboard backlight never turned on
under Linux. The keyboard controller (048d:c197) stores a brightness from
0 to 9 behind a vendor feature report (0x07), it was 0 from the factory,
and nothing on Linux could change it. That brightness dims every LED of
the machine. Fn+Up/Down/Space are handled by the firmware, which sends
the new level on a vendor input report.

Patch 1 stops ideapad-laptop from sending KEY_UNKNOWN for those three
keys. Patch 2 is the driver: the brightness as a kbd_backlight LED, plus
brightness_hw_changed for the hotkeys so the desktop OSD works.

The fix: while testing v3 I found that the controller sends the same
"brightness is now B" report after every brightness set, the host's
own ones too, and also when the level doesn't change (Fn+Space sends
it as well). v2 passed all of those to brightness_hw_changed, so the
host's writes looked like hardware changes. v3 only reports a level
that differs from the last one the driver knows.

David: patch 1 adds three KE_IGNORE entries to the ideapad WMI keymap,
which your "architecture independent home for the Lenovo WMI drivers"
series moves to wmi-fn-keys.c. Whichever goes first, I'm happy to
rebase mine on yours; it's the same three lines in the new file.

I tested it on my 16IAX10H (83F5, BIOS Q7CN77WW) with 7.3 as a module:
brightness from sysfs and KDE, the hotkeys and the OSD, Fn+Space,
suspend/resume, unbind and rebind, and the vendor report on the wire
while doing that. It's based on pdx86 for-next and builds with W=1.

About how this was made: I found the protocol with usbmon captures and
by looking at Lenovo's Windows software. I wrote the code with help from
Claude Code (Claude Opus 5.5). I went through all of it and tested it
myself, and each patch has a short note about it below the ---.

Thanks,
Ciro

---
Changes in v3:
- Short reports: send only the request bytes and read only the answer
  bytes, right after the request; no more 100 ms wait (Rong).
- The buffer is allocated per exchange. Not on the stack as Rong
  suggested: usbhid hands it to the USB core for DMA.
- legion_raw_command() and legion_simple_command(), and the request
  length checked against the 960-byte report with a static_assert
  (Rong).
- Out-of-range values and failed reads return errors instead of being
  clamped or replaced; dbg messages, no hex dump (Ilpo, Rong).
- devm for hid_hw_start()/hid_hw_open() and the LED; .remove stays,
  empty, so hid-core doesn't stop the device twice (Ilpo, Rong).
- Dropped the (int) casts and the "(2025)"; comments trimmed, the one
  about HID_QUIRK_INPUT_PER_APP now says why; Kconfig help about what
  the driver does (Ilpo, Rong).
- New: only report a level change to brightness_hw_changed (see above).
- Rebased on current pdx86 for-next; Rong's Acked-by on patch 1.
- Link to v2: https://lore.kernel.org/r/20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com

Changes in v2:
- Only the keyboard controller (c197) now, as Rong suggested. No
  LampArray, no colours, no lighting_mode, just a kbd_backlight LED.
- Ilpo's comments: struct with __le16 for the request, guard(),
  devm_mutex_init(), no magic numbers, includes.
- Removed the "ready" flag, its spinlock and the work item. raw_event
  can't run during probe/remove, so it notifies the LED directly.
- Keep led_cdev.brightness in sync with the hotkeys (from the Sashiko
  review).
- Moved the note about the AI tool out of the changelogs, below the ---.
- Link to v1: https://lore.kernel.org/r/20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com

---
Ciro Pedrini (2):
      platform/x86: ideapad-laptop: Ignore keyboard backlight hotkeys
      HID: lenovo-legion: Add keyboard backlight driver for Legion Gen 10

 MAINTAINERS                                  |   1 +
 drivers/hid/Kconfig                          |  12 ++
 drivers/hid/Makefile                         |   1 +
 drivers/hid/hid-ids.h                        |   1 +
 drivers/hid/hid-lenovo-legion.c              | 293 +++++++++++++++++++++++++++
 drivers/platform/x86/lenovo/ideapad-laptop.c |   4 +
 6 files changed, 312 insertions(+)
---
base-commit: 61c0dac952b9308884936d05cce97565a5c89af4
change-id: 20261109-legion-lighting-rfc-dc32165df52d

Best regards,
-- 
Ciro Pedrini <ciro.pedrini@gmail.com>


