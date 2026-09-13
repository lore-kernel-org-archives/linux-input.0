Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C224126BE1
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789277038; cv=none; b=esFKcxaMlDME0HntDOB+6sSIuvW3Y/GgmHMXp9sOrUwrwpF3fOD44BMfVs2mgh3soYERcdCmOREVU8CyU6rV4Djzpd7BhIPwkJXmtkhdwPIBAsvIaItb8uLr25NxYTeDn7Sow3tCGC795w0g04y6Hi3S6khLImai4gmTWo+/ydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789277038; c=relaxed/simple;
	bh=tFT4BOAsTaQkZK/pUHop3cvaclHrmZ6KzbnaIYG7AdY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=f8sFJg35DvezEe/Z/ooly6pZSTpdy0sbuGqDfUPm+UojTVBHIC/Ek8xTuR/Yw4sjBONvst96KeFpkr7njXewX/PD26DuKwKOQJyP0TEdtbYWCTnY4jEfJWRIQzbCoeMAOLdRJgCNc1ktphrc0lHJdLe9XmkK4tPYI4tvC64cDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oscillator.com.au; spf=pass smtp.mailfrom=oscillator.com.au; dkim=pass (2048-bit key) header.d=oscillator.com.au header.i=@oscillator.com.au header.b=LbeH9Me1; arc=none smtp.client-ip=185.70.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oscillator.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oscillator.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oscillator.com.au header.i=@oscillator.com.au header.b="LbeH9Me1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oscillator.com.au;
	s=protonmail3; t=1789277027; x=1789536227;
	bh=tFT4BOAsTaQkZK/pUHop3cvaclHrmZ6KzbnaIYG7AdY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LbeH9Me1D3WtCpkPlND7PQB2aXpn57ne0lqTsuUZh7dHJXVXbzNo1WB1mIP5t8opT
	 jIHAXXx2kbYm9hr03+bYB9h3L87Nolyr9rlwZBet+NwcyYL8YU/QmkS5+sT78mwysY
	 W22sk8tHl+l176IfM9ytbgue7DnyQjCJR6EjSVYjej88XrjQxhvlDz/MhTWxh13+xX
	 hq4HNxJMKjNOmYYgdhNrk9er/fvhCaC0hFeZgalUUYCz1rEbXJAbnuTTyAgH+imdKS
	 CeLZ8vHP93qkxcsshfw6KbaaKgeZHklfsmw/P26YwxjJzSfyUG9/g1W7JQ1uwphFm0
	 b1mk8coY0tcbg==
Date: Sun, 13 Sep 2026 05:23:43 +0000
To: linux-input@vger.kernel.org
From: Cameron Spencer <cameron@oscillator.com.au>
Subject: [6.12.107] MSI G63 9SEK - Synaptics touchpad falls back to PS/2, multitouch lost at boot, fixed by delayed protocol write
Message-ID: <4bd8e20e-e4cc-4528-9862-740a437c2687@oscillator.com.au>
Feedback-ID: 30604393:user:proton
X-Pm-Message-ID: 11001bb54f30f9e22c313064f1f2819797271585
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good morning/afternoon/evening,

I experienced an issue where my Synaptics touchpad is registered as a=20
basic PS/2 device at boot, losing all multitouch functionality=20
(two-finger scroll, gestures). Writing "synaptics" to the sysfs protocol=20
file a few seconds after boot restores the SynPS/2 extended protocol and=20
full functionality.

System:

- Kernel: 6.12.107+deb13-amd64
- Distro: LMDE 7 (Debian 13 based)
- Laptop: MSI G63 9SEK
- i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64=20
irq 1,12
- Fix:
 =C2=A0 =C2=A0 $ cat /etc/systemd/system/psmouse-reload.service
 =C2=A0 =C2=A0 [Unit]
 =C2=A0 =C2=A0 Description=3DSet psmouse protocol to synaptics
 =C2=A0 =C2=A0 After=3Dsystemd-udev-settle.service

 =C2=A0 =C2=A0 [Service]
 =C2=A0 =C2=A0 Type=3Doneshot
 =C2=A0 =C2=A0 ExecStart=3D/bin/sh -c 'for i in 1 2 3 4 5; do echo -n synap=
tics >=20
/sys/bus/serio/devices/serio1/protocol 2>/dev/null && exit 0; sleep 2; done=
'
 =C2=A0 =C2=A0 RemainAfterExit=3Dyes

 =C2=A0 =C2=A0 [Install]
 =C2=A0 =C2=A0 WantedBy=3Dmulti-user.target

- Result:
 =C2=A0 =C2=A0 $ dmesg | grep -iE 'psmouse|synaptics|serio|i8042'
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.006462] i8042: PNP: PS/2 Controller=20
[PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.010384] serio: i8042 KBD port at 0x60,0x64 =
irq 1
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.010392] serio: i8042 AUX port at 0x60,0x64 =
irq 12
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.018706] input: AT Translated Set 2 keyboard=
 as=20
/devices/platform/i8042/serio0/input/input0
 =C2=A0 =C2=A0 # psmouse probes at boot, fails the Synaptics handshake, reg=
isters=20
as plain "PS/2 Synaptics TouchPad" (no multitouch)
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 2.384949] input: PS/2 Synaptics TouchPad as=
=20
/devices/platform/i8042/serio1/input/input6
 =C2=A0 =C2=A0 # psmouse-reload service runs after systemd-udev-settle and =
writes=20
synaptics to /sys/bus/serio/devices/serio1/protocol, then re-probes with=20
the Synaptics extended protocol, queries coordinates, and registers as=20
"SynPS/2 Synaptics TouchPad" (multitouch restored)
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.654815] psmouse serio1: synaptics: queried =
max coordinates:=20
x [..5656], y [..4728]
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.683422] psmouse serio1: synaptics: queried =
min coordinates:=20
x [1284..], y [1128..]
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.739382] psmouse serio1: synaptics: Touchpad=
 model: 1, fw:=20
8.2, id: 0x1e2b1, caps: 0xf00323/0x840300/0x26800/0x0, board id: 3163,=20
fw id: 2286728
 =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.775128] input: SynPS/2 Synaptics TouchPad a=
s=20
/devices/platform/i8042/serio1/input/input21

The issue is 100% reproducible across reboots. "options psmouse=20
proto=3Dsynaptics" in modprobe config causes "EINVAL" on module insert.=20
The handshake fails at that early stage. A systemd service that retries=20
the sysfs write after systemd-udev-settle is a reliable workaround.

This appears to be a timing issue where the touchpad firmware or i8042=20
controller is not ready for the Synaptics handshake at the time psmouse=20
first probes. A retry with a short delay in the probe path, or a=20
something more fancy with initial handshake, would likely resolve this.

Happy to provide additional info if required.


Kind regards,

Cameron Spencer


