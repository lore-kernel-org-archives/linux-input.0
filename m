Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=3.73.157.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294422;
	b=uU7FTg5wdKLsxkaiKg7fXU0k1V9AG8oRRCO3Qa/EyG4OvqpkgtOr+jyIWCDGV1hXKReT
	 oBaeUclDZk9d8RLmpYny0r7s+ea3j3MDoHjxnfvTJ82RXNXNlJCz9Ccvg0aowEkZExYg0
	 VifraK9I0h1z+e1yfq4nSgEGfNJDQFzeQDhuN0+P51IjqFZ1aF9QYqvUR5t58U5dPq1qX
	 kiebWULfGNvPF0aiuWLw9jfhk1FCJbofoZG6L9BMd0BbryL2MNMEZPCCPSzNwZwMyod/I
	 doahTkfbRybBXwCzHfDoWXEHD6g8jN9VXieeiflXNbXfy7wQ01whcv9YSKESKtElQXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294422;
	h=DMARC-Filter:DKIM-Signature:Received:From:Reply-To:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=vCQ0G/m1QSXyc26BORwC76BHSw2hiWoRW1ApouraSqM=;
	b=FLHm0t2pOD1fGe9pZfWv+I/NEOTnBJobgT3VB4BstKO5sfKm2I+Tfkgs3gQ5halopUTd
	 jHwicrCaQx5MYX8BJMHPl0yLiVft42YCoZRhY5S6cNHkLIZhK8eTANjUcWwF7YIE8CJJ1
	 LilhOAgKwFRJvgVHwFLEVS7kL/rExh3ogEZWkn9lqjqqwbvjFYtIoqQiVXq2JxkJ/p3Hb
	 Q+LoUoO6Iw6NTdMDhtOVRgLWTA6c+l4Cpv5SoJxxcNyxyfUs3FqIjlJ0zH0r/36TFc5WO
	 ChAtEBmJKLxhC+1Q4AMbaRMklfOut/DrR7KYtGpEOthOm+w7TE9cshS2k+ICDOL8Aig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chvaja.cz;
	spf=pass smtp.mailfrom=chvaja.cz;
	dkim=pass header.d=chvaja.cz header.i=@chvaja.cz header.a=rsa-sha256 header.s=mail header.b=QgAB9dzd;
	arc=none smtp.remote-ip=3.73.157.52
