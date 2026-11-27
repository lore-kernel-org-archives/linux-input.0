Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771841;
	b=WfKVgXjN6MBClrzDygbkiWhWJpYbVTUujPHzCi0AA2bLw9Szb1zU3N6cXcLyVbgDwYVH
	 4gX2MdrxCDoDqF0MkvDhabpBSAmlh9PN2wadcHqJ+D26+NlHA+aOJsNusAqUS+eqi9bJn
	 PpnaqTzEubwUxJFwx5FTztMM9CmLQK+a7zHQBV556FXF7TXFiuYv6Pq0xzbQE0h7kNUz9
	 JsfunSSRL8Lz8nx+lsN0O0a2xhFAk9yQ2T/Aov555KvjlF4UrL739URjAm9l0FDuVdhAd
	 tqSmCnicK6ldW73jhzEPR5HOG3EAzIWZgDCHOvaXUxHHpOJCR73I/opVgYvCBUiqKFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771841;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID;
	bh=2xhSRWSAoiesLs9Vpe5mHy2li4gBysXZMjxKw/MYzPI=;
	b=MHLmtSi4qIRbnWrobDIqd4ECkdwrkgPhKt9jjDM7Cqk4XRX6ZS9yoaxG8Ap9d+w8PHew
	 fyZ7TilaBfpmeJkeWSahLdwXXSiJE2YShTKERO2qmlikzBF3eT9E0vKLOyxsC1YFOpDQb
	 DeRXlgxtz93V26WKDuPTxLr1k6T6WglK3NybLAyOAz4FsEQvnL1Y1rFDdq/971IKaB+pq
	 Sq4zLx8LNjedVClXdEOqa7zqt+FdjWMO0dHUmLX8jhFwtKuWUOtq0SDUzrBdAZnKRHpA6
	 htSy/jNGatCHHJD/f7uA/Er+qKQbjiS7w+ykR1Jku93ybjxAxPkO0L7/Pc+gmyjnEeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tutamail.com;
	spf=pass smtp.mailfrom=tutamail.com;
	dkim=pass header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=RLPkiKuo;
	arc=none smtp.remote-ip=185.205.69.213
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E2606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 09:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=RLPkiKuo
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 6DBCA1AD41B61
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 10:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1795771839;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=2xhSRWSAoiesLs9Vpe5mHy2li4gBysXZMjxKw/MYzPI=;
	b=RLPkiKuoy2pH0H3oBbI7unt+tQJ4kMq+uvvnhLV6TmCXD8IWSQDC7bXmqUO3o6DZ
	vshkGznD4w9by5/ne8i60ZwjLj0A9YRSJ/Qb4ApvTeKDAPyWz0ri10jnuvu5OnMxn7+
	nrXtYPG6PJYxRfNNu0pYgaTSfWoN3sm5GkDUczIcGySxElfSES8VNrRXM/hGmwtKr3a
	9C7qK88dRJJo0u8BgLnYJH43f0VzRj0ucrochGXOQUhfew+2fd7uWa2PY0qEwCS/Y6F
	4eCoAi+1ZKkDdGx1dT0AfNZYjGNkfRROeRyudH2f6iid1hvVrHGYcFnd0gzVMvYtPVt
	EZcJr4YcoQ==
Date: Fri, 27 Nov 2026 10:30:39 +0100 (CET)
From: willowswaving@tutamail.com
To: Linux Input <linux-input@vger.kernel.org>
Cc: Jikos <jikos@kernel.org>, Bentiss <bentiss@kernel.org>
Message-ID: <P7RKrQc--F-9@tutamail.com>
In-Reply-To: <P7GtZql--F-9@tutamail.com>
References: <P46njqS--N-9@tutamail.com> <P4DHMrF--F-9@tutamail.com> <P5pmaU5--J-9@tutamail.com> <P5psz0r--F-9@tutamail.com> <P7GsBwf--R-9@tutamail.com> <P7GtZql--F-9@tutamail.com>
Subject: Re: [RFC] HID: uclogic: Add support for Xencelabs Pen Display
 (28bd:520d) and request for switch-to-vendor-mode sequence
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
Feedback-ID: 015fe4ab774a31809b4b05b8c610ead356bcc03e5c866e6007fd3e8866c7c0a22bb5af78b76e2b2d682867fe72df3c2e2eae226386f9c0a8fc7fe2cb63b896dd32:TurnOnPrivacy!:tutamail


