Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518592;
	b=OWk382rYOTUoAthTEWaQMCK5rOnBpJLL9I07YYMNkfQe+mHatvIHHNPpzX8aHPYp3wOI
	 QmiDke060xiILiMb/J75Q0K8lU/TAzptJlkNf6ND2653qu2GwZiWA9ttBvtUt14N6rJm0
	 AnBr5CGU8POl94rOpQZEH85xQXbtwhh9UYxMQzFlJy4hVnv2c2y/VC03g/gcM0cegr3U5
	 A+gLHA+tR9GmdEMmC9dOS7Hmzm6XFGu52zvza4diNgM/3biFJErEjllcSZcVUuqgQ98lA
	 tGKmmiSd3LKQ0MhU9t99zfC4OxmTDIauMv5Rin9kuNDpKAgMXyEd9hIP6cB0p7UyyUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518592;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=w1P7W6t1qdfJDNHo1qf6jaohnKGyf68cf4CqpIgt5Qw=;
	b=rBGtnPQ57+vxzNp32e6ezOJ9LbfnhqPweiWnzZtRWCONTYA2dscq9q52fYPCgkXf7wob
	 lPyISUW7nXY1T2QlbLvE1gnjIBFJLt5tddMIAS6nkvwwRGb+NVjJ6XNL0xsAzNb1GGe6d
	 k5OD2u4OPG1JL3x2cr0Nt0Eob1F45pAIT5j6OvXfodsS89o/ekp+eI2WRVUvAU91kyJ5z
	 7qmNEz5Zyj/YuibLHQpVEeaoonEbrO5QkVxFM1d/uPyYdS5wrG8SVoIMV4A4szKLmihE9
	 rzPG4jVd/OfjTC0TMVmgu1vWgVIgNmbTGb2JVsaNfvos3T34B/Vz6JTRJSrD1XQHH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R0xYxuNr;
	arc=none smtp.remote-ip=95.215.58.181
Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969C606A321
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8969C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R0xYxuNr
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3LMAVC4kh8KJAzmmLwn78lrIFODve62DQ6QU66x6YqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792518589; v=1; x=1793123389;
 b=R0xYxuNrAi9SNdIgVz4EPafS9f10y7KmbH9Dw7SUoL1BR4z6oyY22knwmX+LeTukIdyv2LKD
 +ZkILiwTtUc8K2Ii/5o31HYkazNDs9xHuuJyLMqSvHh1xyWtAr+Ny2EAMD4ONuTTPQC4q6YrbS5
 /95QT8gTnMaOWndMxoX+qdmc=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc2b3922390274f1;
	Tue, 20 Oct 2026 17:49:49 +0000
X-Mizu-Trace-ID: dc2b3922390274f1
X-Migadu-Flow: FLOW_OUT
Message-ID: <5dc51ff0-8423-4acc-a392-7d370db2d27f@linux.dev>
Date: Tue, 20 Oct 2026 19:49:48 +0200
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
Subject: Re: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard
 handshake after probe
To: =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>,
 Paolo Pisati <p.pisati@gmail.com>
References: <5e44ab55-09e3-4043-a369-05b792b5e0d3@linux.dev>
 <20261020074226.30277-1-rebecca.mara@posteo.de>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261020074226.30277-1-rebecca.mara@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/20/26 09:42, Rebecca Mara Müller wrote:
