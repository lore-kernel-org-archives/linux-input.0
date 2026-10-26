Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015215;
	b=WbbyOeOEQJcDls9urU4NFyD82nEBOHQY0LuJR8XD5XJe6oq+2Mik5rHjxxtblSYOi6SH
	 oNAJZQpasrVR1M5C3xZsUVzJFOIYa3by4gZ2mr2qT/NS0FYY0YsofRo55wONmUU0g3uBs
	 UGmZcQJddi6Ow4RMiv6eAOVuyn/cqiFpQ+SNKxMYxB9ahjIFCWe033B0ZDv45Cts9yqbB
	 TEnDblgGhDs/AJWVelZIbfyaydCiWXkQoDPv+vkRPsjw1uFuPmN6syDqqK8iBivjBHzCh
	 +7YSgFyWDNdQ0hPEaIY8slwpRxITxbXyldcdlDd0xfS8prtuUT2/4aDnHXgWPk+F9yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015215;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=aA+RABdiaQH3eDPzAi8KDo+ifW5jkwRRbEaeVSZdO2o=;
	b=WDs5Vz4oxZWNpj5iHhLxOf61zi8SQpA4ZprzROZHzFB+iSyydio3LW0WO543tz3jQc/j
	 WFiGvY7JpTscGvKW1RHjEhrxCG5YYLVkRJeoGRfJGabcCLyTXVaCJN9WBx7GyR+30o2Xu
	 W/BWllpW+LY8PDLxaMk1kN9yMzOlQYBYxvDWtRImFfiNJByHG0wqAId6T+6MPDsf89GMp
	 Sv7MqZibWg5xnw23or2f4mCxZY4VYwRDN1qMVYhIgQ/3TLWK3eVkdzlR9Mq8lNHEA3i7+
	 qnXhmfpehRykSelcYI5YIF//Y0EVesBuq0iqGlUG6vo3kWYrlwIJfX9ox6OPlQgN66A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.143
Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CD606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 11:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 941CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aA+RABdiaQH3eDPzAi8KDo+ifW5jkwRRbEaeVSZdO2o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793015206; v=1; x=1793620006;
 b=iGIlgk1Apfxec717PTeu5qTQ0No/XM1AwL20j0qOYYpL2UtrJ13UaVH0mpgg25aFTPlAw9lA
 4J3PuCbM21FIioloSUJqyrUyAKph7wynxIixa5yHTh9sXs2RIMhL+3HKdHmQ5KsTbzVgmKmCMZQ
 uOcvIhw97h7pXfsjX8YzDWrQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7e4d008dd8e6585e;
	Mon, 26 Oct 2026 11:46:46 +0000
X-Mizu-Trace-ID: 7e4d008dd8e6585e
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 12:46:44 +0100
From: Denis Benato <denis.benato@linux.dev>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schyboll <dragonn@op.pl>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <9556d920-a04c-4919-8c16-c346fbd0bf75@linux.dev>
In-Reply-To: <at86T3plbYCnXRAl@valkosipuli.retiisi.eu>
References: <20260216175539.12415-1-denis.benato@linux.dev> <20260216175539.12415-2-denis.benato@linux.dev> <at8jnW4RaMPJItUK@valkosipuli.retiisi.eu> <6b5fd961-245f-4b19-9007-03af59170ca3@linux.dev> <at86T3plbYCnXRAl@valkosipuli.retiisi.eu>
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
X-Correlation-ID: <9556d920-a04c-4919-8c16-c346fbd0bf75@linux.dev>

26 ott 2026 12:39:44 Sakari Ailus <sakari.ailus@iki.fi>:

