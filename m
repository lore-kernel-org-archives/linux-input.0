Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303369;
	b=v2YyI/0GQ+bBJXap4IBrvbbWbh9oHUKIFJU36vfwf+U4EJs7Ysq62FjK5hElv4HFoP96
	 Wf11C+Go3HhfUYODSI+ewNlAwg4fKdBKWJFkRkaq32r+EePgoU3v/3+a6Q+Up/Dvs8uwb
	 JQP2RVJxDI00dD7TcqzTzaFXrwkmm7ZECIrgi35Pr1fxtaocfTP+Ezzpq9HLl7QT+I2uE
	 5kXwAIW+RpobbAY9sVzGfxb9OCX4yqNES65SP2E5SCciTOQzO2N0RJlX5MFjRKe65zEg4
	 FgouOzs5B929qFXu8XYt5eq8hzKLZuM+2EaQQAdsFzNaR52UCtuXPxTqQpiL3t/avdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303369;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KWpsyFS5zmqpu6fidEJLwk7XXELkfysy/CkXhYTqYPk=;
	b=yQUVliTzVCcwHY5Hr4EmM8CeP8oAtfvsetltL5btsHKeGggZq+vgLCVf+C3kMJyzgPG+
	 td4ynNA8oB4Oib69zAurvA7LRe9qM0It6+hZBBca8zuxI0ghT+9+cn4KKzCFTLxQEbJvZ
	 7sAyUBzb77nc1Qx02oPCIzVLM/5ZXsaD2nx7umR7ccvigSAMLot0QcHlUIx1A26KejaTs
	 YRe87UM0mR0irvAa+Y840+jCsEJ+0AoOY/OGn79jlPzSeEkSgtXj1XOH2R84XbHpbw9Xa
	 YkB8vsAaTYm0jSxRShxIatix5xwxyK72tX3G4IuljOMa01G/vlM6uPKTFWPrtzlgeYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kufu+Jp6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OCafPhRm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A4606DA0E
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 09:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8A4606DA0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kufu+Jp6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OCafPhRm
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8WCEj2833758
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 09:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KWpsyFS5zmqpu6fidEJLwk7XXELkfysy/CkXhYTqYPk=; b=Kufu+Jp6a7+GNsJW
	3ScuQg+AGVrejBQL/2+FcKCmGA6ixVY1zb4SyaTVPLey6yjNm/6Zn7hzCZOsFOAe
	9jRwBe7tvcZgUoglxl8XfFp+I5HuL0QEfxmFQYdxMDA4x9WKSmQr4opad8StKuJB
	s/hfj/J1LmEveaV/XIT1uNc4ztwOfgL7mZbTeWe9Amqj1MQz3cmmPBQVaOFOrW6z
	fVrZsDntpSdq5wE79DRgtg9DojA5kGvG8zEep2jL+7QoCt7WupoTAy9izZHG3NFa
	VaXHReH4Cd+TqwSdFJig+dghv/rUYSiEETHuddb4EEVKwFU4emEEeiE/ufRi98mQ
	Q/MxBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufr8c6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 09:36:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9308eafb465so341866385a.2
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794303367; x=1794908167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWpsyFS5zmqpu6fidEJLwk7XXELkfysy/CkXhYTqYPk=;
        b=OCafPhRmVWtGbTkAcKCmtAJA9zgD3Q9e1evDVpjPN067MaID3/ONJ9kwdQbbNNsaM1
         /cStoT39lsD+72As2qsiYLgbazuTYsg4k7uzle1hWeHq0sxDFc8QOUrAtym9yvvr2AwC
         N8lIzA+HNkYzaK4VLA9EhjASc1KlqSTSd/uRwr6enwx3l+nGVb+uwX86ulpaM2dhhbOk
         iDh4fQz6h61Fgq5tPLwsDtPSmHp0rAUrlsEDi5vh3JnOlH4gmeGLE+Om16HxYmQ63OWt
         SrHnfPhDbQJgjhTuh+8GoPD5YD/ZwJYWlTyclYDyZ1iJKrT+YNzIrgXzLTKAYqR32e14
         YpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794303367; x=1794908167;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWpsyFS5zmqpu6fidEJLwk7XXELkfysy/CkXhYTqYPk=;
        b=mPxD53hIVEfPDtOL4mR6DK/+yXL6yewWUWrojEf3v+xN1zJBDun1jE261YwV7ENNwl
         WmU+5SjG89hsFIl66weF3dtleMDAJYHC9Cv7HSs8oXTla7duNl/E8xPDdDCnpSu9VOzY
         Dx2P/JLgbdeqJEMRQ3L+L86n3Kpn67z3IZrdcmhcuBucxlKVHKfkLtAbS3ZcEmZTP22f
         eUJ8HIN3GPMEz5YuE9EtWuQu3uN2VaOB/GTASZC6LXVhHvLJUcMVJbYiiAE8sm7Qw9G7
         9bAAZ0alN2ExB63yFDEtW2cKsozMZ5Dq9lif1jzqra8fMGdb/0DFzYyUgTJiirO6zQqn
         3pGQ==
