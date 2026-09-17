Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AF439F74
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627266; cv=none; b=NFjO+jX21oDoZTmwZl5tkv5t84GVGUz89CDnAUp1OlxWDKKosA+3+oW5CEn6d/UXmBCP+oyF1ALaUS5NK7Q+uDRdfe9/lX+S5fnRF6pzjSHO5XtEwkTDazL7ElxNM+6R3TGiCLh42n2/J3KsbRQ4O3ENgH8eEgc3MnkZl/Lmbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627266; c=relaxed/simple;
	bh=CD59rCybS2V9qydWfgaxrXTy0zFaPKUartbQbnrKBWE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYW/+ynpy4RX7VM0ouLmwMJsweqXtBbai2poZLB5JsZChS0McXCyyLkGXjk6Au/d8YvW6cKBnIFxrxnycS84RSaVpamy3Sdiyy+FYtbrmmDoAjAub/ZN/yd8CBe8suF2sbiAsDalcr/i5xttRKA2A9Z+cXKX58jWtANrmvZTzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oscillator.com.au; spf=pass smtp.mailfrom=oscillator.com.au; dkim=pass (2048-bit key) header.d=oscillator.com.au header.i=@oscillator.com.au header.b=LIXhLaJk; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oscillator.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oscillator.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oscillator.com.au header.i=@oscillator.com.au header.b="LIXhLaJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oscillator.com.au;
	s=protonmail3; t=1789627261; x=1789886461;
	bh=GaFiEGDmgijzj3h9hydippak/J54h62WkS0UcjoxdIs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LIXhLaJkasjST10o9/ldVvd3DSumlEcbTWNhB8XEAq20RktvaWjUF+0sr/u0cgrR7
	 RgQfdwiJq++RWtXuzi+QtoJ3WV8X6aalKaR5RU7brHhyUSwMG2Yos9L9d/VrlshUic
	 /WwYYM/4NH1hE/5OeuE9ZLulYtms3vdKrugMA1NdBu6spgdAzlSdA7Ar2OXxkefn5/
	 4EjziBMzTMbO+wOtlB9iW3EYCa57uQSSdBp8ygsaL2AOzjbRHbJ8xRibicAF6UZ0AS
	 dwi3JlMzZ5qE7RaOJENVb2AtF/P9hOBEU7myHilQ/BIKTl5GNDuWp26+HmKC8Qt9hA
	 7fuHZRe86D9bQ==
Date: Thu, 17 Sep 2026 06:40:55 +0000
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
From: Cameron Spencer <cameron@oscillator.com.au>
Cc: linux-input@vger.kernel.org
Subject: Re: [6.12.107] MSI G63 9SEK - Synaptics touchpad falls back to PS/2, multitouch lost at boot, fixed by delayed protocol write
Message-ID: <c931cbf5-23c8-41dd-a83f-55f972ec718d@oscillator.com.au>
In-Reply-To: <aqcCuI183ErUorYO@eggarch>
References: <4bd8e20e-e4cc-4528-9862-740a437c2687@oscillator.com.au> <aqcCuI183ErUorYO@eggarch>
Feedback-ID: 30604393:user:proton
X-Pm-Message-ID: d80e3a65047026b070e4821813886301ace8a301
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your swift reply. It appears this is not reproducible in=20
mainline:

Tested on 7.3-rc2 and the device probes as SynPS/2 at ~1.9s without=20
requiring workaround.

