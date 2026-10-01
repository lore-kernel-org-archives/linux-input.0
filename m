Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF2376483
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893426; cv=none; b=gd70tpEs5IfkQOf5MglWGhJd974cyLsBuKGG7kLCWkUouVuF5llY8jKpyMokypItTxDn5Zjdj9OR5pZbS/fPCz9l1V5XdAWxw94wjjH0iv2vuySC99kHvkHJD18C00dGhx+Gut5azhdxOpI29ib94zQRh751wQ2UwLBnrkccQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893426; c=relaxed/simple;
	bh=mYU0svSnfzB3erw1GhulDfxdQe7HII9Himyq/LKdwWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rF05hEo7x5Nl7DZ5g/KjlFONKwjftAbpqcRM008Ja9DvCjJSuQs+OmV4lerNwyrurVtz49vqil3DPLP0pqP/+xSo1Ny1saDJunaBd9G2bpeRSKyfOPf4YsANPTETtN4fYGi/ywGcXl299w/qBOtyWpzo+E8S42TP4ywqfO+6gF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcKZmerM; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcKZmerM"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19959791so3208135a12.3
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790893423; x=1791498223; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VXS32F0Rce0o7RoG3p8pF3LK2S/LnFEZJXBeGjqi9eA=;
        b=UcKZmerMkQg+K3Y9aMhPEkUDOIvifxQEnZUb1xuqYbE7/p2gDGTAIxx+/4BB4aPgub
         Zl+Vms0YNfrJJbmFY0r7ssbqXGuXjvoyGm2MR9fcYb7UVtXKKI9462XuC72L+erCvlmn
         dK8cH7iSVW6MeM8mjjzMIlbQRNX0oGoMEJduYcYdpWD3jOvu6oORiBFroyDfq/mwiy9I
         0LIAfB9ieVmP3l94Ah6KPmO1ecnXFgDNCOhnTEryc5mtxhXyhw4VR/NqtHWPPNIKeMxp
         shUOHVtf6AJOasasFIxVm11X8il0foZDkUurpAVua6wMbO00aqP/9fA/+yavxmaZbeoe
         Q/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893423; x=1791498223;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VXS32F0Rce0o7RoG3p8pF3LK2S/LnFEZJXBeGjqi9eA=;
        b=IS2G6T6EAHZV5i2FIjum2kLcozGkQpjCsuWzQDqACJcBDuMfXy97ap/4lpbV5dpVYM
         geHnPNAA/RYFqIV4AUbT6GupckurEBmU+A5xlayIw7tJCoWWxCYY29y4w3IfUmMGCQan
         Ty8jwiR4dmysy708XQJTGhWg90sUQWZBMcExd2b2Pw2bv6Kjj7GS/A40ab4zttqiGMCJ
         U8SkiSlJqZQQeRFSWvwliLBwEDF363mgKHh+hC04vLxreYOb/5gOgIZnPvFFHuGItk4i
         vkOcUsbSaNyWj3I3hpXICBQz1u4EV8V+4CNuh7yiq6xuwryGXps4PCAi//KoMSd4SIg+
         Xn2A==
X-Forwarded-Encrypted: i=1; AKwUvBzh8hW4s+6X3so0O0uqpp69A613tXh9f5M6Ap9ka8i9uyTAf6duq6iAXcgfKPWtf3Uavxgiz4YpSJxylg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKajU6XWoAVfeI4O4oVVwmM9ABbiml8B8EifjbwZ6dytVZrTvgT
	2+yqde/NsZmDkIY6B/B0nceoh4AEzOdUdLp0LFTPdqX8CnUidGu8/4do
X-Gm-Gg: AYBFou24X6X0Tjgs1+pJ8B/Jieczhin0SJCOQOebkjNoXV1CMotrIgnGSNJnF4BCckE
	xP9I77OZcV0lVBrQUm5MYJXijzG8PHGlFe8mdMnuYy4ieYI+T2n4GrDa6LUrGPNFh3jAq2uVwQw
	CO1n/gwBD198BWrcHla0kcWFZjqlOApr+PUbgUbT9T0Dcw376x1Bs81VbSBa0zIH5ItynAadzIH
	Ky4J/ZVyNLPsQatdiXZj/IFh7Ld70fff9fnt9VOxgIvo7Mne0q8M1XuBIqrMTLJZcThR1b/KVtB
	m9LgjI4BLcOyd3cO630VELcNXI5T1GqJjLwQ+s3Zj4D/hfgWzUjaPTlP4nQsbU1b9Td1lup6oNr
	xTIedTUkRuQRD83g4KbklP/ay62i3zbsGfk0KckZpScQs0h9ej0sw1b3LD8Olwl2c7c1VcOs4Fz
	aSMYceaSD9dGdxs6iJilzb2N3g4bCMT9ZCodutWRHrmll1x9H5gkA8UHGD4wvHfHURJA/MZxw/V
	SdkV6e1xokk443eYUpi2AURSDUlQQ1G0xliQDAe+2BN