Received: from box.chvaja.cz (box.chvaja.cz [3.73.157.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75A606A330
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F75A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chvaja.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chvaja.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chvaja.cz header.i=@chvaja.cz header.a=rsa-sha256 header.s=mail header.b=QgAB9dzd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chvaja.cz; s=mail;
	t=1795294414; bh=d9YHtVMc9VMfKbp9DQrWyR9YVjOF3fbbokyYtk6MEE8=;
	h=From:Reply-To:To:Cc:Subject:Date:From;
	b=QgAB9dzdV2+1Mjkw4Vu/hyU/+rOg5Ad3TdF/9HkEg18MSvqi1eD/kEZz/LvEB8gnT
	 iIRuGJEXN40DeDnnUKoIk2ccd96Wukgdz/ckh2KEu8uXzdZAiqQ/SPO2kfX3EK/BBI
	 4wYfZ4JHrapWb2a4rItYJzLpnfP3Ju3kkjlD2PKXPA/X2lt3FBKP/MfuxjoonXsHon
	 mcTeZsTSy2o9EkH1fffeOe39N0p3QL+Wh4PBzBf0PwIqw/wNWN8a7F/4+8HFEkhotC
	 8wVl7B5FWizV4gqQ0QATACAUfpGNkChqsl83i/379LNeLJwkb0rCxQucxAIX3PC9B1
	 H1/hNy+8xNnsg==
Received: from authenticated-user (box.chvaja.cz [3.73.157.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.chvaja.cz (Postfix) with ESMTPSA id 781F34DA3C;
	Sat, 21 Nov 2026 21:53:34 +0100 (CET)
From: Adam Chvaja <agent-claude@chvaja.cz>
Reply-To: adam@chvaja.cz
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, adam@chvaja.cz
Subject: atkbd: internal keyboard stops delivering scancodes after hours of
 uptime on Lenovo ThinkBook 14 G9 IRL (21UY); EC keeps ACKing, LEDs work, only
 serio unbind/bind recovers
Date: Sat, 21 Nov 2026 22:53:29 +0200
Message-ID: <179529440910.635175.11923305248594163087@chvaja.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

I am seeing a recurring failure of the internal PS/2 (i8042) keyboard on a
new Lenovo ThinkBook 14 G9 IRL. The symptom pattern matches the class of
EC issues recently worked around with atkbd_deactivate_fixup DMI quirks
(IdeaPad Slim 3 83RQ/83RR, Yoga Air 14 83QK, HONOR, Xiaomi), but this
board is not in that table and the failure is intermittent at runtime,
not from boot, so I am reporting it rather than guessing at a quirk.

Hardware / software
-------------------
  sys_vendor        LENOVO
  product_name      21UY
  product_version   ThinkBook 14 G9 IRL
  board_name        LNVNB161216
  bios_version      SRCN22WW (2025-11-18)
  ec_firmware       1.16
  CPU               Intel Core 5 210H
  kernel            6.18.55-1-MANJARO (Manjaro stable)
  touchpad          I2C HID FTCS0038:00 2808:0106 (unaffected)
  cmdline           no i8042.* / atkbd.* parameters
  mem_sleep         [s2idle] deep

Boot log for the controller is unremarkable:
  i8042: PNP: PS/2 Controller [PNP0303:KBD0] at 0x60,0x64 irq 1
  i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect pl=
ease boot with i8042.nopnp
  serio: i8042 KBD port at 0x60,0x64 irq 1
  input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input=
/input2

Symptom
-------
After ~2 days of uptime (one s2idle cycle in between, resumed ~12 h before
the failure, keyboard worked normally all day after resume) the internal
keyboard suddenly stopped producing any input events:

  - /proc/bus/input/devices still listed "AT Translated Set 2 keyboard",
    Xorg had NOT removed the device, no kernel messages at all.
  - Reading /dev/input/event2 for 60 s while pressing keys: 0 bytes.
  - Keyboard backlight, Fn-lock LED and Caps Lock LED still reacted to
    key presses (EC-driven), so the EC itself was alive.
  - An EC-generated hotkey scancode still came through the same port
    during the outage:
      atkbd serio0: Unknown key pressed (translated set 2, code 0xf8 on isa00=
60/serio0).
    (this e078 code is emitted every few minutes during normal operation
    too, so the i8042 data path was not completely dead =E2=80=94 only regular
    matrix scancodes stopped arriving.)
  - I2C touchpad, mouse, and the rest of the system were fully
    functional; no OOM/hung-task/stall messages in the journal.

What did NOT recover it
-----------------------
  echo -n reconnect > /sys/bus/serio/devices/serio0/drvctl
  echo -n rescan    > /sys/bus/serio/devices/serio0/drvctl
Both returned without error, device stayed registered, still 0 bytes.

What DID recover it
-------------------
  echo -n serio0 > /sys/bus/serio/drivers/atkbd/unbind
  echo -n serio0 > /sys/bus/serio/drivers/atkbd/bind
  =E2=86=92 input: AT Translated Set 2 keyboard as /devices/platform/i8042/se=
rio0/input/input23
  =E2=86=92 input: AT Translated Set 2 keyboard as /devices/platform/i8042/se=
rio0/input/input24
Keyboard worked immediately afterwards. (The device registered twice,
3 s apart, which I did not expect =E2=80=94 mentioned in case it is a hint.)

Questions
---------
1. Is this the same EC behaviour the atkbd_deactivate_fixup quirks
   address (EC ACKs ATKBD_CMD_RESET_DIS / subsequent commands but never
   resumes sending scancodes), and if so, would a DMI entry for
   DMI_PRODUCT_NAME "21UY" be appropriate even though the keyboard
   works at boot and the failure appears at runtime?
2. Is there anything I should capture at the next occurrence to make
   this actionable (i8042.debug=3D1 output, specific sysfs state)? I have
   a recovery script in place that already records IRQ 1 count delta
   while keys are pressed during the outage, to tell "no bytes from EC"
   from "bytes arrive but are dropped".

I am happy to test patches on this machine.

Thanks,
Adam Chvaja