$ dmesg | grep -iE 'psmouse|synaptics|serio|i8042'
[=C2=A0 =C2=A0 0.514787] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:=
PS2M]=20
at 0x60,0x64 irq 1,12
[=C2=A0 =C2=A0 0.518517] serio: i8042 KBD port at 0x60,0x64 irq 1
[=C2=A0 =C2=A0 0.518524] serio: i8042 AUX port at 0x60,0x64 irq 12
[=C2=A0 =C2=A0 0.527696] input: AT Translated Set 2 keyboard as=20
/devices/platform/i8042/serio0/input/input0
[=C2=A0 =C2=A0 1.910459] psmouse serio1: synaptics: queried max coordinates=
: x=20
[..5656], y [..4728]
[=C2=A0 =C2=A0 1.939125] psmouse serio1: synaptics: queried min coordinates=
: x=20
[1284..], y [1128..]
[=C2=A0 =C2=A0 1.939132] psmouse serio1: synaptics: Your touchpad (PNP: SYN=
1509=20
SYN1500 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid=20
and hid-rmi are not used, you might want to try setting=20
psmouse.synaptics_intertouch to 1 and report this to=20
linux-input@vger.kernel.org.
[=C2=A0 =C2=A0 1.995171] psmouse serio1: synaptics: Touchpad model: 1, fw: =
8.2,=20
id: 0x1e2b1, caps: 0xf00323/0x840300/0x26800/0x0, board id: 3163, fw id:=20
2286728
[=C2=A0 =C2=A0 2.031111] input: SynPS/2 Synaptics TouchPad as=20
/devices/platform/i8042/serio1/input/input6




The previous kernel (6.12.101+deb13-amd64)=C2=A0doesn't have this issue eit=
her.


Kind regards,

Cameron

On 14/9/26 06:22, Lovekesh Solanki wrote:
> On Sun, Sep 13, 2026 at 05:23:43AM +0000, Cameron Spencer wrote:
>> I experienced an issue where my Synaptics touchpad is registered as a
>> basic PS/2 device at boot, losing all multitouch functionality
>> (two-finger scroll, gestures). Writing "synaptics" to the sysfs protocol
>> file a few seconds after boot restores the SynPS/2 extended protocol and
>> full functionality.
>>
>> System:
>>
>> - Kernel: 6.12.107+deb13-amd64
> Hi,
>
> Thanks for the report, could you see if the issue is reproducible in main=
line
> first?
>
>>   =C2=A0 =C2=A0 $ dmesg | grep -iE 'psmouse|synaptics|serio|i8042'
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.006462] i8042: PNP: PS/2 Controller
>> [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.010384] serio: i8042 KBD port at 0x60,0=
x64 irq 1
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.010392] serio: i8042 AUX port at 0x60,0=
x64 irq 12
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 1.018706] input: AT Translated Set 2 keyb=
oard as
>> /devices/platform/i8042/serio0/input/input0
>>   =C2=A0 =C2=A0 # psmouse probes at boot, fails the Synaptics handshake,=
 registers
>> as plain "PS/2 Synaptics TouchPad" (no multitouch)
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 2.384949] input: PS/2 Synaptics TouchPad =
as
>> /devices/platform/i8042/serio1/input/input6
>>   =C2=A0 =C2=A0 # psmouse-reload service runs after systemd-udev-settle =
and writes
>> synaptics to /sys/bus/serio/devices/serio1/protocol, then re-probes with
>> the Synaptics extended protocol, queries coordinates, and registers as
>> "SynPS/2 Synaptics TouchPad" (multitouch restored)
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.654815] psmouse serio1: synaptics: quer=
ied max coordinates:
>> x [..5656], y [..4728]
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.683422] psmouse serio1: synaptics: quer=
ied min coordinates:
>> x [1284..], y [1128..]
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.739382] psmouse serio1: synaptics: Touc=
hpad model: 1, fw:
>> 8.2, id: 0x1e2b1, caps: 0xf00323/0x840300/0x26800/0x0, board id: 3163,
>> fw id: 2286728
>>   =C2=A0 =C2=A0 [=C2=A0 =C2=A0 8.775128] input: SynPS/2 Synaptics TouchP=
ad as
>> /devices/platform/i8042/serio1/input/input21
> Seems like firmware is unable to answer extended queries for some time
> after initialization and just falls back to PS/2,
>
> perhaps we could just add a retry loop around
> synaptics_query_hardware() to give firmware a little extra time.
>
> Thanks,
> Lovekesh