X-Gm-Message-State: APuU4Z9kFFhjGUineM3dg/KjLSVCO1K2dvOKT9fhn2BBJHh7gQnr4tBn
	B9ATy594b3pRa+tDI7QeGHFfj3QFqlW0FzwPMnXo25Zt2BH7+/XsKHICPj1qmD9QNZOy/rfj+Ti
	1jKUDMApuIOsULe5nRiNYokVuZIqXZ56NFVaxsGLPaypFdf7KxRXxaC3bAU971ACvFQ==
X-Gm-Gg: AYBFou3D+zTvv1nKBtsDRzGgBR5hwJyKDID85GCbFy+VxgsiP5UkBOzKpRp8LvftopB
	axBLN41rBFCvBeHHNb8yLVXyKMymFtsrg51SNCuwpNrWvPFg3bMKK5h/CmXZTD9iJUxs46V96AS
	K6nkpp1y/W45xmgSYakB0g+G2OkKYOIZLbIj9Bz8JACbTJJ75R6MDUv7BE49w0VgtEpud5l08vi
	JmVabrahEVUFTjARvVFyUsNwOxsPelYsbZAVVsaVjvIK19crqhSmwBXPRBN6pJiz4XoPCuW3w/G
	rFZSHvfII1NHlBhONk4RI0NlPIqgyXjUJ/uXSrUUxVo0/U2wyh76l2Kl++mKtB6vhD3hiuozi3F
	418GRtGWxrIrI17zPf6IBA+830KSUku2BJ7Od6G64QDD/WxWQaU1jbbz7UlbZBtgSF0EQ9WSvLQ
	vm4gdXPNNwbcUnfgI58GEvVdSR7Q58mCI5fFXOVr5TBppDZlWuuPNK1qdbVyIKo/CoCgChXJQyV
	C6gb6CGPCe+1vNvOXpeCoqpaNS6ZSioHwCyrxa07kw=
X-Received: by 2002:a05:620a:450c:b0:93f:1ca9:f2f6 with SMTP id af79cd13be357-9479f3f113emr321727885a.77.1794303367108;
        Tue, 10 Nov 2026 01:36:07 -0800 (PST)
X-Received: by 2002:a05:620a:450c:b0:93f:1ca9:f2f6 with SMTP id af79cd13be357-9479f3f113emr321725985a.77.1794303366649;
        Tue, 10 Nov 2026 01:36:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823d01sm930032a12.2.2026.11.10.01.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:36:05 -0800 (PST)
Message-ID: <032eb56b-89b8-4b5e-b291-4d4955e87009@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 10:36:05 +0100
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
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] HID: lenovo: suppress spurious F23 key events on ThinkPad
 T14s gen6/7 snapdragon
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J . Clark" <derekjohn.clark@gmail.com>,
        Jiri Kosina
 <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
References: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
 <d66407e5-a057-4149-9ad8-1f0dd0c2d6a8@app.fastmail.com>
Content-Language: en-US, nl
In-Reply-To: <d66407e5-a057-4149-9ad8-1f0dd0c2d6a8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8qA5RPiK2MNHpNW8VJNOSEv5yI1aZyWC
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af2e588 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=w4lYrviVjwiVwymeGf8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 8qA5RPiK2MNHpNW8VJNOSEv5yI1aZyWC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfXwjepf2805kpn
 sJyporzYQhtOarE1k9IPzDsWuC+tUrfXMsB/BK3fH8Lzh5Rt0IphMzaaehjMG0nf6i7RdFs3eag
 w8+svmFQROgq/S3EMD0+bVVxaIlJva8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfXz5AuPnvLBnyy
 NV87JCKcoKb6gGhDWype9iT50l9CU0V/8htqDc5VptkLpU0NXWWUeoIVre6aOBLZRL4FYfS2Xzf
 WsDhqXoBwiO7S10eD/dMDDK9yboSpV9aQCLfY+xK66rO8mVoQoDfMODOJbablJ1Z2wF0RO+KkZN
 MApaLogrM26t6tNuE4fuM1YhEGsteNvmp9egWEudbcKu1+KisSZqmZLXVkNwNlbEi/+5SX7qBLH
 2wHBz3SVAywRXCef6kcCI+J2rhBQtDFMv/pk9Z081MbdCt9rvbSkT0APA+jbkKx2KWkKHMav+kU
 0JGH4ZaYKIfmH48d6vFZQ3Gr2f5kaKVOfHC/JlcpXvQnx011/Ozfn1TPLtCasEvkj3c/Ppy+OC1
 VjgRg9tDvyY/hYjXyWs7RsGQBgTRu2UKdhYQBM4+EdfCwnMpOUUjMa/8o+xQZ8ioblnPOZTkSXI
 t/KdIWYi3LVXq6W/fMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100038

