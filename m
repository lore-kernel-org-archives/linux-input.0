Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482164;
	b=N2rP+ssHcfxctEwcp9G/JiILe6SqBDGyxTNDA7Vl2R3oYHRvK3BMeB5V8p3prigxiSce
	 IfTMVDUBwCAa0KeW7sa2kPBFWRCbjJcY+nILABWkIf7qj0S6nnGZg8UCh15fKVrWeQAWE
	 xbHnM5HkUqQSFVgxuqvT92epMxTP5TRHpkNzHJ8MQj4+I7vEfg+eF83F+vRfI2qgSGDgE
	 nORbz3jWS7dq8OOFqNCZpK3AbVIpuL08HElS6BBu0S6G3qfAL8CTMFoOS+tB23Bj8UuJD
	 i0aSKNOk/ByTd5E5eSLzFUq2PAncW0VseYD/g7un2SLaC7Gxsfw77OtAoDFXyCeSXfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482164;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uQn5jwdKnyxjdpmupOfZSkyFXY4EXkXtWnBHY24EzDs=;
	b=BNeuHHWsNCF9sR/PYASBqyZT2mmugVFnynclgb28CBZ0WZj3RIQ/TN0G92qI7IWRLSML
	 5S0V8W0YCj8+3xIP04iImEtqNd2TTHrN5WloHj7S5CcboOS4PUR+i/8I948rXMiEb4oj1
	 fXXKfd0mPfMkgujwT0t5Fa+2qYPuWn+2LNaGcoGHCeaj7bp5SvMs229f60pTGFG3o+g/4
	 KC3rVewKck2RpuP/5dIseYtdyRHHvmcJk8RidVqnpm46c9LCSgKK1gkrywKMpVESVke+M
	 xckOEWcrX1R/5HSRJUZoHnQf8faSVkCUR9I5o5lRDd9MdiJ/xbUzBACjWfE52t344TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=E27ooAHO;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CF606A31B
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 07:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732CF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=E27ooAHO
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 9EBC6240104
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 09:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792482155;
	bh=uQn5jwdKnyxjdpmupOfZSkyFXY4EXkXtWnBHY24EzDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=E27ooAHOrkt7YF8DAJfe5tjUTxClZkAixVvC5y3r5tIkpu3eGTOQXZfnAXECYGBXj
	 +K3Z+m4jaXf6KLEdpGixXaTHE4k04ZG+TqtRW+WEEd3uO/PjepLRiSTM17eWVRymy+
	 k2UkiheljpvPCZttGF7hCVkNz3aAkifrXxOMohULbjLkxI6KMG7Onhrp24TVKU3BVE
	 BIZP/vx15+A9JHS69W1LbtGoqD881jxNny3YRagyBNRPRkywV5SDEBpWTt1GC6vWw2
	 f6FbKQ65C7eQFkeaDjayiM4QCkcfxetxYszHrP1q5lMnydRdQ6M+cRx07vscb1PFdG
	 sJhVs7R36W8kQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j84Bd4M3xz9rxD;
	Tue, 20 Oct 2026 09:42:33 +0200 (CEST)
From: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
To: Denis Benato <denis.benato@linux.dev>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard handshake after probe
Date: Tue, 20 Oct 2026 07:42:35 +0000
Message-ID: <20261020074226.30277-1-rebecca.mara@posteo.de>
In-Reply-To: <5e44ab55-09e3-4043-a369-05b792b5e0d3@linux.dev>
References: <5e44ab55-09e3-4043-a369-05b792b5e0d3@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026 at 10:38:11PM +0200, Denis Benato wrote:
> Does this laptop have other lights? I wonder what that is changing...

Three, none of them obviously software controlled:

- the LED in the power button: white while running, orange while off
  and charging;
- an LED on the left side of the keyboard, white while the machine is
  running, off otherwise;
- a small LED in the F11 (Bluetooth) key that lights up white for a few
  seconds when the keyboard is lifted off.