Hello,


I have an important update regarding this device. I sent the device back to=
 the manufacturer and they reflashed the firmware.



1. The Product ID has changed from 520d to 520a.
2. The device no longer requires a magic-byte "switch-to-vendor-mode" comma=
nd. It now immediately exposes the pen interface and sends raw HID reports.



The kernel currently binds hid-generic to it (as a Mouse/Keyboard), but the=
 raw data from /dev/hidraw shows that the pen is working perfectly. I have =
attached a small hexdump sample.


Based on my analysis of the raw data, the report format (Report ID 2, 16 by=
tes) seems to be:


Byte 0: Report ID (02)


Byte 2-3: X coordinate


Byte 4-5: Y coordinate


Byte 8: Pressure (changed from 00 to ff when pressing the pen)


Byte 12-15: ASCII Serial Number (G8C5)


Could you please help adding 28bd:520a to hid-uclogic? Since the device sen=
ds data directly now, it might just need a standard UGEE v2 report descript=
or fixup without any initialization commands.


I can provide the full hexdump or test any patches if you wanna, belw is ju=
st the contents from line 10 to line 30 for your reference.


Thank you!

Willows
2026/11/25 16:50 =E6=9D=A5=E8=87=AA willowswaving@tutamail.com:

> Update: The manufacturer reflashed the firmware. The device PID is now ch=
anged to> =C2=A0> 28bd:520a> . The hardware is working and is sending raw H=
ID reports without needing any magic-byte switching.=C2=A0 It seems we just=
 need to add the 520a PID to hid-uclogic and provide the correct report des=
criptor mapping.
>
> Below is the hexdump information for your reference:
>
> Thanks again for taking your time and energy!!
> Regards,
> Willows
>
>
>
>>
>>
>> 2026/11/7 20:03 =E6=9D=A5=E8=87=AA willowswaving@tutamail.com:
>>
>>>
>>>
>>>> Subject: Re: [RFC] HID: uclogic: Add support for Xencelabs Pen Display=
 (28bd:520d) and request for switch-to-vendor-mode sequence
>>>>
>>>> Hello,
>>>>
>>>>
>>>> I am writing to send a friendly ping regarding the support for the Xen=
celabs Pen Display (28bd:520d). I understand you are very busy, and I just =
wanted to check if there is any update or if there is any additional inform=
ation I can provide to help move this forward.
>>>>
>>>>
>>>> The device is still available for testing. I would be happy to try any=
 patches or collect further USB traces if needed.
>>>>
>>>>
>>>> Thank you for your time.
>>>>
>>>>
>>>> Best regards,
>>>>
>>>> Willows
>>>>
>>>> 2026/10/18 17:13 =E6=9D=A5=E8=87=AA willowswaving@tutamail.com:
>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I would like to report a missing device support in the hid-uclogic
>>>>>> driver, and ask for guidance on how to properly add it.
>>>>>>
>>>>>> Device information
>>>>>> ------------------
>>>>>> =C2=A0 Name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xencelabs Pen Displ=
ay
>>>>>> =C2=A0 Vendor ID:=C2=A0 0x28bd (Hanvon Ugee / XP-Pen)
>>>>>> =C2=A0 Product ID: 0x520d
>>>>>> =C2=A0 Firmware:=C2=A0=C2=A0 20250121(230322)
>>>>>> =C2=A0 Model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UG902_LPH2412_P10
>>>>>>
>>>>>> Problem
>>>>>> -------
>>>>>> The device is not handled by hid-uclogic. With hid-generic, the devi=
ce
>>>>>> is registered only as a mouse and no pen events (ABS_X, ABS_Y,
>>>>>> ABS_PRESSURE, ABS_TILT) are reported to userspace.
>>>>>>
>>>>>> When I add the device ID to hid-uclogic-core.c, the driver binds, bu=
t
>>>>>> the resulting interface is still a mouse. evtest shows no pen events=
.
>>>>>> This suggests the device is still in "firmware mode" and never gets
>>>>>> switched into the vendor reporting mode that exposes the pen interfa=
ce.
>>>>>>
>>>>>> Key observations from testing
>>>>>> -----------------------------
>>>>>> 1. lsusb reports only one interface (bNumInterfaces =3D 1, interface=
 0,
>>>>>> =C2=A0=C2=A0 HID class, mouse). It has only two interrupt endpoints:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x81 (IN, 64 bytes)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x01 (OUT, 64 bytes)
>>>>>> =C2=A0=C2=A0 Note: There is NO endpoint 0x03, which is the endpoint =
used by
>>>>>> =C2=A0=C2=A0 uclogic_ugee_v2_probe_endpoint in hid-uclogic-params.c.=
 Any attempt
