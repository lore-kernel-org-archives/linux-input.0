Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481D289E13
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673629; cv=none; b=jRsJIwHEF88d/7Pg/R72WiQtAWb0F36ZcPQEKmrKNY+fZWXdSJTJfYNaAsh1/fUGRU+zTBEPqnKELSkQrPlIBLQdOuvhJ2RVlzY3da4/HR5sJ9FvFwLyPvRE1JaVIUu46EwZcDoUNVoLqJJvbqxcGfPk+rdnBUMA3TGmOEVpT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673629; c=relaxed/simple;
	bh=QXPCk3rXxotmZT+RkPeVScNXN4bCDnUf0Sd2+ZSbVUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFFgNZRGX0QPmruh5wN1J+6PbMQoAxv6waL+B+O4K6uN311lTxofvKWxU0pQ/sgOFKheo/kYj8dJUmyWedmkUR3eLc+D6ER7FCigi0cu16S9F2LJRMWa9Z7qFwcxYs180002YbqXgDgVFwIcU5qgo0GGKujL2n3KOf3uq7WIOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b=bUXENTt6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b="bUXENTt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1778673625; x=1779278425; i=h.judt@gmx.at;
	bh=KlYnex8svuPq1uk8q7N9qSyuzN574S2x35Wvq7NM7LY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bUXENTt6OxOLbyrDsf6JeIUL+57crlE66Z2XLi6KNnMGlnBNjCHSJGXAMWr5q4hG
	 Jy0TrWTFN2NoPeyxm1FrXMXiK89VbdTYX0Z75SFy6XCCErt2Xzu0r1xZzkxywwjsa
	 srbf2BSRsIYKwwQTKUwSTYGkryR1zFATUgd0gAKVonLes+Yv8hAFzTqY7cB/uQtp2
	 HoIK9IRs0dszfD+wuAB/hfWIsqOF7JSXyZKjsYv9SV0pEi0ogqjyYP1kyGgo84I2x
	 4oWd6iXTDih4oDYFAaUmbYW3yfeg0WlhymyiaaNgN5oD3b+sSQB7GwybtBNWNiUBT
	 +1AbjvNn8miIBTgM8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1xF6KD2LAS-012nqC; Wed, 13
 May 2026 14:00:25 +0200
Message-ID: <9ce2c701-21fd-4eec-967a-5f0212f6fcf4@gmx.at>
Date: Wed, 13 May 2026 14:00:24 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2] HID: Add force feedback support for Speedlink
 Cougar Vibration Flightstick
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
References: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
 <1q46pn22-177p-9no9-q4p7-4qq8n38po504@xreary.bet>
Content-Language: de-AT
From: Harald Judt <h.judt@gmx.at>
Autocrypt: addr=h.judt@gmx.at; keydata=
 xjMEWz9DYxYJKwYBBAHaRw8BAQdAKS36MI1JSuMxtk7tkZ2/NK1C9te1XJ8bBlB9qF4blEbN
 G0hhcmFsZCBKdWR0IDxoLmp1ZHRAZ214LmF0PsKWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAFiEE4HNt2P9AnPIGZRHUT/+rIbhYCr0FAmStFG8FCRLT0owACgkQT/+rIbhY
 Cr1dYwEAsT/9SLGebsLz4TIuYaDY7c4ou+i7Stae6FIb62NXw7UBAPopYK3pJuyjhvK8qb3N
 FQeZyDrHeJLvOWEoj5OYsLIIzjgEWz9DYxIKKwYBBAGXVQEFAQEHQA7/uzYBE88LdCm19AaX
 q46nMKkhxM5CZ2YAa1uC5l97AwEIB8J+BBgWCAAmAhsMFiEE4HNt2P9AnPIGZRHUT/+rIbhY
 Cr0FAmStFMkFCRLT0uYACgkQT/+rIbhYCr12kAD9HnfrVNMxwa8LWtpKCiv4+zk1ujthlZZm
 G75GoPWofXEBAMQ8kqpJDk2/DH4qT0ZneIT5SnQPt5ZtAFtpX6XOa0oB
In-Reply-To: <1q46pn22-177p-9no9-q4p7-4qq8n38po504@xreary.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrISdIZhvN2vn+Qh+TJjFUE6Wci4eAIxQx7+dp5zLXGjzxhF435
 r7HmKiv124cBYaA1wWZTsIRLwsy7z7yDRCtdQLEe3CgF0J7J1n5ketL+5ts2NbKign1GgUy
 UVNgHnRawn2YrZq6Gs8rplH4/Neuj6o6TYkh4V9r2y47pSKg2miFJfk11jRSEeq0qkz2jzs
 3JyEuMvgmb0VRIDaaTFQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pqjo4Y+6ikE=;Tg8Xu2whK3C8/yzKESd1lvoMn90
 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
 wVHJahCl5ZuBrEaqN4GtiDflFprQ+vfLNQAs=

Hi,

Thanks for reviewing this.

Am 12.05.26 um 18:11 schrieb Jiri Kosina:
> On Fri, 8 May 2026, Harald Judt wrote:
[...]

>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 04420a713be0..b4e2c8f67728 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -406,6 +406,14 @@ config HID_GEMBIRD
>>  	help
>>  	Support for Gembird JPD-DualForce 2.
>> =20
>> +config HID_GEMBIRD_JOY_FF
>> +	tristate "Gembird Joysticks force feedback support"
>> +	depends on USB_HID
>> +	select INPUT_FF_MEMLESS
>> +	help
>> +	Force feedback support for Gembird (Vendor ID 0x12bd) based devices:
>> +	  - Speed Link Cougar Vibration Flightstick (SL-6630)
>> +
>>  config HID_GFRM
>>  	tristate "Google Fiber TV Box remote control support"
>>  	help
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 361a7daedeb8..593a429661ed 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -54,6 +54,7 @@ obj-$(CONFIG_HID_EVISION)	+=3D hid-evision.o
>>  obj-$(CONFIG_HID_EZKEY)		+=3D hid-ezkey.o
>>  obj-$(CONFIG_HID_FT260)		+=3D hid-ft260.o
>>  obj-$(CONFIG_HID_GEMBIRD)	+=3D hid-gembird.o
>> +obj-$(CONFIG_HID_GEMBIRD_JOY_FF)	+=3D hid-gembird-joy.o
>=20
> Would it be possible to link this support to hid-gembird if enabled?

The problem I encountered is that gembird !=3D gembird, that is,
the USB Vendor IDs differ. These are defined:

#define USB_VENDOR_ID_GEMBIRD			0x11ff
#define USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2	0x3331

#define USB_VENDOR_ID_GEMBIRD_JOY		0x12bd
#define USB_DEVICE_ID_GEMBIRD_JOY_SL_6630	0xa02f

What would be the best way to solve this? Can my implementation
reside in separate files or should it be integrated into the
existing hid-gembird implementation? I am pretty new to
writing kernel modules, and doing it separately simply seemed
more suited for an easier start...

Regards,
Harald

=2D-=20
`Experience is the best teacher.'

PGP Key ID: 4FFFAB21B8580ABD
Fingerprint: E073 6DD8 FF40 9CF2 0665 11D4 4FFF AB21 B858 0ABD
