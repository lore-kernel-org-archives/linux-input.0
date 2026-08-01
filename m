Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1032ED4E
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626308; cv=none; b=BmnHAh2Th5BYuk9zXkGGXbBiQePNrV5VLU/OiTbr6iByS7179Hka1bowjdh2OQY8lKKC6ayeSU8E0KF9eaB+KN3ljMFVbeDvns/YtDej+L2xCl9y6ti0BEkFnCxT/7JcQCHR5/RbwQhdcZCOWoysyxQVd/ELiunXWUiJaM2IdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626308; c=relaxed/simple;
	bh=HfV76qd2RJ6Kvi7tbX1P3x2LNsWnEMrj4U8gClgW5eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7y1NQ085DeludzeLPc/kWcK0Uugzadg1hFl80ToindIKKg3rqrO/Etif8PErGqB/UNAc3QT0a2gM6ZI3kkJoZlQGd28/lSFtYB6MO4TF4FoJIcKviqed1JwFTLozG31TH37YokvtqFEcoIpZuVBgk9qRr7nysl4R7/ahdvSD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHr3itUw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHr3itUw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c197eaaab00so362391066b.0
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785626305; x=1786231105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sI0dPeWZgkJ3ivK+Qdn0DY+4aa4E9Wwiwd/CGwrygk=;
        b=IHr3itUw2nI+gdZfXLB5nA/wQ5S8H3D1DiyT/t0HItB1EIiT7zs3q1i7nNdd9G9YiO
         u9HwwyxIzw19I5KVmGLqs5fWas9MtMceFqlPS3WGgSIlorOjcFq/oJtkL7rSErH6PfjM
         bqzNjnxzuRyvtXCXOm4ulCaaxfCfi0F3HJGVkkJA38peQCskvPwox2ab30BTmHG/aQmm
         UnRvHnb+2v4WJ0/UVHBZTw5GrMQioI5FjtLT/WZ2hGypm/gcFGVUqTpLZqmKMkGoOcmH
         E5HMyE66KDy3+Bl8g6NaGc4qOPMOf6kQT4DDZ52/zIdRFwqmmYN7P/Cd2v3RYGe6fH8o
         ONQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785626305; x=1786231105;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sI0dPeWZgkJ3ivK+Qdn0DY+4aa4E9Wwiwd/CGwrygk=;
        b=P8fFBCXI9+bademp/dclY0+gbu0mCthFNddgC7c8iebzIhfsTUDmtP1RWkt4Y6Tg33
         pcSifNSI21F1lUigZc0hYyeg52NF5CgsC0V7GLR+OsmErq9/fHmsGqRvkvrUKppSyEcR
         nnUmf4rTJDNDBoSfGP1zzfEx3RhdIzdGg+i6HmZnCxLrV+bnvGrkSXRtlTD89Bcd0Ty3
         E4pn4+FDFiBTLg38kP6XT1tW+UXNLicjamRfy2yRflMw7g1ri3fg/A8/8BYzCCtwm7bI
         vbuDWWxGQnoWa2fLujB4QgGh/FOXEtKKx34bq4bc82KtCTNKiS4WGw1s26P2q5RMYxuN
         HLQA==
X-Forwarded-Encrypted: i=1; AHgh+RoWgP/2BD8D19s7SRwSf0zUNc8itpLSHzCD4c4TGn6RLYSjOkVc1s6cmBMBTRBPnjfy96eXbD9DPEy0tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iLnqeBDMZcO+z29RtVzlMWlYs33AvuvGocJCcU9MdcXwYTlb
	+m+mkyfMEg8KFx4A5UNyjaQ+vgYum56Afu5nB6C/KNhdMPjFu/CDVXOz
X-Gm-Gg: AR+sD10E7iD1esyOscHtVyVQ/lalz4p8TJ6hjmAb/O6BLofo1ZKm9ATNWEJkv+tx8+N
	HPnmtB7Jl32hZ0Vde7AourxsWcdljf94Fry/AF46yNbxCnbWoidmMcLOweJUHsxaG3I3i6kRAiI
	kgVdBT8N5kT/ORFyh/SSPMKLkVYQE+9RzlT9iOySATOX2funjsVZfOmzt/ntxjxSqbTx/kYQ7JR
	NPc0WZuuWFg+QlHMekQsSgLLp8x6WJQBiqbdxiY0by8mJTqGQUiKXdrVRxyTys+0znyu3qf28N3
	jXVsBxiPddi8hp3GzLHyP/MBTb9gqF/lFBiEhtbD/q4RGfO66pEou8J8ui8fFM2R/GImrn8gH9S
	ZsOf4i5M0l0UQ34Q/Es7iE+EdBJ9w30PYr38wcG4+gOEgBcnuyH08F5WePHeWoxT3ydZ463il+1
	1hVSTGCAiUddLEleeoUDz69UFi1vXz9UQUDmI7phDmybMH3tJLjCAk89jzzLWkOVtzEMG9XtSgQ
	tvgVB9hmae9QtsBR0dXpV4I5AD4p8TLqmpeVPjLfqU=
