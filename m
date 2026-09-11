Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4262868AB
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141220; cv=none; b=BR1sWkZlTFsAvUTEwmNKsgBQw60SAkfR3Htd8vv1WnKEO9KZNExnZwJPeQJE4RvL8lTy+fAlHAeWPguDAB0+EbOvGZXwf58coUEHpNtFa4Ek2m6zI6YcKJqGHRuzyFT/0M1kkdhKvQyldqmsmsYqfRKQbMhuB6v3fA/aGGgYxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141220; c=relaxed/simple;
	bh=Q0vgRXzKh6plrRXrapH2xFdwdpT2ymocQGbsOauCRNY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=R0L36hGGFe0quK/6hX9wm+Ym0bZfSyS2U1NljzV2lVqqscZ15OqegXeT6Sd/TrzqNqraQqOkDDNxx0/a9owZrFdCO/yB2EcOrQ9zNg+85+okqHpErrhzRv+EHfhV1VnuHmBLJd/VnIHWp1sol0VRQRGpUmmHI7ZYgxjL3W24Tsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwgc2R9J; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwgc2R9J"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f64ea07036so1090855a34.0
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789141206; x=1789746006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YmUqkl8h973bYn5aQCd4ratDwQJ6p2rUAcsUSgd645w=;
        b=Kwgc2R9JBbGLqAxcQp4Uhah+GdLpF5Qtvy+htqZHhkpOY4Fy1e6g3+/+QwESSXd+9Z
         w5QE4fF5irGuMbjcwogOk/Eu1Phooqav6VFYDpkDSKAgEmciC+en5t+/PGjjBiqAKAXX
         Ur32wcNx5secC/KE6NMYXI3X8EHhzZb2BlQaRZAds4hSInRerJ/ioCVALhZ+zg3rSnt6
         CTC6tnr6bjoCLWKfKi/ubTOXIs7uH2Wx7JRr1qZAeHQ6kxzl07B4loN2n6spHI8kx95+
         XmTwRu6NvLRUQzcow3R4AsBS39ixPmp57ljpjVzf6Ni+47gWwaRCI9A64fM/2FBOvn7z
         Zabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141206; x=1789746006;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmUqkl8h973bYn5aQCd4ratDwQJ6p2rUAcsUSgd645w=;
        b=Ods2Vp5BbCB+woI8vDt83cDuMy/kRu3u6oBJ244E4EnFhRINHXPPmjaNweSXhbjm1t
         JyWUkAYOJ5cyS0bgRkvxcJN3i4+fZcrhbnshodHRDP5urgFFAIbIzgyJIEZA0wW/O6dQ
         JbtgloDOXfNYcoJuiW1HEOYVxwquWrjLrqLd2Q4B+yBxzKjWnfZhI2p2wpX3LVlGgJUr
         xicJPuA+mpB9eLMHFooOV/7tc2bFZYIrwAKt8Bh9AHADgF//SEu71YzAypXpzfkm4HLJ
         0ZNXhFS+yL5QR2Gb2y4SWlIdv9Q/Wrs6S6Gz/bP1YrvmTBmiEuLHSj3TSfRay4OkcJr6
         rA1w==
X-Forwarded-Encrypted: i=1; AKwUvBzEohT0DUk/7NWha8wbTjSO04J+xbEwETkMfvb/LhAAQQpExXdvnYIND27mE7NyeplCh4Ho8umEILfQ3w==@vger.kernel.org
X-Gm-Message-State: AFuF++m0U3mfpgPHNlMTtsxVT282QljtqLEJL7hOZRWKBMN3i4oUGNKU
	2QORC/bGcwlWkhfOADU6T+ONqpsTOBhpJ/oha/tuK6Aovn8LpjTaqE0T
X-Gm-Gg: AYBFou0UQilZCwqyNPCNg+yyVmbQ7hZUxGDnW+mO841eQewnuP6LvRUfrTU6Bz4Le+6
	pzOtvrVYMSFnOVG29WsUjpT55TZcnM/yKJ5K+ya3owZrT5YXWgwOnwjgUE+c/srETDkPSDAjASA
	NUn7WOm7LJztKvz5tgRqdlh7ieMZfzihzwbBc1s3kkQUfchbOb/adVHDjENyidQYagj6BiWH2fs
	naFoCL3X7wjVOZCGutiLJZmfJyWFGoGYztKNpSQ5xHdd4dJ4W+MhIz8ub2zX1ZxCdDXRLa5tuNX
	Y+R7L/KxCyJY6KtgC/5Fhkuhhf/fTfOaLybJlgRbe0exqY0oblxuOi5uc0yZ2vqyoEjs+Oi+vrf
	4yHggNVs+Z+UCy+5q0W1FFIHh31tj7BbbqKJ9JcfW8V3lzjU9h9cZsl8eFQn/MzTdTfR+VRyAl4
	3ErRdSuv6rZpxcZbyQJFTwpsk8zuMCeOFv9wtr3ED2xwItVle87ZVBNPsNY7vHvTJ1jBh0+PLfD
	jkGXAnj1xaE//0uxw==
