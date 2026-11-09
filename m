Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794264691;
	b=oqCHAcYS6Jc3p11Brlz+RWnI07pzubMx5q8nh2AUV+1kKmQeiSuU2XHi7uv4LZVR1qjk
	 zNWVTnqdQX3nhHiC9B1OEKE29WHE9zFHSXVp9/+pI5YexO4Yp92nLNwfJIDU64HQX72OY
	 KJ3dgVHGB48Ib0g1M7ZxCxs8b3Hy3lIbXGmhYzPHRKKNRyB692vdbilZ2yUnfaJVTHmBH
	 rkdoGCB+u+qum4fskS+fMGQl2ei0bf8tqq0w4nkeXURu2wn70Q+AfTy697wziLjFNKW8a
	 EX4Mm92Uc21fYDV4+BG62iK1+NyqYAuUu68casB8dN28glPzBLUdfhJbKK5QkbRAxNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264691;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=MF9+4JbDxwhbh3Yo3CPaVznSLLqfurhBxXLY/WW8ZNM=;
	b=XYDyqdfXByJUeyqSsUpBetRkox8ZFyKm1jMdVN1nBttdxqQ3TWgUXNbUZvNy/pg8kNLA
	 XIJsBEeLBZns0Qzd+SmBOyOX9H+vvdlpUcy1oaBd6P0egH2OoI6RMfN3ZAdznnv9V8YQX
	 dzSA5YH9Jycb4CDTlCYlYVMzBVXskAyxYMljD39N7vJWLC0mPujqoHmkuNgYtRgmo0qP4
	 dnhupQc+WV4UxQOAtA9GO6waqNUwC0ZNqslA9aHj9I+4sYQBTjN+a9M5ec0+JNhYlqsXm
	 WZO1bJ5gb1aW5KbygaibhDn5tSi8svPHGZOHjvo0GtVftdShQ6PBcHKe6y0YcmyMiDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dgy8kXmk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52082606A332;
	Mon,  9 Nov 2026 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dgy8kXmk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794264691;
	b=AQwzHLy/RrjzyXG66n8cpV5pYtMZXb7aUTt3SRcevTno5Rt94lg+ld2v3CTgzEsLaUbV
	 8GQwW1l0wJk/0eF07ydeNk54OWjIrX87MEgc4DD3vpfjdrA2unBue88CWJL7nkhTwT0bR
	 5tiuDm8TbgW1pUlWhu+UVoDgraiJvBShIsyvZWN/WS4Xw5yufAUli4o7UQ8YjayxwYumw
	 dSSs6Z2XhXYamF6SwpTUMtsCPm8/tyT01eFuVRby+j0DqzsgzAnhdwXuhA0V//NYaViH4
	 PYwPUh8Aj8IXXQtY97tlAoraaaU3kZ/3XrFvsUTfv7BrERtqTy6/X05iHpbQ2H9tFGw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794264691;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=MF9+4JbDxwhbh3Yo3CPaVznSLLqfurhBxXLY/WW8ZNM=;
	b=oJL/UDW3W61GTl8kRIBS/YLrWJnszvjupSyvQVhoik3H/FNwlBpfkTxmLQppREnbbqRd
	 wEd/qiA/RMaIRrYDo/Z6e194s52sgECakwq5Wi2W2EAMFAq0B4XQ4Ft0cx24CDVclzo77
	 5gPTOB5MPs9p3MnljVN3hABLqRCXtOoKEBwZDKsd7fIiOuVlGpRQ3hTGH2u1WhpgE/QOq
	 jq3q3dRdrVQ++48n0Dk3KyNGrFhXISlo0m4elKFSg+G6zeLdy88j5v9+695WekJ4ZVX8x
	 c0EojQFVxF4weLICMjuN9uTWyYYSJMr30BaJFvCBy4iTsf20uUINz1dU2TK02CBafMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9A93F1F0089F;
	Mon,  9 Nov 2026 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264690;
	bh=MF9+4JbDxwhbh3Yo3CPaVznSLLqfurhBxXLY/WW8ZNM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Dgy8kXmkCbyL1jbHC8co7LIQE555OjEzxeu041aFFfG01kN2JuGURACBxYKa/mOml
	 xTvGWgYjnqPYBfOTE2tj2lqbyPnxU2mFxWSCNrrJJEO+YZDs3Xv9po6XSyfjZDc4Sv
	 eJK6hLN2EDd+5vTmXV/WotDjbpdVU2HQutACFrPiCgG3M70FflqAZnrPRnqFFasj+d
	 uI3xwAeWK820soprTsps4OCfW2hvv2yf+uBMCJzmNSk1JVAocBLrhGlCOwl6ECHNln
	 FBr85LL+xNxLGcAg1+jXv4u4RoTYa37wdhPC+5P35MZ8aq9ox4qq2OIj9HAkhSBw4j
	 gRw3DwY5aqCyw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 144DF486CF;
	Mon,  9 Nov 2026 22:51:29 +0000 (UTC)
From: Ciro Pedrini via B4 Relay <devnull+ciro.pedrini.gmail.com@kernel.org>
Subject: [PATCH RFC 0/2] Keyboard lighting for the Lenovo Legion Pro 7 Gen
 10
