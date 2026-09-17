Received: from mail-lr2-f16.google.com (mail-lr2-f16.google.com [74.125.230.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DC4A49B8
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649490; cv=none; b=LtTSN72crhCIH7ZKn7iF5Y1aBWggaItLPbVRgc3QbTGnzBON9JIpeCL8ugnUS73ioIxhIb2bq216Xd95nzS8YhUw1tHBvgHKFvPwi123Pk2hAukAvHH8VcRKo6OVYlIw3DGAhIfsKVutwftgLr9AYja7gSrBP42zahNlPERaE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649490; c=relaxed/simple;
	bh=lya9hUQribn86qV/vY8E4rMIsiFiJWN2gyg2n0DTpyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0IwWChXSIjNxPVuIdA60zsAwmTabd+rbsHCq9HNy1LF6oAzwGwjOyRbhr78IhedNXz8coXT88UxM4BJdnTpC5mvKZeAZ9yS3nXCCb1oUCAASPwd6+isPjNbGpVu+KYReU3aXCHqsVAHy+umeB5wf/gkQCYcXarT1oeilyqtB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMwn9Ruj; arc=none smtp.client-ip=74.125.230.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMwn9Ruj"
Received: by mail-lr2-f16.google.com with SMTP id 38308e7fff4ca-3a2ff176d5bso6552431fa.2
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789649467; x=1790254267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrfHKnMW895q6rSkZdAXjFdwCDMndBehyVRWIOhGbP0=;
        b=eMwn9RujnnOmVt+oHDJ7IbfT3KoU3lDFj5/ACthUtvHS4TG8It+qv80owwWi+J/74o
         MnuxO/FGpn/CzUcORjqcUX16AZvih0v9py3jy5hGaXL9cbQhiCPMU9/Z+jHGyXMM7mKA
         Bj+fBtdsiVOKBM6sTzjAzyrPP5t+GzsoAJKFBzHB4G9AYcQwDCteOR7nUNrTIiqNq+Ha
         ltqZPu6tc+q83sjl2x0okDve5xVBoJNyTJKx5vVg9cqPjeaUH+h3Dg2S984dShCX+ArJ
         TKJTLVz1dZ56VewaQrpiNjQrnRNRT1eANPmjZ49siY5JjaYoxdfSe76oflQFdyRbZFsI
         MOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649467; x=1790254267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RrfHKnMW895q6rSkZdAXjFdwCDMndBehyVRWIOhGbP0=;
        b=gmhMCE0wjnUym+FZ1dU+LgCuPjjcNEnVWKTVVTCChtFaO8Xdx+ePOajijGHJQJVDST
         BIMHO2e6wxUi3RGwX8FtEBEHRDczH0yr2Hj5TN1hd22VEHH5hHG+D8ns4yvW4bzWGHSo
         FM1udfX35u4MHUNSFI+rPHGosmQxpoWK7mJh67cQ60OZsSZ4bXA6Hnn6U2t9VhTWpvjZ
         HCuLxzeeFlhWCY112xLxExmdWZKOo5u/oc1PxvqLSuox9pgulFhAAKdw/M9ooa4N89Q2
         Q59GNrhZ5OVLLIg6/fc5Qa56ymZxnXAezrb+JfyFEphmWy6X9FA/MAC4EWSvgXJWSmKU
         J/lg==
X-Forwarded-Encrypted: i=1; AKwUvBwikoNqTF9Ug7Z7G2sA+uTFPwWEdIulK5mGdq/3lbaqe84kfXZ0DgiPID0swPSHHXvSz2nWOMXJ3x+LOA==@vger.kernel.org
X-Gm-Message-State: AFuF++m7JBXSj3/0TNbqjD1z7M3Tz7sBB1B8X1+ihlpuQUappKRWCFl5
	H79FFAQXWwKRuiyRBbk4FQR+OEJ4qLuELmrZnRQ+cCTKrTNAbWhQ+PdD
X-Gm-Gg: AYBFou0x3834y48ZGll1Pd3Tqv7diej7YVt0VCa5iUxabCOPfG/lLSH+xmj2IVqBex9
	N3fdsXV41opiVmsnbZMKRfBi5M2lIFWauzsyQx6NcFamf8ooCzKKnN9+ViaVhcPLqvDjUeyWLL+
	Hn7n+c77l3iqJ8cihwladVm0fxBf0AwvmQDEUuOkKzf0a5TuHICAVy6Wtj6GLxATLLdbhMFr8oy
	vwj9nEXl+k4lQS+21bWEgtORJeiyqmmiW3BXU23eKeLjwt8u9XDIlICRBDVkRpJ8BqsoX5Jzb9K
	mlXhEIX+hWEv0G/YVjolgUXUFUOfHflu+UzWR9OB1WJ9bvZAW9/7zWTef3sY0kmU3v9fQmV6YlQ
	9qWyZ7H/isQY2hdx8/e4eoN9158vrR/xetdiLGedNER8EHTKn5iwSlSjMYZXPGiVDPaqb44v+8h
	iOd4DdtzQE1TBLuTF52g8RSWI1GjlGbvEstJFTUeGQR/41UpmxTUUbIZAgLMZe2dS0Oo/O28c+5
	Vimo4Qqy/xL
X-Received: by 2002:a05:651c:31c5:b0:3a5:f044:fcbd with SMTP id 38308e7fff4ca-3a5f045016dmr3898711fa.23.1789649466088;
        Thu, 17 Sep 2026 05:51:06 -0700 (PDT)
Received: from [96.96.0.0] ([104.28.232.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5dafa9aecsm13596751fa.26.2026.09.17.05.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:51:05 -0700 (PDT)
Message-ID: <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com>
Date: Thu, 17 Sep 2026 15:51:03 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com> <aquWNXpJuQr8HLBU@beelink>
Content-Language: en-US
From: Ruzal <daminovruzal7@gmail.com>
In-Reply-To: <aquWNXpJuQr8HLBU@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/17/26 10:30 AM, Benjamin Tissoires wrote:
> Hi,
>=20
> sorry it looks like this one fell through the cracks.
>=20
> On Aug 19 2026, Ruzal Daminov wrote:
>> The Goodix GXTP7863 touchpad controller (VID: 0x27c6, PID: 0x01e0)
>> found on Honor MagicBook laptops (e.g. FMI-76 / X14 Plus)
>> was missing from the mt_devices[] table.
>>
>> As a result, it was claimed by hid-generic, which erroneously mapped
>> the vendor telemetry collection (0xFF01) to an input node, translating=

>> the 1-Hz heartbeat timestamp into an endless loop of phantom
>> KEY_BRIGHTNESSUP autorepeat events.
>>
>> Fix this by:
>>  1. Adding I2C_DEVICE_ID_GOODIX_01E0 to hid-ids.h.
>>  2. Adding the device to mt_devices[] with MT_CLS_WIN_8 so hid-multito=
uch
>>     claims the touchpad and retains full Win8 PTP quirks.
>>  3. Filtering out the 0xFF01 vendor collection in mt_input_mapping()
>>     so the telemetry report is ignored and no phantom input node is
>>     created.
>=20
> FWIW, ou should not describe exactly what the patch does in the commit
> description. We can read the code :)
>=20
>>
>> Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).
>>
>> Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
>> ---
>> v3 -> v4:
>>  - Retain MT_CLS_WIN_8 to preserve Win8 PTP quirks, while explicitly
>>    filtering out field->application =3D=3D 0xff010001 in mt_input_mapp=
ing()
>>    to ignore the vendor telemetry collection.
>> v2 -> v3:
>>  - Use MT_CLS_DEFAULT to keep export_all_inputs false.
>> v1 -> v2:
>>  - Move entry to alphabetical order in the Goodix section.
>>  - Declare I2C_DEVICE_ID_GOODIX_01E0 in hid-ids.h.
>>
>>  drivers/hid/hid-ids.h        |  1 +
>>  drivers/hid/hid-multitouch.c | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 1059922baaacd2..60d9d524cd2e15 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -562,6 +562,7 @@
>>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>> =20
>>  #define I2C_VENDOR_ID_GOODIX		0x27c6
>> +#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
>>  #define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
>>  #define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
>>  #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch=
=2Ec
>> index edb37b4c867e4b..d2ada08a6b01bf 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -1543,6 +1543,12 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
>>  	if (ret !=3D 0)
>>  		return ret;
>> =20
>> +	/* Ignore Goodix FreeTouch vendor telemetry collection */
>> +	if (hdev->vendor =3D=3D I2C_VENDOR_ID_GOODIX &&
>> +	    hdev->product =3D=3D I2C_DEVICE_ID_GOODIX_01E0 &&
>> +	    field->application =3D=3D 0xff010001)
>> +		return -1;
>> +
>>  	/* let hid-core decide for the others */
>>  	return 0;
>>  }
>> @@ -2460,6 +2466,11 @@ static const struct hid_device_id mt_devices[] =
=3D {
>>  		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
>>  			USB_DEVICE_ID_GAMETEL_MT_MODE) },
>> =20
>> +	/* Goodix GXTP7863 Touchpad */
>> +	{ .driver_data =3D MT_CLS_WIN_8,
>> +	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
>=20
> I'm puzzled here: HID_GROUP_ANY? How can this even be working with hid-=
multitouch?
>=20
> Are you sure the touchpad part is not already handled by hid-multitouch=
, but only
> the telemetry/phantom event gets assigned to hid-generic?
>=20
> Can you share the report descriptors of all nodes with hid-recorder so =
I
> can understand why we suddenly have to map to non multitouch devices.
>=20
> Cheers,
> Benjamin

Hi Benjamin,

Thanks for pointing that out. You were completely right, and I apologize
for the inaccurate explanation in my previous commit messages.

I re-checked the device binding: the touchpad is indeed claimed by
hid-multitouch out of the box under HID_GROUP_MULTITOUCH_WIN_8 (using
MT_CLS_WIN_8). It was never claimed by hid-generic.

The actual root cause is that MT_CLS_WIN_8 sets `.export_all_inputs =3D t=
rue`.
Because of this, hid-multitouch exports the vendor application collection=

(Usage Page 0xFF01, Usage 0x01, Report ID 8) to an input node.

As captured in the hid-recorder trace below, the firmware sends a 1-Hz
heartbeat packet on Report ID 8:
  E: 000000.000000 30 08 ab 00 00 2a ...
  E: 000001.006503 30 08 ab 00 00 2a ...
  E: 000002.012748 30 08 ab 00 00 2a ...

hid-input interprets these changing payload bytes as key events, resultin=
g
in the endless KEY_BRIGHTNESSUP autorepeat loop.

So, adding the device entry with HID_GROUP_ANY to mt_devices[] is indeed
completely redundant. The only thing needed is to ignore the 0xFF01 vendo=
r
collection so that no phantom input node is created for it.

Here is the report descriptor and event recording from hid-recorder:

# GXTP7863:00 27C6:01E0
# 0x05, 0x01,                    // Usage Page (Generic Desktop)        0=

# 0x09, 0x02,                    // Usage (Mouse)                       2=

# 0xa1, 0x01,                    // Collection (Application)            4=

# 0x85, 0x01,                    //  Report ID (1)                      6=

# 0x09, 0x01,                    //  Usage (Pointer)                    8=

# 0xa1, 0x00,                    //  Collection (Physical)              1=
0
# 0x05, 0x09,                    //   Usage Page (Button)               1=
2
# 0x19, 0x01,                    //   Usage Minimum (1)                 1=
4
# 0x29, 0x02,                    //   Usage Maximum (2)                 1=
6
# 0x15, 0x00,                    //   Logical Minimum (0)               1=
8
# 0x25, 0x01,                    //   Logical Maximum (1)               2=
0
# 0x75, 0x01,                    //   Report Size (1)                   2=
2
# 0x95, 0x02,                    //   Report Count (2)                  2=
4
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
6
# 0x95, 0x06,                    //   Report Count (6)                  2=
8
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              3=
0
# 0x05, 0x01,                    //   Usage Page (Generic Desktop)      3=
2
# 0x09, 0x30,                    //   Usage (X)                         3=
4
# 0x09, 0x31,                    //   Usage (Y)                         3=
6
# 0x09, 0x38,                    //   Usage (Wheel)                     3=
8
# 0x15, 0x81,                    //   Logical Minimum (-127)            4=
0
# 0x25, 0x7f,                    //   Logical Maximum (127)             4=
2
# 0x75, 0x08,                    //   Report Size (8)                   4=
4
# 0x95, 0x03,                    //   Report Count (3)                  4=
6
# 0x81, 0x06,                    //   Input (Data,Var,Rel)              4=
8
# 0x05, 0x0c,                    //   Usage Page (Consumer Devices)     5=
0
# 0x0a, 0x38, 0x02,              //   Usage (AC Pan)                    5=
2
# 0x95, 0x01,                    //   Report Count (1)                  5=
5
# 0x81, 0x06,                    //   Input (Data,Var,Rel)              5=
7
# 0x75, 0x08,                    //   Report Size (8)                   5=
9
# 0x95, 0x03,                    //   Report Count (3)                  6=
1
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              6=
3
# 0xc0,                          //  End Collection                     6=
5
# 0xc0,                          // End Collection                      6=
6
# 0x05, 0x0d,                    // Usage Page (Digitizers)             6=
7
# 0x09, 0x05,                    // Usage (Touch Pad)                   6=
9
# 0xa1, 0x01,                    // Collection (Application)            7=
1
# 0x85, 0x04,                    //  Report ID (4)                      7=
3
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            7=
5
# 0x09, 0x22,                    //  Usage (Finger)                     7=
7
# 0xa1, 0x02,                    //  Collection (Logical)               7=
9
# 0x15, 0x00,                    //   Logical Minimum (0)               8=
1
# 0x25, 0x01,                    //   Logical Maximum (1)               8=
3
# 0x09, 0x47,                    //   Usage (Confidence)                8=
5
# 0x09, 0x42,                    //   Usage (Tip Switch)                8=
7
# 0x95, 0x02,                    //   Report Count (2)                  8=
9
# 0x75, 0x01,                    //   Report Size (1)                   9=
1
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              9=
3
# 0x75, 0x01,                    //   Report Size (1)                   9=
5
# 0x95, 0x02,                    //   Report Count (2)                  9=
7
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              9=
9
# 0x95, 0x01,                    //   Report Count (1)                  1=
01
# 0x75, 0x04,                    //   Report Size (4)                   1=
03
# 0x25, 0x0f,                    //   Logical Maximum (15)              1=
05
# 0x09, 0x51,                    //   Usage (Contact Id)                1=
07
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              1=
09
# 0x05, 0x01,                    //   Usage Page (Generic Desktop)      1=
11
# 0x15, 0x00,                    //   Logical Minimum (0)               1=
13
# 0x26, 0x64, 0x0e,              //   Logical Maximum (3684)            1=
15
# 0x75, 0x10,                    //   Report Size (16)                  1=
18
# 0x55, 0x0e,                    //   Unit Exponent (-2)                1=
20
# 0x65, 0x13,                    //   Unit (EnglishLinear: in)          1=
22
# 0x09, 0x30,                    //   Usage (X)                         1=
24
# 0x35, 0x00,                    //   Physical Minimum (0)              1=
26
# 0x46, 0xcf, 0x01,              //   Physical Maximum (463)            1=
28
# 0x95, 0x01,                    //   Report Count (1)                  1=
31
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              1=
33
# 0x46, 0x12, 0x01,              //   Physical Maximum (274)            1=
35
# 0x26, 0x80, 0x08,              //   Logical Maximum (2176)            1=
38
# 0x09, 0x31,                    //   Usage (Y)                         1=
41
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              1=
43
# 0xc0,                          //  End Collection                     1=
45
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            1=
46
# 0x09, 0x22,                    //  Usage (Finger)                     1=
48
# 0xa1, 0x02,                    //  Collection (Logical)               1=
50
# 0x15, 0x00,                    //   Logical Minimum (0)               1=
52
# 0x25, 0x01,                    //   Logical Maximum (1)               1=
54
# 0x09, 0x47,                    //   Usage (Confidence)                1=
56
# 0x09, 0x42,                    //   Usage (Tip Switch)                1=
58
# 0x95, 0x02,                    //   Report Count (2)                  1=
60
# 0x75, 0x01,                    //   Report Size (1)                   1=
62
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              1=
64
# 0x75, 0x01,                    //   Report Size (1)                   1=
66
# 0x95, 0x02,                    //   Report Count (2)                  1=
68
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              1=
70
# 0x95, 0x01,                    //   Report Count (1)                  1=
72
# 0x75, 0x04,                    //   Report Size (4)                   1=
74
# 0x25, 0x0f,                    //   Logical Maximum (15)              1=
76
# 0x09, 0x51,                    //   Usage (Contact Id)                1=
78
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              1=
80
# 0x05, 0x01,                    //   Usage Page (Generic Desktop)      1=
82
# 0x15, 0x00,                    //   Logical Minimum (0)               1=
84
# 0x26, 0x64, 0x0e,              //   Logical Maximum (3684)            1=
86
# 0x75, 0x10,                    //   Report Size (16)                  1=
89
# 0x55, 0x0e,                    //   Unit Exponent (-2)                1=
91
# 0x65, 0x13,                    //   Unit (EnglishLinear: in)          1=
93
# 0x09, 0x30,                    //   Usage (X)                         1=
95
# 0x35, 0x00,                    //   Physical Minimum (0)              1=
97
# 0x46, 0xcf, 0x01,              //   Physical Maximum (463)            1=
99
# 0x95, 0x01,                    //   Report Count (1)                  2=
02
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
04
# 0x46, 0x12, 0x01,              //   Physical Maximum (274)            2=
06
# 0x26, 0x80, 0x08,              //   Logical Maximum (2176)            2=
09
# 0x09, 0x31,                    //   Usage (Y)                         2=
12
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
14
# 0xc0,                          //  End Collection                     2=
16
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            2=
17
# 0x09, 0x22,                    //  Usage (Finger)                     2=
19
# 0xa1, 0x02,                    //  Collection (Logical)               2=
21
# 0x15, 0x00,                    //   Logical Minimum (0)               2=
23
# 0x25, 0x01,                    //   Logical Maximum (1)               2=
25
# 0x09, 0x47,                    //   Usage (Confidence)                2=
27
# 0x09, 0x42,                    //   Usage (Tip Switch)                2=
29
# 0x95, 0x02,                    //   Report Count (2)                  2=
31
# 0x75, 0x01,                    //   Report Size (1)                   2=
33
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
35
# 0x75, 0x01,                    //   Report Size (1)                   2=
37
# 0x95, 0x02,                    //   Report Count (2)                  2=
39
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              2=
41
# 0x95, 0x01,                    //   Report Count (1)                  2=
43
# 0x75, 0x04,                    //   Report Size (4)                   2=
45
# 0x25, 0x0f,                    //   Logical Maximum (15)              2=
47
# 0x09, 0x51,                    //   Usage (Contact Id)                2=
49
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
51
# 0x05, 0x01,                    //   Usage Page (Generic Desktop)      2=
53
# 0x15, 0x00,                    //   Logical Minimum (0)               2=
55
# 0x26, 0x64, 0x0e,              //   Logical Maximum (3684)            2=
57
# 0x75, 0x10,                    //   Report Size (16)                  2=
60
# 0x55, 0x0e,                    //   Unit Exponent (-2)                2=
62
# 0x65, 0x13,                    //   Unit (EnglishLinear: in)          2=
64
# 0x09, 0x30,                    //   Usage (X)                         2=
66
# 0x35, 0x00,                    //   Physical Minimum (0)              2=
68
# 0x46, 0xcf, 0x01,              //   Physical Maximum (463)            2=
70
# 0x95, 0x01,                    //   Report Count (1)                  2=
73
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
75
# 0x46, 0x12, 0x01,              //   Physical Maximum (274)            2=
77
# 0x26, 0x80, 0x08,              //   Logical Maximum (2176)            2=
80
# 0x09, 0x31,                    //   Usage (Y)                         2=
83
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              2=
85
# 0xc0,                          //  End Collection                     2=
87
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            2=
88
# 0x09, 0x22,                    //  Usage (Finger)                     2=
90
# 0xa1, 0x02,                    //  Collection (Logical)               2=
92
# 0x15, 0x00,                    //   Logical Minimum (0)               2=
94
# 0x25, 0x01,                    //   Logical Maximum (1)               2=
96
# 0x09, 0x47,                    //   Usage (Confidence)                2=
98
# 0x09, 0x42,                    //   Usage (Tip Switch)                3=
00
# 0x95, 0x02,                    //   Report Count (2)                  3=
02
# 0x75, 0x01,                    //   Report Size (1)                   3=
04
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              3=
06
# 0x75, 0x01,                    //   Report Size (1)                   3=
08
# 0x95, 0x02,                    //   Report Count (2)                  3=
10
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              3=
12
# 0x95, 0x01,                    //   Report Count (1)                  3=
14
# 0x75, 0x04,                    //   Report Size (4)                   3=
16
# 0x25, 0x0f,                    //   Logical Maximum (15)              3=
18
# 0x09, 0x51,                    //   Usage (Contact Id)                3=
20
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              3=
22
# 0x05, 0x01,                    //   Usage Page (Generic Desktop)      3=
24
# 0x15, 0x00,                    //   Logical Minimum (0)               3=
26
# 0x26, 0x64, 0x0e,              //   Logical Maximum (3684)            3=
28
# 0x75, 0x10,                    //   Report Size (16)                  3=
31
# 0x55, 0x0e,                    //   Unit Exponent (-2)                3=
33
# 0x65, 0x13,                    //   Unit (EnglishLinear: in)          3=
35
# 0x09, 0x30,                    //   Usage (X)                         3=
37
# 0x35, 0x00,                    //   Physical Minimum (0)              3=
39
# 0x46, 0xcf, 0x01,              //   Physical Maximum (463)            3=
41
# 0x95, 0x01,                    //   Report Count (1)                  3=
44
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              3=
46
# 0x46, 0x12, 0x01,              //   Physical Maximum (274)            3=
48
# 0x26, 0x80, 0x08,              //   Logical Maximum (2176)            3=
51
# 0x09, 0x31,                    //   Usage (Y)                         3=
54
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              3=
56
# 0xc0,                          //  End Collection                     3=
58
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            3=
59
# 0x09, 0x22,                    //  Usage (Finger)                     3=
61
# 0xa1, 0x02,                    //  Collection (Logical)               3=
63
# 0x15, 0x00,                    //   Logical Minimum (0)               3=
65
# 0x25, 0x01,                    //   Logical Maximum (1)               3=
67
# 0x09, 0x47,                    //   Usage (Confidence)                3=
69
# 0x09, 0x42,                    //   Usage (Tip Switch)                3=
71
# 0x95, 0x02,                    //   Report Count (2)                  3=
73
# 0x75, 0x01,                    //   Report Size (1)                   3=
75
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              3=
77
# 0x75, 0x01,                    //   Report Size (1)                   3=
79
# 0x95, 0x02,                    //   Report Count (2)                  3=
81
# 0x81, 0x03,                    //   Input (Cnst,Var,Abs)              3=
83
# 0x95, 0x01,                    //   Report Count (1)                  3=
85
# 0x75, 0x04,                    //   Report Size (4)                   3=
87
# 0x25, 0x0f,                    //   Logical Maximum (15)              3=
89
# 0x09, 0x51,                    //   Usage (Contact Id)                3=
91
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              3=
93
# 0x05, 0x01,                    //   Usage Page (Generic Desktop)      3=
95
# 0x15, 0x00,                    //   Logical Minimum (0)               3=
97
# 0x26, 0x64, 0x0e,              //   Logical Maximum (3684)            3=
99
# 0x75, 0x10,                    //   Report Size (16)                  4=
02
# 0x55, 0x0e,                    //   Unit Exponent (-2)                4=
04
# 0x65, 0x13,                    //   Unit (EnglishLinear: in)          4=
06
# 0x09, 0x30,                    //   Usage (X)                         4=
08
# 0x35, 0x00,                    //   Physical Minimum (0)              4=
10
# 0x46, 0xcf, 0x01,              //   Physical Maximum (463)            4=
12
# 0x95, 0x01,                    //   Report Count (1)                  4=
15
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              4=
17
# 0x46, 0x12, 0x01,              //   Physical Maximum (274)            4=
19
# 0x26, 0x80, 0x08,              //   Logical Maximum (2176)            4=
22
# 0x09, 0x31,                    //   Usage (Y)                         4=
25
# 0x81, 0x02,                    //   Input (Data,Var,Abs)              4=
27
# 0xc0,                          //  End Collection                     4=
29
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            4=
30
# 0x55, 0x0c,                    //  Unit Exponent (-4)                 4=
32
# 0x66, 0x01, 0x10,              //  Unit (SILinear: s)                 4=
34
# 0x47, 0xff, 0xff, 0x00, 0x00,  //  Physical Maximum (65535)           4=
37
# 0x27, 0xff, 0xff, 0x00, 0x00,  //  Logical Maximum (65535)            4=
42
# 0x75, 0x10,                    //  Report Size (16)                   4=
47
# 0x95, 0x01,                    //  Report Count (1)                   4=
49
# 0x09, 0x56,                    //  Usage (Scan Time)                  4=
51
# 0x81, 0x02,                    //  Input (Data,Var,Abs)               4=
53
# 0x09, 0x54,                    //  Usage (Contact Count)              4=
55
# 0x25, 0x7f,                    //  Logical Maximum (127)              4=
57
# 0x95, 0x01,                    //  Report Count (1)                   4=
59
# 0x75, 0x08,                    //  Report Size (8)                    4=
61
# 0x81, 0x02,                    //  Input (Data,Var,Abs)               4=
63
# 0x05, 0x09,                    //  Usage Page (Button)                4=
65
# 0x09, 0x01,                    //  Usage (Vendor Usage 0x01)          4=
67
# 0x25, 0x01,                    //  Logical Maximum (1)                4=
69
# 0x75, 0x01,                    //  Report Size (1)                    4=
71
# 0x95, 0x01,                    //  Report Count (1)                   4=
73
# 0x81, 0x02,                    //  Input (Data,Var,Abs)               4=
75
# 0x95, 0x07,                    //  Report Count (7)                   4=
77
# 0x81, 0x03,                    //  Input (Cnst,Var,Abs)               4=
79
# 0x05, 0x0d,                    //  Usage Page (Digitizers)            4=
81
# 0x85, 0x02,                    //  Report ID (2)                      4=
83
# 0x09, 0x55,                    //  Usage (Contact Max)                4=
85
# 0x09, 0x59,                    //  Usage (Button Type)                4=
87
# 0x75, 0x04,                    //  Report Size (4)                    4=
89
# 0x95, 0x02,                    //  Report Count (2)                   4=
91
# 0x25, 0x0f,                    //  Logical Maximum (15)               4=
93
# 0xb1, 0x02,                    //  Feature (Data,Var,Abs)             4=
95
# 0x85, 0x07,                    //  Report ID (7)                      4=
97
# 0x09, 0x60,                    //  Usage (Vendor Usage 0x60)          4=
99
# 0x75, 0x01,                    //  Report Size (1)                    5=
01
# 0x95, 0x01,                    //  Report Count (1)                   5=
03
# 0x15, 0x00,                    //  Logical Minimum (0)                5=
05
# 0x25, 0x01,                    //  Logical Maximum (1)                5=
07
# 0xb1, 0x02,                    //  Feature (Data,Var,Abs)             5=
09
# 0x95, 0x0f,                    //  Report Count (15)                  5=
11
# 0xb1, 0x03,                    //  Feature (Cnst,Var,Abs)             5=
13
# 0x06, 0x00, 0xff,              //  Usage Page (Vendor Defined Page 1) 5=
15
# 0x06, 0x00, 0xff,              //  Usage Page (Vendor Defined Page 1) 5=
18
# 0x85, 0x06,                    //  Report ID (6)                      5=
21
# 0x09, 0xc5,                    //  Usage (Vendor Usage 0xc5)          5=
23
# 0x15, 0x00,                    //  Logical Minimum (0)                5=
25
# 0x26, 0xff, 0x00,              //  Logical Maximum (255)              5=
27
# 0x75, 0x08,                    //  Report Size (8)                    5=
30
# 0x96, 0x00, 0x01,              //  Report Count (256)                 5=
32
# 0xb1, 0x02,                    //  Feature (Data,Var,Abs)             5=
35
# 0x85, 0x0d,                    //  Report ID (13)                     5=
37
# 0x09, 0xc4,                    //  Usage (Vendor Usage 0xc4)          5=
39
# 0x15, 0x00,                    //  Logical Minimum (0)                5=
41
# 0x26, 0xff, 0x00,              //  Logical Maximum (255)              5=
43
# 0x75, 0x08,                    //  Report Size (8)                    5=
46
# 0x95, 0x04,                    //  Report Count (4)                   5=
48
# 0xb1, 0x02,                    //  Feature (Data,Var,Abs)             5=
50
# 0x85, 0x0c,                    //  Report ID (12)                     5=
52
# 0x09, 0xc6,                    //  Usage (Vendor Usage 0xc6)          5=
54
# 0x96, 0xe0, 0x02,              //  Report Count (736)                 5=
56
# 0x75, 0x08,                    //  Report Size (8)                    5=
59
# 0xb1, 0x02,                    //  Feature (Data,Var,Abs)             5=
61
# 0x85, 0x0b,                    //  Report ID (11)                     5=
63
# 0x09, 0xc7,                    //  Usage (Vendor Usage 0xc7)          5=
65
# 0x95, 0x42,                    //  Report Count (66)                  5=
67
# 0x75, 0x08,                    //  Report Size (8)                    5=
69
# 0xb1, 0x02,                    //  Feature (Data,Var,Abs)             5=
71
# 0xc0,                          // End Collection                      5=
73
# 0x05, 0x0d,                    // Usage Page (Digitizers)             5=
74
# 0x09, 0x0e,                    // Usage (Device Configuration)        5=
76
# 0xa1, 0x01,                    // Collection (Application)            5=
78
# 0x85, 0x03,                    //  Report ID (3)                      5=
80
# 0x09, 0x22,                    //  Usage (Finger)                     5=
82
# 0xa1, 0x00,                    //  Collection (Physical)              5=
84
# 0x09, 0x52,                    //   Usage (Inputmode)                 5=
86
# 0x15, 0x00,                    //   Logical Minimum (0)               5=
88
# 0x25, 0x0a,                    //   Logical Maximum (10)              5=
90
# 0x75, 0x08,                    //   Report Size (8)                   5=
92
# 0x95, 0x02,                    //   Report Count (2)                  5=
94
# 0xb1, 0x02,                    //   Feature (Data,Var,Abs)            5=
96
# 0xc0,                          //  End Collection                     5=
98
# 0x09, 0x22,                    //  Usage (Finger)                     5=
99
# 0xa1, 0x00,                    //  Collection (Physical)              6=
01
# 0x85, 0x05,                    //   Report ID (5)                     6=
03
# 0x09, 0x57,                    //   Usage (Surface Switch)            6=
05
# 0x09, 0x58,                    //   Usage (Button Switch)             6=
07
# 0x15, 0x00,                    //   Logical Minimum (0)               6=
09
# 0x75, 0x01,                    //   Report Size (1)                   6=
11
# 0x95, 0x02,                    //   Report Count (2)                  6=
13
# 0x25, 0x03,                    //   Logical Maximum (3)               6=
15
# 0xb1, 0x02,                    //   Feature (Data,Var,Abs)            6=
17
# 0x95, 0x0e,                    //   Report Count (14)                 6=
19
# 0xb1, 0x03,                    //   Feature (Cnst,Var,Abs)            6=
21
# 0xc0,                          //  End Collection                     6=
23
# 0xc0,                          // End Collection                      6=
24
# 0x06, 0x01, 0xff,              // Usage Page (Vendor Usage Page 0xff01)=
 625
# 0x09, 0x01,                    // Usage (Vendor Usage 0x01)           6=
28
# 0xa1, 0x01,                    // Collection (Application)            6=
30
# 0x85, 0x08,                    //  Report ID (8)                      6=
32
# 0x09, 0x01,                    //  Usage (Vendor Usage 0x01)          6=
34
# 0x19, 0x00,                    //  Usage Minimum (0)                  6=
36
# 0x29, 0xff,                    //  Usage Maximum (255)                6=
38
# 0x15, 0x00,                    //  Logical Minimum (0)                6=
40
# 0x25, 0xff,                    //  Logical Maximum (255)              6=
42
# 0x95, 0x40,                    //  Report Count (64)                  6=
44
# 0x75, 0x08,                    //  Report Size (8)                    6=
46
# 0x91, 0x02,                    //  Output (Data,Var,Abs)              6=
48
# 0x09, 0x01,                    //  Usage (Vendor Usage 0x01)          6=
50
# 0x19, 0x00,                    //  Usage Minimum (0)                  6=
52
# 0x29, 0xff,                    //  Usage Maximum (255)                6=
54
# 0x15, 0x00,                    //  Logical Minimum (0)                6=
56
# 0x25, 0xff,                    //  Logical Maximum (255)              6=
58
# 0x95, 0x1d,                    //  Report Count (29)                  6=
60
# 0x81, 0x02,                    //  Input (Data,Var,Abs)               6=
62
# 0xc0,                          // End Collection                      6=
64
# 0x06, 0x00, 0xff,              // Usage Page (Vendor Defined Page 1)  6=
65
# 0x09, 0x01,                    // Usage (Vendor Usage 1)              6=
68
# 0xa1, 0x01,                    // Collection (Application)            6=
70
# 0x85, 0x0e,                    //  Report ID (14)                     6=
72
# 0x09, 0x01,                    //  Usage (Vendor Usage 1)             6=
74
# 0x19, 0x00,                    //  Usage Minimum (0)                  6=
76
# 0x29, 0xff,                    //  Usage Maximum (255)                6=
78
# 0x15, 0x00,                    //  Logical Minimum (0)                6=
80
# 0x25, 0xff,                    //  Logical Maximum (255)              6=
82
# 0x95, 0x40,                    //  Report Count (64)                  6=
84
# 0x75, 0x08,                    //  Report Size (8)                    6=
86
# 0x91, 0x02,                    //  Output (Data,Var,Abs)              6=
88
# 0x09, 0x01,                    //  Usage (Vendor Usage 1)             6=
90
# 0x19, 0x00,                    //  Usage Minimum (0)                  6=
92
# 0x29, 0xff,                    //  Usage Maximum (255)                6=
94
# 0x15, 0x00,                    //  Logical Minimum (0)                6=
96
# 0x25, 0xff,                    //  Logical Maximum (255)              6=
98
# 0x95, 0x40,                    //  Report Count (64)                  7=
00
# 0x81, 0x02,                    //  Input (Data,Var,Abs)               7=
02
# 0xc0,                          // End Collection                      7=
04
#=20
R: 705 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 =
75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 09 38 15 81 25 7f 75 08 9=
5 03 81 06 05 0c 0a 38 02 95 01 81 06 75 08 95 03 81 03 c0 c0 05 0d 09 05=
 a1 01 85 04 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 =
75 01 95 02 81 03 95 01 75 04 25 0f 09 51 81 02 05 01 15 00 26 64 0e 75 1=
0 55 0e 65 13 09 30 35 00 46 cf 01 95 01 81 02 46 12 01 26 80 08 09 31 81=
 02 c0 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 75 01 =
95 02 81 03 95 01 75 04 25 0f 09 51 81 02 05 01 15 00 26 64 0e 75 10 55 0=
e 65 13 09 30 35 00 46 cf 01 95 01 81 02 46 12 01 26 80 08 09 31 81 02 c0=
 05 0d 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 75 01 95 02 =
81 03 95 01 75 04 25 0f 09 51 81 02 05 01 15 00 26 64 0e 75 10 55 0e 65 1=
3 09 30 35 00 46 cf 01 95 01 81 02 46 12 01 26 80 08 09 31 81 02 c0 05 0d=
 09 22 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 75 01 95 02 81 03 =
95 01 75 04 25 0f 09 51 81 02 05 01 15 00 26 64 0e 75 10 55 0e 65 13 09 3=
0 35 00 46 cf 01 95 01 81 02 46 12 01 26 80 08 09 31 81 02 c0 05 0d 09 22=
 a1 02 15 00 25 01 09 47 09 42 95 02 75 01 81 02 75 01 95 02 81 03 95 01 =
75 04 25 0f 09 51 81 02 05 01 15 00 26 64 0e 75 10 55 0e 65 13 09 30 35 0=
0 46 cf 01 95 01 81 02 46 12 01 26 80 08 09 31 81 02 c0 05 0d 55 0c 66 01=
 10 47 ff ff 00 00 27 ff ff 00 00 75 10 95 01 09 56 81 02 09 54 25 7f 95 =
01 75 08 81 02 05 09 09 01 25 01 75 01 95 01 81 02 95 07 81 03 05 0d 85 0=
2 09 55 09 59 75 04 95 02 25 0f b1 02 85 07 09 60 75 01 95 01 15 00 25 01=
 b1 02 95 0f b1 03 06 00 ff 06 00 ff 85 06 09 c5 15 00 26 ff 00 75 08 96 =
00 01 b1 02 85 0d 09 c4 15 00 26 ff 00 75 08 95 04 b1 02 85 0c 09 c6 96 e=
0 02 75 08 b1 02 85 0b 09 c7 95 42 75 08 b1 02 c0 05 0d 09 0e a1 01 85 03=
 09 22 a1 00 09 52 15 00 25 0a 75 08 95 02 b1 02 c0 09 22 a1 00 85 05 09 =
57 09 58 15 00 75 01 95 02 25 03 b1 02 95 0e b1 03 c0 c0 06 01 ff 09 01 a=
1 01 85 08 09 01 19 00 29 ff 15 00 25 ff 95 40 75 08 91 02 09 01 19 00 29=
 ff 15 00 25 ff 95 1d 81 02 c0 06 00 ff 09 01 a1 01 85 0e 09 01 19 00 29 =
ff 15 00 25 ff 95 40 75 08 91 02 09 01 19 00 29 ff 15 00 25 ff 95 40 81 0=
2 c0
N: GXTP7863:00 27C6:01E0
I: 18 27c6 01e0
# ReportID: 8 / 0xff010000:  171 | 0xff010001:    0 | 0xff010002:    0 | =
0xff010003:   42 | 0xff010004:   29 | 0xff010005:  209 | 0xff010006:   13=
 | 0xff010007:    0 | 0xff010008:    0 | 0xff010009:    3 | 0xff01000a:  =
  3 | 0xff01000b:    0 | 0xff01000c:    0 | 0xff01000d:    0 | 0xff01000e=
:    0 | 0xff01000f:    0 | 0xff010010:    0 | 0xff010011:    0 | 0xff010=
012:    0 | 0xff010013:    0 | 0xff010014:    0 | 0xff010015:    0 | 0xff=
010016:    0 | 0xff010017:    0 | 0xff010018:    0 | 0xff010019:  167 | 0=
xff01001a:    5 | 0xff01001b:    1 | 0xff01001c:    0=20
E: 000000.000000 30 08 ab 00 00 2a 1d d1 0d 00 00 03 03 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 a7 05 01 00
# ReportID: 8 / 0xff010000:  171 | 0xff010001:    0 | 0xff010002:    0 | =
0xff010003:   42 | 0xff010004:   14 | 0xff010005:  213 | 0xff010006:   13=
 | 0xff010007:    0 | 0xff010008:    0 | 0xff010009:    4 | 0xff01000a:  =
  3 | 0xff01000b:    0 | 0xff01000c:    0 | 0xff01000d:    0 | 0xff01000e=
:    0 | 0xff01000f:    0 | 0xff010010:    0 | 0xff010011:    0 | 0xff010=
012:    0 | 0xff010013:    0 | 0xff010014:    0 | 0xff010015:    0 | 0xff=
010016:    0 | 0xff010017:    0 | 0xff010018:    0 | 0xff010019:  167 | 0=
xff01001a:    5 | 0xff01001b:    1 | 0xff01001c:    0=20
E: 000001.006503 30 08 ab 00 00 2a 0e d5 0d 00 00 04 03 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 a7 05 01 00
# ReportID: 8 / 0xff010000:  171 | 0xff010001:    0 | 0xff010002:    0 | =
0xff010003:   42 | 0xff010004:  254 | 0xff010005:  216 | 0xff010006:   13=
 | 0xff010007:    0 | 0xff010008:    0 | 0xff010009:    5 | 0xff01000a:  =
  3 | 0xff01000b:    0 | 0xff01000c:    0 | 0xff01000d:    0 | 0xff01000e=
:    0 | 0xff01000f:    0 | 0xff010010:    0 | 0xff010011:    0 | 0xff010=
012:    0 | 0xff010013:    0 | 0xff010014:    0 | 0xff010015:    0 | 0xff=
010016:    0 | 0xff010017:    0 | 0xff010018:    0 | 0xff010019:  167 | 0=
xff01001a:    5 | 0xff01001b:    1 | 0xff01001c:    0=20
E: 000002.012748 30 08 ab 00 00 2a fe d8 0d 00 00 05 03 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 a7 05 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2509 | Y:   1245=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  56607 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.217700 30 04 03 cd 09 dd 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 1f dd 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2509 | Y:   1245=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  56677 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.225269 30 04 03 cd 09 dd 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 65 dd 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2509 | Y:   1245=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  56747 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.231541 30 04 03 cd 09 dd 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 ab dd 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2508 | Y:   1246=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  56817 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.238719 30 04 03 cc 09 de 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 f1 dd 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2502 | Y:   1250=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  56887 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.245823 30 04 03 c6 09 e2 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 37 de 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2492 | Y:   1258=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  56957 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.252430 30 04 03 bc 09 ea 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 7d de 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2480 | Y:   1266=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57027 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.259483 30 04 03 b0 09 f2 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 c3 de 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2470 | Y:   1274=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57097 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.266476 30 04 03 a6 09 fa 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 09 df 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2460 | Y:   1281=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57167 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.273555 30 04 03 9c 09 01 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 4f df 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2449 | Y:   1288=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57237 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.280933 30 04 03 91 09 08 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 95 df 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2437 | Y:   1294=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57307 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.287696 30 04 03 85 09 0e 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 db df 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2425 | Y:   1299=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57377 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.294963 30 04 03 79 09 13 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 21 e0 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2412 | Y:   1303=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57447 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.301663 30 04 03 6c 09 17 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 67 e0 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2400 | Y:   1305=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57517 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.309095 30 04 03 60 09 19 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 ad e0 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2387 | Y:   1306=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57587 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.315699 30 04 03 53 09 1a 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 f3 e0 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2375 | Y:   1307=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57657 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.322504 30 04 03 47 09 1b 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 39 e1 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2363 | Y:   1307=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57727 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.330075 30 04 03 3b 09 1b 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 7f e1 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2352 | Y:   1307=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57797 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.336411 30 04 03 30 09 1b 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 c5 e1 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2341 | Y:   1306=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57867 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.343664 30 04 03 25 09 1a 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 0b e2 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2330 | Y:   1305=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  57937 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.350659 30 04 03 1a 09 19 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 51 e2 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2318 | Y:   1304=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58007 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.358279 30 04 03 0e 09 18 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 97 e2 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2306 | Y:   1301=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58077 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.364759 30 04 03 02 09 15 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 dd e2 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2293 | Y:   1299=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58147 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.371791 30 04 03 f5 08 13 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 23 e3 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2280 | Y:   1296=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58217 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.379503 30 04 03 e8 08 10 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 69 e3 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2266 | Y:   1292=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58287 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.385506 30 04 03 da 08 0c 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 af e3 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2253 | Y:   1289=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58357 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.392920 30 04 03 cd 08 09 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 f5 e3 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2239 | Y:   1286=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58427 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.399353 30 04 03 bf 08 06 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 3b e4 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2225 | Y:   1283=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58497 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.406125 30 04 03 b1 08 03 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 81 e4 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2212 | Y:   1280=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58567 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.413540 30 04 03 a4 08 00 05 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 c7 e4 01 00
# ReportID: 4 / Confidence: 1 | Tip Switch: 1 | # | Contact Id:   0 | X: =
  2200 | Y:   1278=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0=20
#             | Confidence: 0 | Tip Switch: 0 | # | Contact Id:   0 | X: =
     0 | Y:      0 | Scan Time:  58637 | Contact Count:    1 | Button: 0 =
| #=20
E: 000002.420403 30 04 03 98 08 fe 04 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 0d e5 01 00

Would you prefer handling this by simply dropping the 0xff010001 collecti=
on
in mt_input_mapping() in hid-multitouch, or should this device quirk be
implemented via HID-BPF instead?

Best regards,
Ruzal