X-Received: by 2002:a17:907:1b21:b0:c19:523f:5a0 with SMTP id a640c23a62f3a-c1fe8167bb8mr347281066b.11.1785626304677;
        Sat, 01 Aug 2026 16:18:24 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd455f671sm336487966b.57.2026.08.01.16.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 16:18:23 -0700 (PDT)
Message-ID: <bce18a69-a7ce-4aa3-b631-59613c8ce114@gmail.com>
Date: Sun, 2 Aug 2026 01:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
To: Bastien Nocera <hadess@hadess.net>, jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, k8ie@mcld.eu, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
 <20260713201201.391538-1-erikhakan@gmail.com>
 <20260713201201.391538-2-erikhakan@gmail.com>
 <87314b89c73bd06c9824da73811a53b3f88a5059.camel@hadess.net>
Content-Language: en-US
From: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
In-Reply-To: <87314b89c73bd06c9824da73811a53b3f88a5059.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

Thanks for the review!
I've looked into the issues a bit.

On 7/30/26 10:36, Bastien Nocera wrote:
> Hey Eric,
>
> On Mon, 2026-07-13 at 22:12 +0200, Erik Håkansson wrote:
>> Add Logitech Bolt receiver support to the Logitech HID receiver and
>> HID++ drivers.
>>
>> Handle Bolt receiver notifications in hid-logitech-dj and add a
>> Bolt-specific initialization path in hid-logitech-hidpp, separate from
>> the existing Unifying receiver path.
>>
>> This allows Bolt-connected HID++ devices to expose battery information
>> through the kernel power_supply path, so userspace tools can report
>> their battery status with the correct device model.
>>
>> Tested with:
>> - Logitech MX Keys for Business via Bolt receiver
> I tested this with a Bolt receiver connected to the same M650 mouse I
> used in another test earlier, and my Slim Solar+ keyboard.
>
> Every time the mouse is turned off, I get:
> kernel: logitech-hidpp-device 0003:046D:B02A.0009: hidpp_root_get_protocol_version: received protocol error 0x04
> which probably shouldn't happen.

I managed to reproduce this and have a fix for it locally. It turns out
Bolt sends 0x04 (HIDPP_ERROR_CONNECT_FAIL) whereas Lightspeed (the only
other device I have to test with) send out 0x09
(HIDPP_ERROR_RESOURCE_ERROR) on device disconnect. So the fix is simply
to support 0x04 as well.

>
> I also see the battery not going away, but that looks to be a separate
> problem.
>
> The only thing I haven't tested, and which might need fixing before we
> can merge this is figuring out how quirks can be applied.
>
> The battery reporting works because it probes the available interfaces,
> and reports that.
>
> But what about things like:
>          { /* Signature M650 over Bluetooth */
>            HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
>                                 HIDPP_PRODUCT_SIGNATURE_M650),
>            .driver_data = HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
> which were added in:
> https://patchwork.kernel.org/project/linux-input/list/?series=1121633
>
> The recent "HID: logitech-hidpp: Add support for HID++ Multi-Platform
> feature (0x4531)" doesn't work either:
> https://patchwork.kernel.org/project/linux-input/list/?series=1119501
>
> Cheers

Regarding both the quirks and discrepancy with the bluetooth route, as
well as the Multi-platform feature, I'm still looking into that and
will hopefully have a patch ready in a few days.

Regards,
Erik

