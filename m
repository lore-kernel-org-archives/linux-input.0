Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342679;
	b=L7vwcyoZKa4FPGtxtwtZ9djbDLIVEdrid0dYQbiAmwhlhCXox3vPOeCQhiUP0z7aRr+i
	 Lx4jdGvcwodN612XHmmuIsfcF4PHZqKkQh4fKTN2B+Le+8CHOpEkGQYce7iWKEMtaAGbG
	 feVunV5veDXh2OGwF6jOKmfXI0+q0+vXsBplkdK1qgtfHtkdrut49/h0/gorIEHWl9ouQ
	 2jXQrGvKcw8sqNa37K2fT8wfz/wujWXRqKz9ERzuU0maK9spkmpPuKOxPiLJumqIIGxzv
	 0L6j43iVdh+JbfOjteh1CVghT3sgDSQ1dIknm1MMcFkfxnFaU0oRnsztgKdRk4jMFIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342679;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zznmRQSjiOQqd1nprCfwqdoGiMIj2eneIkVZQBbIceo=;
	b=hASvdMGyqMvEUTvUqp+KIpswgWG5LbgqEwkraHs3cwr+Rkl3iDqM9s2Ik+tmdLCnscAT
	 GUpI3bIglEK4JDgRe0WNqY+tfKSdqCCFozG5wDQWmb1BQVp2gbAwcmK/74fq29FRy0UQQ
	 fc7cqWG2EkkVBprczKWsbluQbpsq1ucvL/rhZefvABo4ERSJ5daXjWGavt+bTR0quFYbc
	 AXluuoYBloiQe2zz73H1hh0mOhwErmL6Oa7zjjrx3f9Og9HZSaac7FMxpTdble+4h0i4V
	 QH58fEzirWwB/2PJwkh5L/QAFajGREKZWGXpastoOriHu1gAHsbfFyO1j/0E27WwOcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZ9pNlak;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA51606BA67;
	Tue, 10 Nov 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZ9pNlak
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794342678;
	b=VP5N2seFHIt2G6BmC8LUqMfqXt6tk/aNTLQf5hXJ35MtL8g0DMtSmQ0Gs8h9q5QJDFuw
	 MC+1/h8LkFpob/sTTP8CXbGkKs3Nvq15DtHaIZzQfRZBoXpBx8tQmy3MeykYPUjnXq6JD
	 7hw4/wlKVxmgk72bA7trgu09y35GpNZhX7AswOf9ktUZ7aZKGf9zXoGU5XoSEWGiuJff1
	 hysFDtZhFuz8IEmyewe91nYyakW+gsu+bUqrKLxFjcmEmH4dUG1ho1feET5uYEfMV+Lt4
	 bSbqoj+VPAus07/Wscyxd8egqV6L+tlCU+0vICCZcGHnDBy+Ts9xunumaHwLXg/GH8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794342678;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zznmRQSjiOQqd1nprCfwqdoGiMIj2eneIkVZQBbIceo=;
	b=pNdjSqxkYOCij1RyQxIEE9FklxJh7+SdtcYDla/fvYLtXaqagdepDv0vXLCqs/P0aKHL
	 haR/lPz7JQdQWZB4fjAD3zISrsdtYyyhHvG0mmmMY1iISW6MAv+AcU8+Ou974pOF1bv/O
	 t0zLMJEyzBHcQtha0YHdsSbJNM3eEpnpwBfwnWRZMeH+fo2kQ2wXsiQ+0Jro7aFL8Plln
	 4GueX6RkcdI3O8G/6lZXhIVebOEE+7QGS/5aitGvLUNhdtks5sOwc0ChEVKFYsxOH0XBA
	 PpvKEW38MrA4hYljNOzojrtHQGs9BAuTD9lqoe41AbLbGE5hoz2JulbN8lZSO+MLqcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BEDC1F0089F;
	Tue, 10 Nov 2026 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342678;
	bh=zznmRQSjiOQqd1nprCfwqdoGiMIj2eneIkVZQBbIceo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=JZ9pNlakK5UeR00nis1NqTGR3bmnBB8o4v1vxAS5NSJVaOt1ZTY6z5TIBSsnJbuS0
	 DcpfvAinL5+CBiaKBQjPZ1IF34nDYKAA8dK5SUQGdb8f89qsXiyym2slwD7fXj+/1I
	 tVYZ6RZnV9o0EDF6K71zQEVaZNeBJkHAVC6ACpgPxS6gSLTB6i4SlQ1Oxm22AIoCAF
	 vDF0+zg0fecPPwHAeSWuxYjGTULqLUP5B46fTpu4GCtOrMEi/sZy4eF9zExZ5LiCjz
	 mvyOrRN4S2mRp5esdkVmfUbzp49QijhwtF5wHlcC54veL9za201FWJDPj71sAbopFB
	 pD5Y8kioFrkpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6CC0848C93;
	Tue, 10 Nov 2026 20:31:16 +0000 (UTC)