Date: Mon, 09 Nov 2026 22:50:20 +0000
Message-Id: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQrCMBBFr1Jm7UATaUG3ggdwKy7SZJIMlKlMi
 hRK7+7o8n3+ezs0UqYG124HpQ83XsTAnTqINUgh5GQMvvejc/0FZyp2wZlLXVkKao6Y4tm7cUh
 58AnMfCtl3v7VJzzuN3jZOIVGOGmQWH/BvCgKbSscxxfMPDwlhQAAAA==
X-Change-ID: 20261109-legion-lighting-rfc-dc32165df52d
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Rong Zhang <i@rong.moe>, 
 Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, 
 Aaron Erhardt <aer@tuxedocomputers.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Ciro Pedrini <ciro.pedrini@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794264688; l=4129;
 i=ciro.pedrini@gmail.com; h=from:subject:message-id;
 bh=NVJmw8/xUXqWPd+UKqSe+SQ9Beve4dYcB85vbCBj+pk=;
 b=XJ/ql3sKNq4B/mbUrZoZbODwcOHmfXH4WZOHZhVvUNZQbZ1YAvAvmcHcP9302GE+oOZrB/y4m
 g8bVpugl+cNDnNCNP7IQYhLF2x3mqF1nPOtj9nukFshTTlUec19Mrve
X-Developer-Key: i=ciro.pedrini@gmail.com; a=ed25519;
 pk=TOSFlPBon1xBHfTrhODxatabgwEJdgKEzG3jMoMQcbc=
X-Endpoint-Received: by B4 Relay for ciro.pedrini@gmail.com/default with
 auth_id=1468
X-Original-From: Ciro Pedrini <ciro.pedrini@gmail.com>
Reply-To: ciro.pedrini@gmail.com

The keyboard and chassis lighting of the Lenovo Legion Pro 7 16IAX10H
(2025) has no Linux support today: on my unit nothing ever lit, because
the keyboard controller's brightness was 0 from the factory and nothing on
Linux exposes it. This series makes it a regular keyboard backlight.

The lighting is two USB HID devices:

- 048d:c197, the ITE 8258 keyboard controller: the built-in keyboard,
  plus a vendor protocol on feature report 0x07 (960 bytes) with a
  hardware brightness (0..9, stored), the controller's own effects
  (stored profiles), and a switch that hands the LEDs to the LampArray
  below (also stored). Fn+Up/Down/Space are handled by the controller,
  which reports the result on a vendor input report.

- 048d:c193 interface 1, a standard HID LampArray: 319 lamps (keys, front
  strip, rear vents, lid logo) with positions and key usages. It shows
  nothing until the controller hands the LEDs over, its colours are scaled
  by the controller's brightness, and after resume from S3 the kernel
  resets it and it comes back in autonomous mode.

Patch 1 makes ideapad-laptop ignore the EC's copies of those three
hotkeys, which reach userspace as KEY_UNKNOWN today.

Patch 2 adds hid-lenovo-legion, binding both devices: one multicolor LED
(<name>:rgb:kbd_backlight) whose brightness is the controller's, with
brightness_hw_changed from the hotkeys, and whose colour goes to every
lamp. lighting_mode selects "firmware" (default: the controller's effects;
the driver leaves the LEDs alone, so a userspace tool can drive the
LampArray over hidraw) or "color". Per-key control stays in userspace.

This is an RFC because of its shape: one driver spanning two USB devices,
paired by their USB bus. Is that acceptable, or would you rather have it
differently, e.g. a vendor hook in the generic LampArray helper that Aaron
and Werner are working on ("HID: generic: add LampArray support", v7),
which on this machine would register a kbd_backlight that does nothing
visible? The two patches touch two subsystems; I'm happy to split them.

Tested on the 16IAX10H (83F5, BIOS Q7CN77WW, Spanish ISO keyboard) with
7.2, as modules: brightness from sysfs and KDE, the hotkeys' OSD, colours
on every zone, suspend/resume in both modes, a userspace LampArray client
in "firmware" mode, unbinding back to hid-generic. The series is based on
v7.4-rc2 and builds there with W=1.

I worked out the protocol from the device itself (usbmon captures, the
LampArray's attributes) and from analysing the vendor's Windows software
for interoperability. The patches were prepared with Claude Code (Claude
Opus 5.5), see the Assisted-by tags; I reviewed and tested them.
checkpatch reports those tags (non-standard signature, no email address),
and a MAINTAINERS hint for the new files that patch 2 already adds.

To: Mark Pearson <mpearson-lenovo@squebb.ca>
To: Derek J. Clark <derekjohn.clark@gmail.com>
To: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>
To: Hans de Goede <hansg@kernel.org>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org

---
Ciro Pedrini (2):
      platform/x86: ideapad-laptop: Ignore keyboard backlight hotkeys
      HID: lenovo-legion: Add keyboard lighting driver for Legion Gen 10

 .../testing/sysfs-class-led-driver-lenovo-legion   |  20 +
 MAINTAINERS                                        |   2 +
 drivers/hid/Kconfig                                |  13 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-lenovo-legion.c                    | 662 +++++++++++++++++++++
 drivers/platform/x86/lenovo/ideapad-laptop.c       |   4 +
 7 files changed, 704 insertions(+)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261109-legion-lighting-rfc-dc32165df52d

Best regards,
-- 
Ciro Pedrini <ciro.pedrini@gmail.com>


