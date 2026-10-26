Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008860;
	b=VxRmQ2ZzGwojMHx0R0dCxNE/p2Hdd7XGr1Jxxvaneu0z8uCvq+7lMbk6WPL+7UifaMV5
	 /UaPNcAUD9axIwaS5OGVJ0SxaL7fhYRk9aZQFno8OY4ZJ6p7uaGW4AA2zhjD/rI9IxO8U
	 wdJHHqtLRkYhvOvwjlPXXU3ha3OVFKJQCUlCknRmqBmUqapXh4jPY9WXuOjSLDk7y8PLQ
	 68fOYd8R3NElrrwIcCBF58hPIshQkLGe2viMwN6bHho2g2WPu6rSUKrTZxKbotc91JQv/
	 AoMEKgY/kIBdsEqxC9aTAsVPEzhkVBfUap3MjTClipT19rair/b+cUxYYW8YIiNcsTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008860;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=FAPaL/S+HviWhVsH4Q4LtOnNt8IZUscDcNfZSJPE0Ic=;
	b=QUPCseJKRMFIddf7FfDtX9XiKe5OBDItV9IFeDe74ko2LsMfyl4RWW0+v9FEYZf8Oeqx
	 x1MluwW2Ompapezcn4Y/i59UQpsnsefYU5yxOxEO3e0Z7NlweS+RYdCErPl2mH8AFHTyM
	 MM0vQ9QQ1jsYzHFT2L/kIry9ksMv+zaJ35Cv/N8RSjylucP9uvyWdcu2thV3n6PU6vNBw
	 mcXOHTz5gj9jd0d9/JwYNbeZuB0sKNVVu1ady9iQw/fCSxoqlEcYWD9jxwasAIC1CQoRX
	 4ab42P7Y2l9gI+6DFdznonCYW4QO3jIASNnadozWh6DWbo+TNUiJmJNQmWS6SUZhwcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="JIA/WLaW";
	arc=none smtp.remote-ip=91.218.175.119
Received: from mta0.migadu.com (out-119.mta0.migadu.com [91.218.175.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C2606A336
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 10:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E00C2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JIA/WLaW
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FAPaL/S+HviWhVsH4Q4LtOnNt8IZUscDcNfZSJPE0Ic=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793008858; v=1; x=1793613658;
 b=JIA/WLaWnR/2F60qpmRq0UdqAS9piNIRd3w/SfQtZk8tSVMGbcmL3rIT6l9L7KH5HNd2r/Gd
 Xr1xnn7M/92zEaF9M7bgzdPyi5pWI1QQ6K0Ab5tTuNijEcELXxZLu6XP8/esGCTEJEtY2kgELfa
 4HYrJA0iz2q6NPghSEAcf5OU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7ca0a9e6d7d82528;
	Mon, 26 Oct 2026 10:00:57 +0000
X-Mizu-Trace-ID: 7ca0a9e6d7d82528
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 11:00:52 +0100
From: Denis Benato <denis.benato@linux.dev>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schyboll <dragonn@op.pl>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <6b5fd961-245f-4b19-9007-03af59170ca3@linux.dev>
In-Reply-To: <at8jnW4RaMPJItUK@valkosipuli.retiisi.eu>
References: <20260216175539.12415-1-denis.benato@linux.dev> <20260216175539.12415-2-denis.benato@linux.dev> <at8jnW4RaMPJItUK@valkosipuli.retiisi.eu>
Subject: Re: [PATCH 2/2] hid: asus: always fully initialize devices
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
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <6b5fd961-245f-4b19-9007-03af59170ca3@linux.dev>

26 ott 2026 10:55:55 Sakari Ailus <sakari.ailus@iki.fi>:

> Hi Benato,
>
> On Mon, Feb 16, 2026 at 06:55:39PM +0100, Denis Benato wrote:
>> ASUS has more devices other than laptop keyboards which needs
>> to be initializated: the init sequence is the same as keyboards.
>>
>> ID1 and ID2 are USB report IDs that are correctly enumerated:
>> send init commands to all devices that supports those reports IDs.
>>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>
> This patch appears to break input devices on Asus T100TA. With the patch
> applied, I'm getting a steady flow of:
>
> [=C2=A0 256.358075] usb 1-3: USB disconnect, device number 120
> [=C2=A0 257.034324] usb 1-3: new full-speed USB device number 121 using x=
hci_hcd
> [=C2=A0 257.175003] usb 1-3: New USB device found, idVendor=3D0b05, idPro=
duct=3D17e0, bcdDevice=3D 2.49
> [=C2=A0 257.175050] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D0
> [=C2=A0 257.175073] usb 1-3: Product: ASUS Base Station(T100)
> [=C2=A0 257.175091] usb 1-3: Manufacturer: ASUSTek COMPUTER INC.
> [=C2=A0 257.180978] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) =
as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:0B05:17E0.02DB/in=
put/input749
> [=C2=A0 257.266585] asus 0003:0B05:17E0.02DB: input,hidraw1: USB HID v1.1=
1 Keyboard [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:1=
4.0-3/input0
> [=C2=A0 257.270711] asus 0003:0B05:17E0.02DC: Fixing up Asus T100 keyb re=
port descriptor
> [=C2=A0 257.272302] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) =
as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:0B05:17E0.02DC/in=
put/input750
> [=C2=A0 257.327059] asus 0003:0B05:17E0.02DC: input,hiddev0,hidraw2: USB =
HID v1.11 Device [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-000=
0:00:14.0-3/input1
> [=C2=A0 257.332642] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) =
as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:0B05:17E0.02DD/in=
put/input751
> [=C2=A0 257.334115] asus 0003:0B05:17E0.02DD: input,hiddev1,hidraw3: USB =
HID v1.11 Mouse [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000=
:00:14.0-3/input2
> [=C2=A0 257.336098] asus 0003:0B05:17E0.02DD: Asus handshake 5d failed to=
 send: -71
> [=C2=A0 257.336263] asus 0003:0B05:17E0.02DD: Failed to initialize 0x5d: =
-71.
> [=C2=A0 257.336605] asus 0003:0B05:17E0.02DD: Asus failed to start multit=
ouch: -71
> [=C2=A0 257.367022] asus 0003:0B05:17E0.02DD: probe with driver asus fail=
ed with error -71
> [=C2=A0 257.367917] usb 1-3: USB disconnect, device number 121
>
> I haven't tried to debug this yet so just FYI.
>

Hi Sakari,

Thanks for testing this! Is that device of yours a touchpad? This commit ha=
s been bugfixed before and the issue is related to report sizes being sent =
as 64 bytes (and also additional unsupported messages in the case of touchp=
ads).

Can you try linux-next please? That has all bugfixes for already known prob=
lems.

Best regards,
Denis Benato

> --
> Kind regards,
>
> Sakari Ailus