X-Received: by 2002:a05:6402:2790:b0:6ac:9a44:d404 with SMTP id 4fb4d7f45d1cf-6af9de99262mr412774a12.0.1790893422537;
        Thu, 01 Oct 2026 15:23:42 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d87399esm238935a12.9.2026.10.01.15.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:23:40 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH RFC 0/4] HID: logitech: add Bolt support with HID++ input
 handling
Date: Fri, 02 Oct 2026 00:23:34 +0200
Message-Id: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwND3aT8nBLdzLyC0hLdorRkXUtzEwszA/PkZLMkIyWgpoKi1LTMCrC
 B0UpBbs5KsbW1ABlipOVlAAAA
X-Change-ID: 20261001-bolt-input-rfc-9748607cc6b2
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bastien Nocera <hadess@hadess.net>
Cc: Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790893419; l=8027;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=mYU0svSnfzB3erw1GhulDfxdQe7HII9Himyq/LKdwWY=;
 b=e7o2aIRBrR45FSIy/M9EPXqtUv1wvSbQ9G5166WySvyAVmtGFSPpgknENYgTrMiG1EhRw29Rf
 gvqOe/NPX0DASH4nntIESMmNRzI1hvSnElRxCnrfSNZcyT0JDu+3mKU
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

This series is posted as an RFC for review and hardware testing since the
previous patch had some issues and had to be reverted. It is not ready for
merging pending testing and discussion of defaults.
The series adds Bolt receiver support to the Logitech HID++ and DJ drivers,
with revised native input handling and HID++ wheel diversion.

Original patch: https://lore.kernel.org/linux-input/20260712003051.338194-1-erikhakan@gmail.com/

The original approach failed to use the correct descriptor for the virtual
Bolt mouse device, which may have caused mouse reports to be incorrectly
interpreted. In an attempt to fix that, the second approach was to not let
the DJ driver claim interfaces 0 and 1, and thus let the generic HID
handler handle native keyboard and mouse reports. This had the side effect
of incorrect scroll scaling for 0x2121 (hi-res scroll) devices, and
attempts to fix that caused various side-effects, especially when used
together with user-space settings for scrolling.
Attempts to fix everything failed to account for the fact that we were
treating Bolt devices differently than other non-DJ devices.

Further, some attempts of fixing tried to rely on storing user settings
on-device, but these do not seem to survive reconnect or turning off and on
when tested in the Bolt MX Keys or Lightspeed G502.

This series aims to fix all of this, while also preferring HID++ reports
for Bolt mice to allow for device identification, despite the fact that
Bolt receivers do not support DJ mode. Regular mouse and keyboard events
will still be native HID events and can't be identified per device.

- Handle Bolt mice the same way as e.g. Lightspeed mice are handled, i.e.
  let the DJ driver claim interfaces 0-2 and use the existing 16-bit mouse
  descriptor for the virtual mouse.
- Fix diverted 0x2121 HID++ wheel movement, including resolution and
  software-side inversion when scroll direction is inverted. Also, handle
  both low- and high-resolution reports coming over HID++. Bolt devices
  have HID++ diversion enabled by default.
- Add HID++ 0x2150 thumbwheel handling, with device-provided scaling and
  direction. Bolt devices have HID++ diversion enabled by default.
- Extend the M650 Back/Forward diversion quirk to devices connected through
  the Bolt receiver.
- Add HID++ 0x2130 ratchet-wheel handling. Bolt devices have HID++
  diversion enabled by default.

HID++ diversion supplies a device index, allowing supported wheel events to
be attributed and scaled per device. Ordinary native mouse and keyboard
reports still lack that index. Their source remains ambiguous when several
devices share a receiver; this series does not solve that limitation.

