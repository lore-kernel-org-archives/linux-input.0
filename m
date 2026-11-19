Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.188.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107313;
	b=qRE7B72oty1DOxtok/703vtGLQ2OQTM13whTofR+ue0y1FdOYJOiLMQI1yrSDU3ys7rL
	 l0x8LhwtEoLGpywdIgf2dk+6yqKCWOmBB3jC7Cci4qg1i1GjNQg2H434Di7G3U7gkEbWa
	 uaiQNsqn+AiSW3UMVXcGUxAomgz/7N2mc2gWcZpIxixgQb92j6q0VCSnTU+OmEiao72pb
	 kbf1RnE2TnqwyNh+O/gkAIVacIecqFGe4taf0BC1XZ//1RW0UqD6xrxzp0TRQFfOKbOoT
	 RF+EexxraYPyhJ1kXmRh2K/QQpkSjGPbe51xuDw7KlO2OtD7ooFCjhc8NXh3rN9IwAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107313;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=qt8PiS/NnV3lcYzkm5HoL68CIdwd+S9jcTTldEeZtNk=;
	b=h0pp75tEisVdhe/Jse2B7I5vLMBXaTkNbyhucyIGzhqwuatlN+fRGBxlq9O+7/kR0xp2
	 x8xAUCmX/lQh3FH6241BdxPRR403X6M/rY8sc0ebF/LwCNE+5MIxDdfbau4Qs1qi+4Q+J
	 uheU11zGfEyB6jrYWe40KwKSDHPpqGJCtzN+80ZTXTVb3l1jyRxPELPBryH9tM+qLwZNL
	 uovBHxmP7Bx9VkXBhB4mtoHLC1BDiwxwiQ3rF+kgvTnsO6gFtvHT8Yj6UuVBZEQkaCtjL
	 1HBQU2SJvmkwIdaYNGkO5bMW+KjEqWzUJu5oPzf4PuFLfoXJeeKHFwtZQgFSrV5k5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mumbletreff.com;
	spf=pass smtp.mailfrom=mumbletreff.com;
	dkim=pass header.d=mumbletreff.com header.i=@mumbletreff.com header.a=rsa-sha256 header.s=dkim header.b=aCqpZ2nG;
	arc=none smtp.remote-ip=49.12.188.111