> On Mon, Oct 19, 2026 at 10:38:11PM +0200, Denis Benato wrote:
>> Does this laptop have other lights? I wonder what that is changing...
> Three, none of them obviously software controlled:
>
> - the LED in the power button: white while running, orange while off
>   and charging;
> - an LED on the left side of the keyboard, white while the machine is
>   running, off otherwise;
> - a small LED in the F11 (Bluetooth) key that lights up white for a few
>   seconds when the keyboard is lifted off.
>
> I saw no LED change during the tests below. The firmware's own LED
> table agrees: GALE() checks a LEDS variable that is hard-coded to 0.
>
> I also tried the IDs directly through asus-nb-wmi debugfs:
>
> - 0x00050021: DSTS returns 0xFFFFFFFE, but DEVS still calls SLKB and
>   writes the EC. Writing 0x83, 0x00, 0x81 and 0x82 made no visible
>   difference anywhere on the machine.
> - 0x00050031/0x00050032 (ScreenPad): DSTS reports them as present, so
>   asus-wmi registers an asus_screenpad backlight. Writing bl_power and
>   brightness changes nothing on either panel. Harmless, but the
>   device should not be there on this model.
>
> That fits your point about code reuse. Two more fingerprints: 0x00060024
> returns a package containing 0x9D2F8086, the PCI ID of the Skylake-era
> Sunrise Point-LP xHCI controller, and 0x00050035 has unreachable code
> after a Return that writes the same EC registers as the ScreenPad IDs.
>
>> Doesn't look like something to be investigated further, perhaps try to see
>> if there is some unknown devid in wmi that does something cool.
> I read through the 45 IDs that WMNB answers but asus-wmi.h does not
> know. About half return constants. The one I find cool is 0x0006006C:
> it is set-only (no DSTS, so Linux treats it as absent) and takes
> 0..3, which it stores as 0/7/9/8 in the DTT variable ODV3 before
> notifying IETM. The DTT data vault (INT3400 data_vault, apct/apat)
> names what that means:
>
>   ODV3  targets (PL2/PL1 in W)
>   0     Whisper 35/30, Standard 55/42, Performance 64/55
>   7     Stand_Whisper, Stand_Standard, Stand_Performance (same)
>   8     Book2_Whisper 23/20, Book2_Standard 33/30
>   9     Book1_Whisper 23/20, Book1_Standard 33/30
>
> So it is a posture input. In the Book postures the firmware also
> refuses the performance profile in 0x00110019. thermald --adaptive
> applies these tables on Linux (intel-rapl-mmio currently reads 42/55 W,
> i.e. "Standard"), but nothing on Linux ever reports a posture, so the
> machine always runs the laptop table. I did not write the ID myself.
>
> Related: 0x0011001F writes ODV5, and ODV5 = 255 selects a "Check"
> target capped at 20 W, which looks like a factory or service mode.
>
> Two IDs I looked at and left alone: 0x00120061 reads EC 0x2C and would
> return 0x00010002 if it is set. I tried five chargers, down to a
> USB-A 5 V source where the battery was discharging at about 9 W, and it
> always returned 0x00010001. 0x00060059 is a generic pass-through for
> EC read/write commands 0xE0..0xEF.
>
> To report a posture you need the sensors, and those were dead too: the
> ISH rejects the generic intel/ish/ish_ptl.bin ("ISH loader: cmd 2
> failed 10"). ASUS's own SensorHub driver package (5.8.62.0) contains a
> signed image, AsusSign_ishS_SI_CommonPTL_5.8.1.7779_V0018.bin. Placed
> locally as intel/ish/ish_ptl_59b8d9f2_c68ec386.bin (vendor + product
> name CRCs) it loads, and accel_3d, als and hinge show up. s2idle
> hardware residency stays where it was: 27.6 s and 27.9 s out of 30 s
> with the ISH running, against 28.4 s without.
>
> HP, Dell and Lenovo ship their ISH images in linux-firmware, ASUS has
> none. Do you happen to know someone at ASUS who could submit theirs?
> That would give every Zenbook Duo working rotation, ambient light and
> the hinge angle, and with the hinge angle a small service could feed
> 0x0006006C as Windows does.


I certainly do. Next thing I'm gonna do is write to them. Note however
that unless they give me permission I won't be able to tell you the
outcome of my conversation. Hopefully one good day a certain file
appears in linux-firmware :)

>> in the OGC discord (ex asus-linux discord, you find it on our website) people
>> are planning a GUI redesign, perhaps if you have spare time you can add an option
>> to asusd to shutdown leds when entering sleep to have a GUI on a widely used tool
> Thank you for the pointer. I am not on Discord, and GUIs are not where
> I am useful. If the sleep option lands on the asusd side (daemon or
> CLI), I would be glad to test it on this machine.

Well asusctl has a daemon and a CLI too. I don't think it's much useful on zenbooks
due to missing TDP but it is a quick way to change supported firmware attributes
and bind epp policies to power profiles in case you are interested.

If for some reason the kernel can't feed sensor data to wmi properties asusd is
the right place for doing that (albeit I don't like when userspace does things that
the kernel should be doing on its own).

> Thanks,
> Rebecca