Non-Bolt wheel-reporting defaults remain unchanged, however the 0x2121
general behaviour has been changed. Instead of first setting
high-resolution mode and then attempting to fetch 0x2121 capabilities (and
thus scale) from the device, we now get the capabilities first.
Previously, in case of failure to fetch, high-resolution scroll reports
would be scaled as low-resolution, or whichever scale already existed. Now,
if we fail to fetch capabilities, we request low-resolution native HID and
set the scale to 1.

All settings are applied at device connect (or driver load), and userspace
may override afterwards. Solaar is known to apply its settings a few
seconds after the kernel driver is loaded for a device.
Userspace changes to wheel resolution, diversion and inversion should now
be handled correctly. These combinations still require hardware testing.

A risk with this series is that for testing I only have access to an MX
Keys for Business over Bolt and a G502 over Lightspeed. The series has been
tested with both and works as expected, but it needs testing with as many
devices as possible to ensure none of the previous issues remain.

The following items need to be tested:
1. First and foremost, the 16-bit descriptor finding was based on looking
   at the native descriptor from the Bolt receiver and not something I
   could test myself without a Bolt mouse.
   Hence, just regular mouse movement needs to be verified with a few
   different devices.
2. Further, scrolling with a 0x2121-supporting device (i.e. high-resolution
   scrolling) needs to be tested with Solaar set to all four combinations
   of HID++ diversion + resolution, and all four combinations of HID++
   diversion + scroll direction inversion.
3. MX Master 4 thumbwheel (0x2150, or any other mouse with this), diversion
   on and off in Solaar.
4. M650 Back/Forward clicks when connected over Bolt.
5. Ratchet wheel (0x2130, I think Signature M650 and M750 support this,
   from issue reports online) with diversion on and off in Solaar.
6. For all devices, testing so everything works after turning off and on,
   after reconnecting, after reboot, after switching to Bluetooth and back.
7. There was previously one report of scrambled keyboard input for a Logi
   POP Icon Keys when letting the keyboard interface be claimed by the DJ
   driver. This issue was never traced to a root cause and may have been
   unrelated. It has not been replicated on MX Keys. It should be retested.

Besides testing, a few decisions need to be made:

A. Currently, no HID++ diversion is enabled for keyboards, but at least MX
   Keys for Business supports diverting some keys over HID++. These include
   e.g. media keys, brightness control, etc. Some proprietary keys ONLY go
   over HID++ and do not support native HID at all.
   However, the use case for diverting only some keys seems small. Without
   diverting the entire keyboard, it can't be used for e.g. separate
   layout, or remapping all keys on only one keyboard, etc. The only
   possible use case is for special treatment of only those few divertable
   keys.
   However, the downside is that not all keycodes map to native HID
   keycodes so a list of all diverted key mappings needs to be maintained.
   Further, it might interfere with keyboards that support reprogramming
   keys.
   I could add it anyway though, either in this series or in a future
   patch?
   On the MX Keys S, a few keys seem to only work when diverted, or are
   diverted always, such as FN lock, mute microphone, backlight up/down,
   etc. These HID++ events currently have no handler in this driver.

B. Bolt devices now default to diverting the various scroll events to
   HID++. This is to be able to separate those events by originating
   device, in case their settings or support differ, so e.g. scroll
   resolution scaling will be applied correctly per device, instead of
   scaling different-resolution devices according to one device's scaling.
   But the use case of having multiple mice on the same Bolt receiver is
   rare, and perhaps it's better to let Bolt devices default to native HID
   and let the user override with Solaar if necessary?

   tshark captures of a Windows guest using MX Keys for Business suggest
   that the Windows driver enables HID++ diversion for keys, but this is
   not verified for mice.

Finally, thanks to Rafael Passos for the original Bolt HID++ wheel-event
work. The related Magnetar-OS patches were also used as inspiration:
https://github.com/Magnetar-OS/logitech-bolt-hidpp-dkms/tree/main/patches

Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
Erik Håkansson (4):
      HID: logitech: add Bolt receiver support
      HID: logitech: handle HID++ thumbwheel reports
      HID: logitech: divert M650 side buttons over Bolt
      HID: logitech-hidpp: support ratchet wheel

 drivers/hid/hid-logitech-dj.c    |  33 ++-
 drivers/hid/hid-logitech-hidpp.c | 471 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 464 insertions(+), 40 deletions(-)
---
base-commit: d72f75f1d9c038ead2588b42de6c2531e3b80bea
change-id: 20261001-bolt-input-rfc-9748607cc6b2

Best regards,
-- 
Erik Håkansson <erikhakan@gmail.com>