Received: from mx.mumbletreff.com (mx.mumbletreff.com [49.12.188.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87102606A32F
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87102606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mumbletreff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mumbletreff.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mumbletreff.com header.i=@mumbletreff.com header.a=rsa-sha256 header.s=dkim header.b=aCqpZ2nG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mumbletreff.com;
	s=dkim; t=1795107305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qt8PiS/NnV3lcYzkm5HoL68CIdwd+S9jcTTldEeZtNk=;
	b=aCqpZ2nGlg5n5D5htgBS2cPRLj5LQzv/L6/QeiBxFPbWi25QV0zOPnK2gsyQruivfQuau7
	kdMwYCF43e/7T9RuTAAycrsb14yL1oRRsMsgOpXimUlB68lb88N4YoDRly/pn3WAdf9PBe
	/4YAM/lUzICNduQdvenXgSCWrKDuRsREcUVnLjMhbYxzVzjAHxd2p90ETKRkJyTbN0A0eM
	E1q92U5qflYujs3FHTN32pAYGwDsiw8bUoHz5knSo2iYlnamS2Vsg2GaD0WDsRUsf5csBm
	ua9nyygGWcEMB7ArWCmWwxRksOakF3pxF9osrRUSoq3x6NNE6QZYD+N/V3DzEw==
Received: from [IPV6:2a02:560:4e49:ad00:1e1e:bb85:ed54:1778] (<unknown> [2a02:560:4e49:ad00:1e1e:bb85:ed54:1778])
	by mx.mumbletreff.com (OpenSMTPD) with ESMTPSA id 823d3fb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 16:55:04 +0000 (UTC)
Message-ID: <d426ab73-e1aa-43da-a6ca-8fbb05362aaa@mumbletreff.com>
Date: Thu, 19 Nov 2026 17:55:04 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org
From: Phobos <phobos@mumbletreff.com>
Subject: HID: lenovo: cptkbd probe blocks ~20 s per device when feature
 reports time out (behind KVM switch)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

with the ThinkPad Compact USB Keyboard with TrackPoint (17ef:6047)
connected through a USB KVM switch (ASIX AX68002, 0b95:6802), probing
the mouse interface in hid-lenovo blocks for about 20 seconds per
keyboard. With two KVM ports this delays usable keyboard/mouse input
until ~46 s after boot; GDM/gnome-shell is already up at ~9 s.

Kernel: 6.18.63 (Gentoo distribution kernel, Fedora-based config,
CONFIG_HID_LENOVO=m). I checked current mainline hid-lenovo.c and the
relevant code is unchanged.

The KVM switch emulates the keyboard and does not pass the vendor
feature reports (report 0x13, SET_REPORT) through, so every
lenovo_send_cmd_cptkbd() call ends in a 5 s USB control timeout:

   [   10.026746] lenovo 0003:17EF:6047.0003: Failed to switch F7/9/11 mode: -110
   [   15.146706] lenovo 0003:17EF:6047.0003: Failed to switch middle button: -110
   [   20.266709] lenovo 0003:17EF:6047.0003: Fn-lock setting failed: -110
   [   25.386681] lenovo 0003:17EF:6047.0003: Sensitivity setting failed: -110
   [   25.387037] input: Lenovo ThinkPad Compact USB Keyboard with TrackPoint as .../2-14.4.1:1.0/...
   [   30.720038] lenovo 0003:17EF:6047.0008: Failed to switch F7/9/11 mode: -110
   [   35.840036] lenovo 0003:17EF:6047.0008: Failed to switch middle button: -110
   [   40.960040] lenovo 0003:17EF:6047.0008: Fn-lock setting failed: -110
   [   46.080009] lenovo 0003:17EF:6047.0008: Sensitivity setting failed: -110
   [   46.258842] systemd-logind: Watching system buttons on /dev/input/event22 (Lenovo ThinkPad Compact USB Keyboard with TrackPoint)

USB topology (lsusb -t, abbreviated):

   Port 014: Hub 1a40:0101
     Port 003: Hub 0b95:6802 (ASIX AX68002 KVM Switch SoC)
       Port 001: 17ef:6047 ThinkPad Compact Keyboard with TrackPoint
       Port 002: 1532:0098 Razer DeathAdder Essential
     Port 004: Hub 0b95:6802 (second KVM port, same devices)

lenovo_features_set_cptkbd() sends four commands synchronously from
probe and continues after each failure, so a device that never answers
costs 4 x 5 s. While the probe runs, the udev events for the other
devices behind the same hub are not processed either, so the keyboard
is unusable for the whole time.

Possible improvements (I'm not familiar enough with the driver to say
which is preferred):

   1. Stop sending the remaining feature reports after the first one
      fails with -ETIMEDOUT (and maybe skip creating the sysfs
      attributes that cannot work).
   2. Send the initial settings from a workqueue instead of blocking
      probe.

A second, related issue: simply blacklisting hid_lenovo does not fall
back to hid-generic. 17ef:6047 is listed in hid_have_special_driver,
so HID_QUIRK_HAVE_SPECIAL_DRIVER is set whenever CONFIG_HID_LENOVO is
enabled, and hid-generic refuses the device even if hid-lenovo is not
loaded. The keyboard then has no driver at all. With the kernel built
without CONFIG_HID_LENOVO everything worked through hid-generic.

Workaround (tested): booting with usbhid.quirks=0x17ef:0x6047:0x0
(the dynamic quirk replaces the static ones, including
HAVE_SPECIAL_DRIVER) plus "blacklist hid_lenovo" makes hid-generic
bind all four interfaces at ~4.3 s; keyboard and TrackPoint are usable
as soon as GDM is up and no timeouts are logged.

Happy to test patches.

Thanks,
Phobos

