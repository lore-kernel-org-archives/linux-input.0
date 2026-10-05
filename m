Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE147255F
	for <linux-input@vger.kernel.org>; Mon,  5 Oct 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207498; cv=none; b=Nj1e0BGU6Equqt4Q90GrgXUqwfxMYm/ex2nQtsRbJLTiFOwvSSIj/GlqKoNznpN6Grz4STvxe79lwYrEQ/e+WKKvN8WaRWEMD45fi7zI9TbcmlhCrYGJQL3+0AncNA0UEoVG7WLdrNVt2MdsPRU3eL2iHi7HrLLuU4XfQ1IKgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207498; c=relaxed/simple;
	bh=OyXr/KqW0rSHoLtIOJEZmUlKmHXADuAA/1PUdGUa5sI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lEtBynEjfPqEgutpKiKvd3LNhcOwvqPJJ/Ydd5gVADW+SwWGCiD0IN7HKlX9tqAyxAslLZqoJcmFxI6Rf7bwWwF3sx1xVWJTuhOFUgjtL1Y5rGm8uuNpROOVXpJNFwAQHffFZ9lYblNrW+6iOWIx1UrBSV0gw2l65DvOrNqjF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=sBUt/Yw4; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sBUt/Yw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1791207488; x=1791466688;
	bh=/YUVVPstaju2qfGgZam986uP8cCPqcqCaGnlJxFyzNs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sBUt/Yw4BNkKAL6/EXryfQoBnzGOHbbqqgcndeBzOHJWtmWF3ew1ZdEt4Tlitbct6
	 WEU34EEaGbU9pEozi/eM2rNPpFWpv+JjLXHbzI8AdLtw2lTzVuvq7TuVVikYow+1wq
	 ZfV73CmQoowpcMBlbpHi4d2OWPPzkWxUYKJTxBW6rKq5V5FmGhGhKujvVGg6DPvy6r
	 ObehjSxoZ44bpom3/GaijM9fe6n1Rvr8j4VwRNWheGhPVZSBkyWoekpwjmGOK0Of/Y
	 bnV6OhuNN5kUEN8CtPRSMLRVC7oFynw83204kScmjBTVRigKg4qKhVf3mCFpmX/nYx
	 gQ61edFK2DI1Q==
Date: Mon, 05 Oct 2026 13:38:04 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Kelly <kmccuddy@protonmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: [BUG] hid-asus: ITE 8910 N-KEY keyboard (0b05:19b6) dead after s2idle resume reaching s0i3
Message-ID: <rQapwEI4uC2r3hcuO9O69NMtw_9aQCNR3ilmC4AEhjknqM5Q1APnPeR9z-rRrlUEgtzYVvEj0gHQlUkDYsUykFl-cIGCEhUVK5OFEcQfui8=@protonmail.com>
Feedback-ID: 29863968:user:proton
X-Pm-Message-ID: bdf1c5c1b88a4be57827ac2b94b607cdda6b9e9e
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,

On an ASUS ROG Zephyrus G15 (GA503RM), the internal keyboard stops
producing key events after resuming from s2idle whenever the platform
reaches s0i3. The device stays bound to hid-asus, and only a full re-probe
of the USB device brings it back.

Hardware and software
- ASUSTeK ROG Zephyrus G15 GA503RM, BIOS GA503RM.319 (04/19/2024)
- AMD Ryzen 9 6900HS (Rembrandt); /sys/power/mem_sleep offers only s2idle
- Keyboard: USB 0b05:19b6 "ITE Device(8910)", bcdDevice 0003, on the
  AMD xHCI at 0000:07:00.3 (usb 1-3), driven by hid-asus
- Kernels: Debian 7.1.13-1~bpo13+1 and 7.2.6-1~bpo13+1 (both affected;
  rechecked on 7.2.6 with our workaround disabled)
- Distribution: Devuan Excalibur based (sysvinit, elogind), unmodified
  Debian kernel

Symptom
- During sleep the keyboard backlight changes to white and flashes, as
  if the keyboard controller had reset to its firmware defaults.
- After resume the backlight is on but no key produces an event; Caps Lock
  doesn't toggle its LED. An external USB keyboard works.
- The kernel logs nothing for usb 1-3 on resume: no disconnect, no
  re-enumeration, no error. usb_dev_resume for 1-3 returns 0 (about 70 ms,
  with pm_print_times). The HID device keeps its original instance and
  input device (still bound to hid-asus).
- It happens only when the platform reaches s0i3: amd_pmc reports
  "SMU idlemask s0i3", and /sys/power/suspend_stats/last_hw_sleep was
  17-35 s for a 20-40 s suspend. On this machine that depends on the
  discrete GPU: with nouveau loaded the keyboard survived every suspend,
  on AC and on battery, presumably because the platform never got as deep;
  with NVIDIA's driver (615.71.09, S0ix power management enabled) every
  suspend reached s0i3 and every one lost the keyboard.

What restores it
- Unbinding and rebinding the USB device works every time:
    echo 1-3 > /sys/bus/usb/drivers/usb/unbind
    echo 1-3 > /sys/bus/usb/drivers/usb/bind
  We now do this from an elogind sleep hook after every resume, which has
  held across many suspend and hibernate cycles.
- usbcore.quirks=3D0b05:19b6:b (USB_QUIRK_RESET_RESUME) does NOT help: the
  device was reset on resume ("usb 1-3: reset full-speed USB device"), but
  the keys stayed dead.

So the USB device survives, but the state hid-asus sets up at probe
doesn't, and neither resume nor reset_resume redoes it. A full probe does.
At every probe, including working ones, the driver logs:

    asus 0003:0B05:19B6.0002: Asus handshake 5a returned invalid response:
    5a 05 20 31 00 08 01 00 00 02 00 00 00 00 00 00 00 25 01 95 05 75 ...

Would it make sense for hid-asus to repeat its keyboard initialisation (the
handshake and whatever else probe sets up) on resume / reset_resume for
these keyboards, or to detect that the controller has lost its state?

I'm happy to test patches on this machine.

Thanks,
Kelly McCuddy