>>>>>> =C2=A0=C2=A0 to send magic bytes to 0x03 fails with "Invalid endpoin=
t address".
>>>>>>
>>>>>> 2. Reading the string descriptor at index 0x64 under LANGID 0x0409
>>>>>> =C2=A0=C2=A0 successfully returns a 14-byte binary blob (13 bytes of=
 content).
>>>>>> =C2=A0=C2=A0 Raw HEX: 0e03289a78e60300ff1fd8130100
>>>>>> =C2=A0=C2=A0 (Other indexes return normal strings like the serial nu=
mber and
>>>>>> =C2=A0=C2=A0 "hanvon ugee Tech"). Reading index 0x64 does NOT switch=
 the device.
>>>>>>
>>>>>> 3. Sending the UGEE v2 magic bytes (02 b0 04 00 00 00 00 00 00 00)
>>>>>> =C2=A0=C2=A0 via SET_REPORT (Feature 0x02, Output 0x02, Feature 0x03=
) returns
>>>>>> =C2=A0=C2=A0 success, but the device never re-enumerates.
>>>>>>
>>>>>> 4. A vendor-specific control request (bRequest 0xb0, wValue 0x0402)
>>>>>> =C2=A0=C2=A0 times out.
>>>>>>
>>>>>> 5. Note: Sending unexpected control transfers to this device can cau=
se
>>>>>> =C2=A0=C2=A0 the USB HID interface to hang. It requires a complete p=
ower cycle
>>>>>> =C2=A0=C2=A0 (unplugging USB and power) to recover.
>>>>>>
>>>>>> Request
>>>>>> -------
>>>>>> Could someone with access to the Xencelabs USB documentation, or
>>>>>> someone who has reverse-engineered the 520d, share the correct
>>>>>> sequence to switch this device into vendor mode?
>>>>>>
>>>>>> Specifically:
>>>>>> =C2=A0 - Is the 0x64 string descriptor read the right trigger, or is=
 a
>>>>>> =C2=A0=C2=A0=C2=A0 specific control transfer required?
>>>>>> =C2=A0 - If a control transfer is needed, what is the correct bReque=
st,
>>>>>> =C2=A0=C2=A0=C2=A0 wValue, wIndex, and endpoint?
>>>>>> =C2=A0 - Are there known quirks for this device?
>>>>>>
>>>>>> If a capture from the Windows driver is needed, I can provide one.
>>>>>> If you have any hints, I will be happy to prepare a proper patch
>>>>>> with hid-uclogic-params.c changes and re-test.
>>>>>>
>>>>>> I am attaching the text files with:
>>>>>> =C2=A0 - lsusb -v output for 28bd:520d
>>>>>> =C2=A0 - the raw HID report descriptor (usbhid-dump)
>>>>>> =C2=A0 - the string descriptor enumeration (showing 0x64)
>>>>>> =C2=A0 - dmesg logs showing the binding behavior.
>>>>>>
>>>>>> Thank you very much for your time.
>>>>>>
>>>>>> Best regards,
>>>>>> Willows
>>>>>>
>>>
>>>
>>
>>
>
>