> Hi Denis,
>
> Thanks for your reply.
>
> On Mon, Oct 26, 2026 at 11:00:52AM +0100, Denis Benato wrote:
>> 26 ott 2026 10:55:55 Sakari Ailus <sakari.ailus@iki.fi>:
>>
>>> Hi Benato,
>>>
>>> On Mon, Feb 16, 2026 at 06:55:39PM +0100, Denis Benato wrote:
>>>> ASUS has more devices other than laptop keyboards which needs
>>>> to be initializated: the init sequence is the same as keyboards.
>>>>
>>>> ID1 and ID2 are USB report IDs that are correctly enumerated:
>>>> send init commands to all devices that supports those reports IDs.
>>>>
>>>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>>>
>>> This patch appears to break input devices on Asus T100TA. With the patc=
h
>>> applied, I'm getting a steady flow of:
>>>
>>> [=C2=A0 256.358075] usb 1-3: USB disconnect, device number 120
>>> [=C2=A0 257.034324] usb 1-3: new full-speed USB device number 121 using=
 xhci_hcd
>>> [=C2=A0 257.175003] usb 1-3: New USB device found, idVendor=3D0b05, idP=
roduct=3D17e0, bcdDevice=3D 2.49
>>> [=C2=A0 257.175050] usb 1-3: New USB device strings: Mfr=3D1, Product=
=3D2, SerialNumber=3D0
>>> [=C2=A0 257.175073] usb 1-3: Product: ASUS Base Station(T100)
>>> [=C2=A0 257.175091] usb 1-3: Manufacturer: ASUSTek COMPUTER INC.
>>> [=C2=A0 257.180978] input: ASUSTek COMPUTER INC. ASUS Base Station(T100=
) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:0B05:17E0.02DB/=
input/input749
>>> [=C2=A0 257.266585] asus 0003:0B05:17E0.02DB: input,hidraw1: USB HID v1=
.11 Keyboard [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00=
:14.0-3/input0
>>> [=C2=A0 257.270711] asus 0003:0B05:17E0.02DC: Fixing up Asus T100 keyb =
report descriptor
>>> [=C2=A0 257.272302] input: ASUSTek COMPUTER INC. ASUS Base Station(T100=
) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:0B05:17E0.02DC/=
input/input750
>>> [=C2=A0 257.327059] asus 0003:0B05:17E0.02DC: input,hiddev0,hidraw2: US=
B HID v1.11 Device [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0=
000:00:14.0-3/input1
>>> [=C2=A0 257.332642] input: ASUSTek COMPUTER INC. ASUS Base Station(T100=
) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:0B05:17E0.02DD/=
input/input751
>>> [=C2=A0 257.334115] asus 0003:0B05:17E0.02DD: input,hiddev1,hidraw3: US=
B HID v1.11 Mouse [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-00=
00:00:14.0-3/input2
>>> [=C2=A0 257.336098] asus 0003:0B05:17E0.02DD: Asus handshake 5d failed =
to send: -71
>>> [=C2=A0 257.336263] asus 0003:0B05:17E0.02DD: Failed to initialize 0x5d=
: -71.
>>> [=C2=A0 257.336605] asus 0003:0B05:17E0.02DD: Asus failed to start mult=
itouch: -71
>>> [=C2=A0 257.367022] asus 0003:0B05:17E0.02DD: probe with driver asus fa=
iled with error -71
>>> [=C2=A0 257.367917] usb 1-3: USB disconnect, device number 121
>>>
>>> I haven't tried to debug this yet so just FYI.
>>>
>>
>> Hi Sakari,
>>
>> Thanks for testing this! Is that device of yours a touchpad? This commit=
 has been bugfixed before and the issue is related to report sizes being se=
nt as 64 bytes (and also additional unsupported messages in the case of tou=
chpads).
>>
>> Can you try linux-next please? That has all bugfixes for already known p=
roblems.
>
> I can confirm the issue has been fixed in next.
>

Splendid! Thanks for testing!

A few hours ago I sent the v11 of the ally patchset that also detects the r=
eport size from the hid device so these things doesn't happen anymore, coul=
d you try it please?

It would be very good to know that no more regressions are being introduced=
.

> --
> Kind regards,
>
> Sakari Ailus