Hi,

On 10-Nov-26 01:49, Mark Pearson wrote:
> Hi Hans
> 
> On Mon, Nov 9, 2026, at 4:43 PM, Hans de Goede wrote:
>> The Lenovo ThinkPad T14s gen6/7 snapdragon version I2C-HID keyboard sends
>> spurirous F23 key-events when the Fn key is pressed/released. Leading to
> 
> Minor - typo (spurirous)

Ack.

>> e.g. garbage ESC-sequences in the terminal when doing FN key combos.
>>
>> A hwdb entry was added to map these to KEY_UNKNOWN [1], but this also maps
>> the F23 part of the left-meta + left-shift + F23 combo send by the co-pilot
>> key to KEY_UNKNOWN making that key unusable.
>>
>> Add a raw_event filter which removes any 0x72 codes from the 6 scancodes
>> reported in the standard HID keyboard boot protocol report, but only when
>> the report's modifier byte is not 0x0a to preserve the F23 press event
>> when the co-pilot key is pressed.
>>
> Interesting - I'd missed that.
> 
> Should I be flagging this to the FW team? I think I'm unlikely to get anything fixed at this point realistically - so don't want to block the patch...but if there's something we can learn from this for maybe the next generation?

For future hw it would be nice if just pressing Fn by itself would not send
any spurious keypresses. Or at least not on the I2C-HID side. If this is
an EC event instead we can just filter it in the EC driver.


>> Link: https://github.com/systemd/systemd/pull/44733 [1]
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  drivers/hid/hid-ids.h    |  1 +
>>  drivers/hid/hid-lenovo.c | 21 +++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 994e8bc69924..70d18d32fe3c 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -473,6 +473,7 @@
>>  #define USB_DEVICE_ID_EDIFIER_QR30	0xa101	/* EDIFIER Hal0 2.0 SE */
>>
>>  #define USB_VENDOR_ID_ELAN		0x04f3
>> +#define I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD	0x000d
>>  #define USB_DEVICE_ID_SB974D            0x0400
>>  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
>>  #define USB_DEVICE_ID_HP_X2		0x074d
>> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
>> index 30bd3f794243..e997d0cf2672 100644
>> --- a/drivers/hid/hid-lenovo.c
>> +++ b/drivers/hid/hid-lenovo.c
>> @@ -812,6 +812,22 @@ static int lenovo_raw_event(struct hid_device *hdev,
>>  		      size >= 4 && report->id == 0x03))
>>  		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
>>
>> +	/*
>> +	 * Lenovo ThinkPad T14s gen6/7 snapdragon version filter out spurious
>> +	 * F23 events when Fn key is pressed. F23 cannot be unmapped because of
>> +	 * the copilot key sending left-meta + left-shift + F23. Filter report 8
>> +	 * (keyboard) scancode 0x72 (F23) when the modifier byte is not 0x0a.
>> +	 */
>> +	if (unlikely(hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD &&
>> +		     size == 9 && data[0] == 8 && data[1] != 0x0a)) {
>> +		for (int i = 3; i < 9; i++)
>> +			if (data[i] == 0x72) {
>> +				memmove(&data[i], &data[i + 1], 8 - i);
>> +				data[8] = 0;
>> +				break;
>> +			}
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> @@ -1393,6 +1409,10 @@ static int lenovo_probe(struct hid_device *hdev,
>>  {
>>  	int ret;
>>
>> +	/* Make the T14s  keyboard trackpoint a separate input-device */
>> +	if (hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD)
>> +		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
>> +
> 
> Shouldn't this be in a separate commit?

No this "quirk" is the default behavior of the hid-generic driver. This driver
now will take over control from the hid-generic driver because of the device-id
addition below.

So setting this quirk preserves the existing default behavior.

> 
>>  	ret = hid_parse(hdev);
>>  	if (ret) {
>>  		hid_err(hdev, "hid_parse failed\n");
>> @@ -1558,6 +1578,7 @@ static const struct hid_device_id 
>> lenovo_devices[] = {
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, 
>> USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
>> USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
>> USB_DEVICE_ID_LENOVO_TP10UBKBD) },
>> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 
>> I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD) },
>>  	/*
>>  	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to 
>> the keyboard
>>  	 * part, while letting hid-multitouch.c handle the touchpad and 
>> trackpoint.
>> -- 
>> 2.56.0
> 
> Mark


Regards,

Hans