I saw no LED change during the tests below. The firmware's own LED
table agrees: GALE() checks a LEDS variable that is hard-coded to 0.

I also tried the IDs directly through asus-nb-wmi debugfs:

- 0x00050021: DSTS returns 0xFFFFFFFE, but DEVS still calls SLKB and
  writes the EC. Writing 0x83, 0x00, 0x81 and 0x82 made no visible
  difference anywhere on the machine.
- 0x00050031/0x00050032 (ScreenPad): DSTS reports them as present, so
  asus-wmi registers an asus_screenpad backlight. Writing bl_power and
  brightness changes nothing on either panel. Harmless, but the
  device should not be there on this model.

That fits your point about code reuse. Two more fingerprints: 0x00060024
returns a package containing 0x9D2F8086, the PCI ID of the Skylake-era
Sunrise Point-LP xHCI controller, and 0x00050035 has unreachable code
after a Return that writes the same EC registers as the ScreenPad IDs.

> Doesn't look like something to be investigated further, perhaps try to see
> if there is some unknown devid in wmi that does something cool.

I read through the 45 IDs that WMNB answers but asus-wmi.h does not
know. About half return constants. The one I find cool is 0x0006006C:
it is set-only (no DSTS, so Linux treats it as absent) and takes
0..3, which it stores as 0/7/9/8 in the DTT variable ODV3 before
notifying IETM. The DTT data vault (INT3400 data_vault, apct/apat)
names what that means:

  ODV3  targets (PL2/PL1 in W)
  0     Whisper 35/30, Standard 55/42, Performance 64/55
  7     Stand_Whisper, Stand_Standard, Stand_Performance (same)
  8     Book2_Whisper 23/20, Book2_Standard 33/30
  9     Book1_Whisper 23/20, Book1_Standard 33/30

So it is a posture input. In the Book postures the firmware also
refuses the performance profile in 0x00110019. thermald --adaptive
applies these tables on Linux (intel-rapl-mmio currently reads 42/55 W,
i.e. "Standard"), but nothing on Linux ever reports a posture, so the
machine always runs the laptop table. I did not write the ID myself.

Related: 0x0011001F writes ODV5, and ODV5 = 255 selects a "Check"
target capped at 20 W, which looks like a factory or service mode.

Two IDs I looked at and left alone: 0x00120061 reads EC 0x2C and would
return 0x00010002 if it is set. I tried five chargers, down to a
USB-A 5 V source where the battery was discharging at about 9 W, and it
always returned 0x00010001. 0x00060059 is a generic pass-through for
EC read/write commands 0xE0..0xEF.

To report a posture you need the sensors, and those were dead too: the
ISH rejects the generic intel/ish/ish_ptl.bin ("ISH loader: cmd 2
failed 10"). ASUS's own SensorHub driver package (5.8.62.0) contains a
signed image, AsusSign_ishS_SI_CommonPTL_5.8.1.7779_V0018.bin. Placed
locally as intel/ish/ish_ptl_59b8d9f2_c68ec386.bin (vendor + product
name CRCs) it loads, and accel_3d, als and hinge show up. s2idle
hardware residency stays where it was: 27.6 s and 27.9 s out of 30 s
with the ISH running, against 28.4 s without.

HP, Dell and Lenovo ship their ISH images in linux-firmware, ASUS has
none. Do you happen to know someone at ASUS who could submit theirs?
That would give every Zenbook Duo working rotation, ambient light and
the hinge angle, and with the hinge angle a small service could feed
0x0006006C as Windows does.

> in the OGC discord (ex asus-linux discord, you find it on our website) people
> are planning a GUI redesign, perhaps if you have spare time you can add an option
> to asusd to shutdown leds when entering sleep to have a GUI on a widely used tool

Thank you for the pointer. I am not on Discord, and GUIs are not where
I am useful. If the sleep option lands on the asusd side (daemon or
CLI), I would be glad to test it on this machine.

Thanks,
Rebecca