X-Received: by 2002:a05:6820:7086:20b0:6be:4eb3:e1be with SMTP id 006d021491bc7-6c0bc8bf63amr2618612eaf.39.1789141206167;
        Fri, 11 Sep 2026 08:40:06 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2607:fb91:1be9:b272:ad3:f458:6adc:9388])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0990cc05fsm2864524eaf.3.2026.09.11.08.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:40:05 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:39:58 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Denis Benato <denis.benato@linux.dev>, Jiri Kosina <jikos@kernel.org>
CC: 'Benjamin Tissoires' <bentiss@kernel.org>,
 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/2=5D_Input=3A_xpad_-_intr?=
 =?US-ASCII?Q?oduce_a_static_table_to_ignore_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <91447a15-eea8-4f21-abd6-2d79b5c647bb@linux.dev>
References: <20260811125856.1692045-1-denis.benato@linux.dev> <20260811125856.1692045-3-denis.benato@linux.dev> <6598sn1p-p330-1r7o-q43p-r1rnr7nn0022@xreary.bet> <91447a15-eea8-4f21-abd6-2d79b5c647bb@linux.dev>
Message-ID: <F4BC32F9-792B-48C3-A1EF-65BC4E2534C5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 11, 2026 8:12:02 AM PDT, Denis Benato <denis=2Ebenato@linux=2E=
dev> wrote:
>
>On 9/11/26 16:11, Jiri Kosina wrote:
>> On Tue, 11 Aug 2026, Denis Benato wrote:
>>
>>> Certain devices can work both as HID and as an xpad device: binding bo=
th
>>> would duplicate inputs causing userspace to receive double inputs; at =
the
>>> same time if a HID device is available it is to be preferred as it can
>>> support additional features such as integrated IMU and additional butt=
ons
>>> and more, depending on the specific driver, therefore allow only the
>>> best driver available to bind the device=2E
>>>
>>> Suggested-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>>> Signed-off-by: Denis Benato <denis=2Ebenato@linux=2Edev>
>> I'd like to have Dmitry's Ack on this one before taking the Flydigi=20
>> support through the HID tree=2E
>Hi Jiri,
>
>Sure thing! While we wait I will get a v4 going that is reported working =
better
>and having battery reporting too by Adolfo=2E
>
>This new table will be used by Derek too for some trustmaster (I think) h=
e's
>working on that is in the same situation=2E
>

Hi Denis,

I'm waiting for Vicky's GIP driver to land before I do that because I'll n=
eed to add a similar table to that driver and I want to avoid getting in th=
eir way=2E

Cheers,
Derek

>Best regards,
>Denis Benato=C2=A0
>> Thanks=2E
>>
>>> ---
>>>  drivers/input/joystick/xpad=2Ec | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/input/joystick/xpad=2Ec b/drivers/input/joystick/=
xpad=2Ec
>>> index feb8f368f834=2E=2E545119a4fb36 100644
>>> --- a/drivers/input/joystick/xpad=2Ec
>>> +++ b/drivers/input/joystick/xpad=2Ec
>>> @@ -406,6 +406,18 @@ static const struct xpad_device {
>>>  	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
>>>  };
>>> =20
>>> +#define XPAD_SUBSTITUTE(_vid, _pid, _enabled) \
>>> +	{ =2Evid =3D (_vid), =2Epid =3D (_pid), =2Eenabled =3D (_enabled) }
>>> +
>>> +static const struct xpad_excluded_device {
>>> +	u16 vid;
>>> +	u16 pid;
>>> +	bool enabled;
>>> +} xpad_excluded_devices[] =3D {
>>> +	XPAD_SUBSTITUTE(0x37d7, 0x2401, IS_ENABLED(CONFIG_HID_FLYDIGI)),
>>> +	{ }
>>> +};
>>> +
>>>  /* buttons shared with xbox and xbox360 */
>>>  static const signed short xpad_common_btn[] =3D {
>>>  	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
>>> @@ -2044,11 +2056,23 @@ static int xpad_probe(struct usb_interface *in=
tf, const struct usb_device_id *id
>>>  	struct usb_device *udev =3D interface_to_usbdev(intf);
>>>  	struct usb_xpad *xpad;
>>>  	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
>>> +	const struct xpad_excluded_device *excluded;
>>>  	int i, error;
>>> =20
>>>  	if (intf->cur_altsetting->desc=2EbNumEndpoints !=3D 2)
>>>  		return -ENODEV;
>>> =20
>>> +	for (excluded =3D xpad_excluded_devices;
>>> +	     excluded->vid || excluded->pid;
>>> +	     excluded++) {
>>> +		if (!excluded->enabled)
>>> +			continue;
>>> +
>>> +		if (le16_to_cpu(udev->descriptor=2EidVendor) =3D=3D excluded->vid &=
&
>>> +		    le16_to_cpu(udev->descriptor=2EidProduct) =3D=3D excluded->pid)
>>> +			return -ENODEV;
>>> +	}
>>> +
>>>  	for (i =3D 0; xpad_device[i]=2EidVendor; i++) {
>>>  		if ((le16_to_cpu(udev->descriptor=2EidVendor) =3D=3D xpad_device[i]=
=2EidVendor) &&
>>>  		    (le16_to_cpu(udev->descriptor=2EidProduct) =3D=3D xpad_device[i=
]=2EidProduct))
>>> --=20
>>> 2=2E47=2E3
>>>