>
>> Reported-by: Kateřina Medvědová <k8ie@mcld.eu>
>> Link: https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu/
>> Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
>> ---
>> Changes in v2:
>> - Handle only the Bolt receiver/control interface in hid-logitech-dj and
>>    leave the other Bolt receiver interfaces to generic HID handling.
>> - Handle Bolt HID++ unpair notifications so child HID devices are removed
>>    after unpairing.
>>
>>   drivers/hid/hid-logitech-dj.c    | 48 +++++++++++++++++++++++++++++---
>>   drivers/hid/hid-logitech-hidpp.c | 48 ++++++++++++++++++++++++++++++--
>>   2 files changed, 89 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index 9c574ab8b60b..571d5caa5bb5 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -121,6 +121,7 @@ enum recvr_type {
>>   	recvr_type_27mhz,
>>   	recvr_type_bluetooth,
>>   	recvr_type_dinovo,
>> +	recvr_type_bolt,
>>   };
>>   
>>   struct dj_report {
>> @@ -1156,6 +1157,10 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>>   		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>>   		workitem.reports_supported |= STD_KEYBOARD;
>>   		break;
>> +	case 0x10:
>> +		device_type = "Bolt";
>> +		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>> +		break;
>>   	}
>>   
>>   	/* custom receiver device (eg. powerplay) */
>> @@ -1745,6 +1750,24 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
>>   
>>   	dj_dev = djrcv_dev->paired_dj_devices[device_index];
>>   
>> +	/*
>> +	 * Bolt receivers send explicit unpair notifications as HID++ events;
>> +	 * queue device removal when we receive one.
>> +	 */
>> +	if (djrcv_dev->type == recvr_type_bolt &&
>> +	    hidpp_report->report_id == REPORT_ID_HIDPP_SHORT &&
>> +	    hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
>> +		struct dj_workitem workitem = {
>> +			.device_index = device_index,
>> +			.type = WORKITEM_TYPE_UNPAIRED,
>> +		};
>> +
>> +		kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
>> +		schedule_work(&djrcv_dev->work);
>> +		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
>> +		return false;
>> +	}
>> +
>>   	/*
>>   	 * With 27 MHz receivers, we do not get an explicit unpair event,
>>   	 * remove the old device if the user has paired a *different* device.
>> @@ -1884,6 +1907,9 @@ static int logi_dj_probe(struct hid_device *hdev,
>>   	 * treat these as logitech-dj interfaces then this causes input events
>>   	 * reported through this extra interface to not be reported correctly.
>>   	 * To avoid this, we treat these as generic-hid devices.
>> +	 *
>> +	 * Bolt receivers only use LOGITECH_DJ_INTERFACE_NUMBER for receiver
>> +	 * reporting. Treat all other Bolt interfaces as generic-hid devices.
>>   	 */
>>   	switch (id->driver_data) {
>>   	case recvr_type_dj:		no_dj_interfaces = 3; break;
>> @@ -1897,10 +1923,20 @@ static int logi_dj_probe(struct hid_device *hdev,
>>   	}
>>   	if (hid_is_usb(hdev)) {
>>   		intf = to_usb_interface(hdev->dev.parent);
>> -		if (intf && intf->altsetting->desc.bInterfaceNumber >=
>> -							no_dj_interfaces) {
>> -			hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
>> -			return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>> +		if (intf) {
>> +			bool generic_hid_interface;
>> +
>> +			if (id->driver_data == recvr_type_bolt)
>> +				generic_hid_interface =
>> +					intf->altsetting->desc.bInterfaceNumber !=
>> +					LOGITECH_DJ_INTERFACE_NUMBER;
>> +			else
>> +				generic_hid_interface =
>> +					intf->altsetting->desc.bInterfaceNumber >= no_dj_interfaces;
>> +			if (generic_hid_interface) {
>> +				hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
>> +				return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>> +			}
>>   		}
>>   	}
>>   
>> @@ -2103,6 +2139,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
>>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>   		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
>>   	 .driver_data = recvr_type_gaming_hidpp_ls_1_3},
>> +	{ /* Logitech Bolt receiver (0xc548) */
>> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>> +			 USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
>> +	 .driver_data = recvr_type_bolt},
>>   	{ /* Logitech lightspeed receiver (0xc54d) */
>>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>   		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
>> index 90b0184df777..0b5d0a322ae8 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -4161,8 +4161,50 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
>>   	return ret;
>>   }
>>   
>> +static bool hidpp_is_bolt_child(struct hid_device *hdev)
>> +{
>> +	struct device *parent = hdev->dev.parent;
>> +	struct hid_device *receiver_hdev;
>> +
>> +	if (!parent)
>> +		return false;
>> +
>> +	receiver_hdev = to_hid_device(parent);
>> +	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
>> +	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
>> +}
>> +
>> +static int hidpp_bolt_init(struct hidpp_device *hidpp)
>> +{
>> +	struct hid_device *hdev = hidpp->hid_dev;
>> +	char *name;
>> +	int ret;
>> +
>> +	ret = hidpp_serial_init(hidpp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	name = hidpp_get_device_name(hidpp);
>> +	if (!name)
>> +		return -EIO;
>> +
>> +	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
>> +	dbg_hid("HID++ Bolt: Got name: %s\n", name);
>> +
>> +	kfree(name);
>> +	return 0;
>> +}
>> +
>> +static int hidpp_receiver_init(struct hidpp_device *hidpp)
>> +{
>> +	if (hidpp_is_bolt_child(hidpp->hid_dev))
>> +		return hidpp_bolt_init(hidpp);
>> +
>> +	return hidpp_unifying_init(hidpp);
>> +}
>> +
>>   /* Get name + serial for USB and Bluetooth HID++ devices */
>> -static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
>> +static void hidpp_non_receiver_init(struct hidpp_device *hidpp)
>>   {
>>   	struct hid_device *hdev = hidpp->hid_dev;
>>   	char *name;
>> @@ -4510,9 +4552,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   
>>   	/* Get name + serial, store in hdev->name + hdev->uniq */
>>   	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
>> -		hidpp_unifying_init(hidpp);
>> +		hidpp_receiver_init(hidpp);
>>   	else
>> -		hidpp_non_unifying_init(hidpp);
>> +		hidpp_non_receiver_init(hidpp);
>>   
>>   	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
>>   		connect_mask &= ~HID_CONNECT_HIDINPUT;
