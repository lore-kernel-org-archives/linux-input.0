Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FE3B6C01;
	Sun, 30 Aug 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099251; cv=none; b=NouCKwLaFw4ULG7PdT5vZaIHbTRgCaFt4DMMtCzmE6+msXy3lVIhMf3e/6pH34A6meA2FoWMEsUR/mu4Mdacqt0ptFc30wZZLzRzUKhvN6uASAsebL5n7/L81aJ5fuSFwwrJ7SkcHuTTmIFefjJIvROhvzvyJT7fWh7LuFwGWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099251; c=relaxed/simple;
	bh=JBXgjRPgkgipMjrVz/UPNDg11gkGeniqWvOfMdAQPZo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kCurra+1E9SoUkEXdv/75m80QUyDA8GW90AXrK3hsne5bgWXgIpJNRIEDadc5eg708XC4ZTbk8XHv/WMnYGviMOBEzjE/CF8vuFW7uTgLCPYkZKQxCwy8WcfzXPqncxZsTgr7lW6Xx3YgocG5tBf6mndjWz7cobgVUR4NhJcBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b9Il1G4N; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b9Il1G4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788099244; x=1788358444;
	bh=gABTmVA6p5jpKrbDQzvfZ2ui8YhnTIivnH2v83tkwZc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b9Il1G4NtsTfBcWOD7BZQPfYW0HHD48nDWchf8uu/VobcYZ5XQHXZJv+9zD5yADwR
	 SdrgSM9h4YRzH7uBIoAfSYPzmVKyNzTHeU7I788tav00SXXHsWX5v3JF9KJn192Cwf
	 gX/0lgcnKqfQj3V0F+pApOz24LL++KSNZldchzgLBQNmDwDzwIMbTKmk1UDO0BWcvJ
	 i6jPb8MKou7XQ29JPn2zqPzEG3cYgyw9orlL/1rHoCc/oTswFNJHJQIndITV6kLQaF
	 80hALYXXFLqpLyXmhzCI8OkDVYKjd+p8xkdDH8V2zxySxXbcLdfue1wNLSwZgccIyU
	 3KlDoL99YqSiQ==
Date: Sun, 30 Aug 2026 14:14:01 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: soc_button_array: ignored -EPROBE_DEFER loses the buttons on 68% of boots (Surface Pro 11)
Message-ID: <20260830141355.55898-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: e7ef77e3c7823f58a32037638293872bfb2c16ff
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

On a Microsoft Surface Pro 11 for Business (Intel, Lunar Lake) the power an=
d
volume buttons fail to appear on most boots. The probe runs, gives up
silently, and the device is lost until something rebinds it by hand.

Measured across the 40 boots in this machine's journal, using the monotonic
offset of the first "input: gpio-keys" message:

  driver attached on its own   13 boots   at 1.28 - 1.78 s
  did not attach               27 boots   68 %

The timing is binary. Either the inputs appear at about 1.3 s, or they neve=
r
appear at all - no intermediate values in 40 boots.

Where it fails
--------------

Nothing at all is logged on a failing boot, so I built with
soc_button_array.dyndbg=3D+p on the kernel command line. On four consecutiv=
e
failing boots the probe printed exactly one line:

  [    1.286567] soc_button_array MSHW0040:00: OEM Platform Revision 129

That eliminates most of the possibilities:

  - the probe does run
  - it passes soc_device_check_MSHW0040() - oem_platform_rev is 129, not 0
  - it passes gpiod_count() - the dev_dbg("no GPIO attached, ignoring...")
    would have printed with dyndbg on, and did not

By elimination the buttons are lost inside soc_button_device_create(), at

        error =3D soc_button_lookup_gpio(&pdev->dev, info->acpi_index,
                                       &gpio, &irq);
        if (error || irq < 0) {
                /*
                 * Skip GPIO if not present. Note we deliberately
                 * ignore -EPROBE_DEFER errors here. ...
                 */
                continue;
        }

Every button is skipped, n_buttons stays 0, and the two returns that follow
are both silent:

        if (n_buttons =3D=3D 0) { error =3D -ENODEV; goto err_free_mem; }
  and
        if (!priv->children[0] && !priv->children[1]) return -ENODEV;

which is why nothing reaches the log.

The GPIO controller here is INTC105D, five gpiochips driven by
pinctrl-intel-platform. Both that and soc_button_array are modules in this
config:

  CONFIG_INPUT_SOC_BUTTON_ARRAY=3Dm
  CONFIG_PINCTRL_INTEL_PLATFORM=3Dm

A manual bind always works: 25 unbind/bind cycles at runtime gave 25
successes and 0 failures. The failure exists only in the early-boot window.

One hypothesis, tested and wrong
---------------------------------

Since both are modules, load order looked like the cause, so I tried

  softdep soc_button_array pre: pinctrl-intel-platform

verified applied (modprobe --show-depends inserts pinctrl first), with the
rescue that normally binds it by hand disabled so nothing masked the result=
.
Five boots: 2 successes, 3 failures - the same rate as before.

pinctrl_intel_platform is a dependency of fifteen other modules and is
loaded long before either way. softdep orders modules; the race is against
the asynchronous probe of the individual INTC105D:0N devices, which registe=
r
their gpiochips at their own pace. Reporting this so nobody else spends the
evening on it.

Why no patch
------------

The comment says -EPROBE_DEFER is discarded because Intel uses "virtual
GPIOs" that never materialise, so deferring on them would hang the probe
forever. A fix has to tell that case apart from a controller that simply ha=
s
not probed yet, and I do not know which signal you would want to use for
that. Guessing would risk reintroducing the problem the workaround exists
for.

Happy to test whatever shape you would prefer - the machine is here and I
can build and boot kernels on it.

Related but probably not the same bug
--------------------------------------

  https://github.com/linux-surface/linux-surface/issues/885

Open since 2022 on a Surface Pro 7+ and a Pro 6: same shape - driver loaded=
,
gpio-keys absent, rebind fixes it - but there the buttons are lost during a
session rather than never appearing at boot. Cross-referencing rather than
merging the two, since the triggers differ.

  Machine:  Surface Pro 11 for Business (Intel Core Ultra 7 268V)
  DMI SKU:  Surface_Pro_11th_Edition_With_Intel_For_Business_2103
  Firmware: UEFI 17.100.143 (2025-11-19)
  Kernel:   7.0.0-30-generic, Ubuntu 26.04.1

Thanks,
Sergey Lebedev