From: Ciro Pedrini via B4 Relay <devnull+ciro.pedrini.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] Keyboard backlight for the Lenovo Legion Pro 7 Gen
 10
Date: Tue, 10 Nov 2026 20:29:46 +0000
Message-Id: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQqDMBBFr1Jm3SkmorVd9R7FRUwmyYAmJRGxi
 Hdv9ABdPvjvvw0yJaYMz8sGiRbOHEMBeb2A9io4QjaFQVayFaJ64EiuTHBk52cODpPVaHQtRds
 Y20gDxfwksryer+++8KAy4ZBU0P74sjFhoHU+pp7zHNP37C/iEP6nFoEVqu5Owgydbqh+uUnxe
 NNxgn7f9x+LpVSi0QAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794342675; l=3251;
 i=ciro.pedrini@gmail.com; h=from:subject:message-id;
 bh=TWaA0/dEi6NcvvOs40KXYLN4ENJQ/0lyBsZMKYnlTJc=;
 b=1TcG+RN50h5+HvR6XV9fKXHJkmEs7n5isWh/z/1JzFyWu221WZpzwKh8dzpjSJeCHp69KQbO3
 2gOC/6hHMofBN9LVYtu1dDn17VgJ+EuIi27cDkI4Z1Ba53VtU2kICDn
X-Developer-Key: i=ciro.pedrini@gmail.com; a=ed25519;
 pk=TOSFlPBon1xBHfTrhODxatabgwEJdgKEzG3jMoMQcbc=
X-Endpoint-Received: by B4 Relay for ciro.pedrini@gmail.com/default with
 auth_id=1468
X-Original-From: Ciro Pedrini <ciro.pedrini@gmail.com>
Reply-To: ciro.pedrini@gmail.com

Hi,

This is v2 of the Legion keyboard lighting series. After Rong's comments
it's a lot smaller: it only handles the keyboard controller (048d:c197)
now, and exposes its brightness as a normal kbd_backlight LED. The
LampArray (048d:c193) is left for a generic LampArray driver.

Some background in case you missed v1: on my laptop the keyboard
backlight never turned on under Linux. The controller's brightness was 0
from the factory and nothing on Linux could change it. The controller
has a vendor feature report (0x07) with a stored brightness from 0 to 9,
and that brightness dims every LED of the machine. Fn+Up/Down/Space are
handled by the firmware, which also sends the new brightness on a vendor
input report.

Patch 1 stops ideapad-laptop from sending KEY_UNKNOWN for those three
keys. Patch 2 is the driver: the brightness as kbd_backlight, plus
brightness_hw_changed for the hotkeys so the desktop OSD works.

Derek, Mark: I put the driver under your "LENOVO HID drivers" entry, and
I already did that in v1 without asking you, sorry. Is that OK with you?
If not, I'll add a separate entry.

I tested it on my 16IAX10H (83F5, BIOS Q7CN77WW) with 7.2: brightness
from sysfs and KDE, the hotkeys and the OSD, suspend/resume, unbind and
rebind. It's based on pdx86 for-next and builds with W=1.

About how this was made: I found the protocol with usbmon captures and
by looking at Lenovo's Windows software. I wrote the code with help from
Claude Code (Claude Opus 5.5). I went through all of it and tested it
myself, and each patch has a short note about it below the ---.

Ilpo, Rong: thanks a lot for taking the time to review v1 so carefully.
Looking back, it was rougher than it should have been. If you see
anything else that needs fixing, I'm happy to keep working on it.

Thanks,
Ciro

---
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
 drivers/hid/Kconfig                          |  13 ++
 drivers/hid/Makefile                         |   1 +
 drivers/hid/hid-ids.h                        |   1 +
 drivers/hid/hid-lenovo-legion.c              | 261 +++++++++++++++++++++++++++
 drivers/platform/x86/lenovo/ideapad-laptop.c |   4 +
 6 files changed, 281 insertions(+)
---
base-commit: a514d723595bd8e5ce926a7fea148ceb3c26915c
change-id: 20261109-legion-lighting-rfc-dc32165df52d

Best regards,
-- 
Ciro Pedrini <ciro.pedrini@gmail.com>


