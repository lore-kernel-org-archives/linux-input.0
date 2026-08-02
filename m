Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF22BD587
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660977; cv=none; b=K3uTKAoFHoJtnZMYzGfVkT1ZpaNN1RWASG4hfazGu6sbnc3dL6BU8HKteGUaS78EO2SyeIskz1eXQFTnx7ZnU/u1VEjmUvIOr+gTDIL2v5n5SwLe7J9luQIUu03uX9O3S13ZBHFSHchsnFCqrHJvHWs4kASdZ602U0zbLKQ1szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660977; c=relaxed/simple;
	bh=d1JVSPwjQaVSt6xzWFa+bNo6JsHGVP43sHHspFzQyY0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GrAX2M2ygAtcN/N1cvl9uvnzfHxdhEhc6g/ECBlzAQoVZyaL5vB2gARlmUgQHkjqJXgHBXxuYKDrVU1GdJaVCUOVpcd4I+p4cJa7/lajACZb3oIiNj4sW+Q+pXykexaMXGDKTiQ+PhQKtSamGRoTNywFp7Ohgf/eH3vHox9Hh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carsten-raddatz.de; spf=none smtp.mailfrom=carsten-raddatz.de; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carsten-raddatz.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carsten-raddatz.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hCYZ35pVLzMlHy
	for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 10:56:11 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=none (outgoing_mbo_mout: domain of kontakt@carsten-raddatz.de has no SPF policy when checking 2001:67c:2050:b231:465::102) smtp.mailfrom=kontakt@carsten-raddatz.de
Message-ID: <be58d0e5-feb0-46e1-b43e-e873de461802@carsten-raddatz.de>
Date: Sun, 2 Aug 2026 10:56:24 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-input@vger.kernel.org
From: Carsten Raddatz <kontakt@carsten-raddatz.de>
Subject: [RMI4/SMBus Test Report] Lenovo ThinkPad E495 touchpad intertouch
 attempt (LEN205d PNP0f13)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hCYZ35pVLzMlHy

Hi Linux Input Team,

I am writing because dmesg output on this Debian Trixie 13.6 suggested 
as much. This mail reports the result of testing 
`psmouse.synaptics_intertouch=1` on a Lenovo ThinkPad E495, as suggested 
by the psmouse driver in dmesg.

Hardware Details:
- Laptop: Lenovo ThinkPad E495 (20NE)
- Touchpad PNP ID: LEN205d (PNP0f13)
- OS: Debian 13 (Trixie)
- Kernel: 6.12.100+deb13-amd64 (very vanilla)

Pre-test setup check:
Neither `i2c-hid` nor `hid-rmi` were driving the device. The touchpad 
was bound to the legacy PS/2 bus 
(`/devices/platform/i8042/serio1/input/input7`). `lsmod` showed no 
active module usages for `i2c_hid` or `hid_rmi`.

Test Result with `psmouse.synaptics_intertouch=1`:
When booting with `psmouse.synaptics_intertouch=1`, intertouch 
initialization fails due to timing/readiness issues with the SMBus 
companion, causing psmouse to fall back to standard PS/2 mode.

Relevant dmesg snippet:

[    0.018317] Kernel command line: 
BOOT_IMAGE=/boot/vmlinuz-6.12.100+deb13-amd64 
root=UUID=d8389723-dbf0-4502-ac1a-4d9c9ac601c0 ro quiet splash 
psmouse.synaptics_intertouch=1
...
[    2.492227] psmouse serio1: synaptics: queried max coordinates: x 
[..5678], y [..4694]
[    2.538765] psmouse serio1: synaptics: queried min coordinates: x 
[1266..], y [1162..]
[    2.538777] psmouse serio1: synaptics: Trying to set up SMBus access
[    2.543173] psmouse serio1: synaptics: SMbus companion is not ready yet
[    2.645656] psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, 
id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, 
fw id: 3972349
[    2.645683] psmouse serio1: synaptics: serio: Synaptics pass-through 
port at isa0060/serio1/input0
[    2.709409] input: SynPS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input7
[    3.370088] psmouse serio2: trackpoint: Elan TrackPoint firmware: 
0x11, buttons: 3/3
[    3.672181] input: TPPS/2 Elan TrackPoint as 
/devices/platform/i8042/serio1/serio2/input/input8

The touchpad continues to function normally (multitouch gesture) via 
PS/2 fallback, but as I understand from this SMBus access could not be 
established.

Please let me know if you need further logs or would like me to test a 
patch or additional kernel parameters.

Best regards,
Carsten

(Gentoo linux user usually)

