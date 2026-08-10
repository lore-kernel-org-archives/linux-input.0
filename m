Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298C380FE3
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396037; cv=none; b=RLEO6LUv4oLM4IYarpf+8XrCW/cYpL7NgIamwCjCNSBPbtb5Odhs/AESAXwU725Vdu6JypecYu0jv5gTCGF/HEZM51wFde6jXxsQPAggNcIjGlvTM8BDKee0EkbDnsjQ8VHM1xvm6aRxHpZay6OoR+nlEoMdSsIWZCnjluagFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396037; c=relaxed/simple;
	bh=/T8U9NdTV/+3SNJb7FSNMBawK0sSjzwDYlo3kUDE0iE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FuevXdwPiacYPhNLKZVbm0uWkevVG08mrEI2cYltBkEZ/1rRWrYb7hXiRs8DTWHyO3zQFjpeCHjjDfbldpGC/rhcMz8v+3EFUEh6LYbsJRdBnfs9uv4Wwh12ptbz8BQom9WN7TNQUQ7suS5CZcdH+WfA/uKuzN6nPTMaW1BNTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVVT+cra; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVVT+cra"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so252991566b.3
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786396034; x=1787000834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxsJF72+QCFOesRRQzW2zbIMARhiebhkt+obnMYAcOc=;
        b=VVVT+cra9bbnoh5HpwKzuof86U2FtJZ6bEokQfKlnDvGS3OQX49s4Dayz+rn1BGi43
         EcPvfkaA2IF57XbB/c/PYBVKFo3p6s8xCd8K1oGaTBkmMC7xqk3edFo9oaSTWXKYBY4q
         33Nh6HyStGB7KwJAhbAALwUeL//pCkDgjcR5QbHJo6WA9/6l+xWbw8+0c87LwzNF25c2
         KTi6bNP9FPYxNWYZRSlin3YEqlMpqMoPJKhlMs+fs8YZGkC1I6Adn4ZHa+NNm0b+1Y1D
         fhnXv5kHpsHkEUMey9yBG64UeEQKdJba8Qk2Mtiv4MyC1Kqzx9cluXslY5s9jG3ScE85
         j1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396034; x=1787000834;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxsJF72+QCFOesRRQzW2zbIMARhiebhkt+obnMYAcOc=;
        b=il9CPzdLoieE1o2SDOMd2aeHzmp+IEgDpcln/UY/af3r4almd5TXu/rI3CH1e9AEdH
         kIkqcmvnKs7+4zEoH/Pht7hVTwL3YqVcptCP3VfvmJMQtrJE5fBYl0zztIWnSsAPpWIS
         2tVhKB/YLnBdkhg9IKDSmRUmVNtm11Jf2IKv3KXhiwYksy9I3Y/Cmxh3mveIStKmzExS
         RsgEcF89Bi80dQh5S45w+G2H9QMsa1ICI9pIIeAEhY+MdMzLJc9AdPnSPSjZ9rNHG5O2
         i5HpPDZG1an+FCXqPzUjTj6wH+wAZsvcRVTSGRJmSxGGdCyCMc/q8IGxk5fAlxb4Ieou
         kFAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPjEOauoCK2C2XMXhucpK0tWjV1cCYD0R33nRN3Vd8gL6Wa4KiRxbet6Bi/6hhoaKdo2oDP6cSNXsTNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoiOklztz2ONkVRuzsPGlBYmj+DgF02zf7U8iSw1I3jMRnz4a
	v6iPeBLgu+QQsIbphiDXhA96hUR50WLr7Kk6+igQmGPYtY1R0WjYQThX
X-Gm-Gg: AR+sD10yGVV09KYOY3rxTDOlVi7vmr8UzKqY79mM/xKu6VE1c80GWsGLAUnpSqDHQNN
	kXObvHsH3qj+F4EuEJPH+lIVc6c0+3MlgmzIi9sbgwrki9mbtsrrrLyNTQapRrDT6INaawDGuH1
	Llgsg9YfEZQCqZvCzub0yf9j4v6OosL9LQkFWvbW0/gNAwUIxTqnzjpJVeGq/oQfcn/cC5wUsyQ
	iJjvf0AYVvbAPpVkAiznY0C1sxnB4x1WLmhSkHBUW2kBIhdVQwm0yhqQC1YQ53HhJ5Y+3oDhLTa
	x5kh06e3perYBXxvL5uvlTQiSmAQDNot6mYusVAYccSg89IycvfBgZ4yWTPbWfLhMZUAjoPPZ9D
	YYXX66K1wFQhNP/FMeWLmV6juOzBDRzFWdOqIxLeW33mWLc11EFg0WNLtZ+4YCdamVONHb/dZTh
	K+4MikcAlbocGi+u9o05AUoQWpI69vxd2dG7L280TBhhHKtZROGjZh8DljITXGSn3LY2Ck2U3Zh
	AxFdpjz2XXbBQXRLdbHhdl59EOi4JM5
X-Received: by 2002:a17:906:5a99:b0:c1f:c7f0:b433 with SMTP id a640c23a62f3a-c208729e00cmr911215866b.9.1786396034032;
        Mon, 10 Aug 2026 14:07:14 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cf68c2sm444908866b.57.2026.08.10.14.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 14:07:13 -0700 (PDT)
Message-ID: <24c60b35-4528-44be-9e11-a8b9a81c47ac@gmail.com>
Date: Mon, 10 Aug 2026 23:07:11 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
From: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
To: Bastien Nocera <hadess@hadess.net>, jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, k8ie@mcld.eu, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
 <20260713201201.391538-1-erikhakan@gmail.com>
 <20260713201201.391538-2-erikhakan@gmail.com>
 <87314b89c73bd06c9824da73811a53b3f88a5059.camel@hadess.net>
 <bce18a69-a7ce-4aa3-b631-59613c8ce114@gmail.com>
Content-Language: en-US
In-Reply-To: <bce18a69-a7ce-4aa3-b631-59613c8ce114@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/2/26 01:18, Erik Håkansson wrote:
> Hi!
>
> Thanks for the review!
> I've looked into the issues a bit.
>
> On 7/30/26 10:36, Bastien Nocera wrote:
>> Hey Eric,
>>
>> On Mon, 2026-07-13 at 22:12 +0200, Erik Håkansson wrote:
>>> Add Logitech Bolt receiver support to the Logitech HID receiver and
>>> HID++ drivers.
>>>
>>> Handle Bolt receiver notifications in hid-logitech-dj and add a
>>> Bolt-specific initialization path in hid-logitech-hidpp, separate from
>>> the existing Unifying receiver path.
>>>
>>> This allows Bolt-connected HID++ devices to expose battery information
>>> through the kernel power_supply path, so userspace tools can report
>>> their battery status with the correct device model.
>>>
>>> Tested with:
>>> - Logitech MX Keys for Business via Bolt receiver
>> I tested this with a Bolt receiver connected to the same M650 mouse I
>> used in another test earlier, and my Slim Solar+ keyboard.
>>
>> Every time the mouse is turned off, I get:
>> kernel: logitech-hidpp-device 0003:046D:B02A.0009: 
>> hidpp_root_get_protocol_version: received protocol error 0x04
>> which probably shouldn't happen.
>
> I managed to reproduce this and have a fix for it locally. It turns out
> Bolt sends 0x04 (HIDPP_ERROR_CONNECT_FAIL) whereas Lightspeed (the only
> other device I have to test with) send out 0x09
> (HIDPP_ERROR_RESOURCE_ERROR) on device disconnect. So the fix is simply
> to support 0x04 as well.

I've submitted a new version of the patch with a fix for this now.

>
>>
>> I also see the battery not going away, but that looks to be a separate
>> problem.
>>
>> The only thing I haven't tested, and which might need fixing before we
>> can merge this is figuring out how quirks can be applied.
>>
>> The battery reporting works because it probes the available interfaces,
>> and reports that.
>>
>> But what about things like:
>>          { /* Signature M650 over Bluetooth */
>>            HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
>>                                 HIDPP_PRODUCT_SIGNATURE_M650),
>>            .driver_data = HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
>> which were added in:
>> https://patchwork.kernel.org/project/linux-input/list/?series=1121633
>>
>> The recent "HID: logitech-hidpp: Add support for HID++ Multi-Platform
>> feature (0x4531)" doesn't work either:
>> https://patchwork.kernel.org/project/linux-input/list/?series=1119501
>>
>> Cheers
>
> Regarding both the quirks and discrepancy with the bluetooth route, as
> well as the Multi-platform feature, I'm still looking into that and
> will hopefully have a patch ready in a few days.
So I looked into both of these. Regarding the quirks for M650, we could
simply add a Bolt-specific LDJ_DEVICE() for each product that needs the
quirk, i.e. currently only the M650. This is easy and straight-forward but
each it duplicates the entries for M650 (Bluetooth + Bolt).
The alternative would be to do a bigger refactoring and apply quirks
independently of transport and instead key it to the product ID. That might
be difficult to align with how quirks are applied for legacy stuff though.

As for the multi-platform functionality, it seems that it does already work
however there seems to be a timing issue. Often the feature discovery fails
with HIDPP_ERROR_CONNECT_FAIL (0x04) when done during probe-time.
I tried adding hidpp_multiplatform_init(hidpp); to the connect event too and
that seemed to solve the issue.

So I think there's pretty straight forward fixes for both those issues, 
however
since those patches aren't merged I haven't submitted any fix for that yet.
I'm new to kernel patches so I don't know how work like this is usually 
done,
but I'm happy to support however it should be done :)

I don't think there are any other unresolved issues now, right? I 
checked into
testing out an older UPower version and it behaved the same when powering
off a device:
The battery object remained present, its state changed from discharging to
unknown, and no other visible change occurred. `udevadm monitor -k -p`
still showed POWER_SUPPLY_ONLINE changing from 1 to 0.

Regards,
Erik
>>
>>> Reported-by: Kateřina Medvědová <k8ie@mcld.eu>
>>> Link: 
>>> https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu/
>>> Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Handle only the Bolt receiver/control interface in hid-logitech-dj 
>>> and
>>>    leave the other Bolt receiver interfaces to generic HID handling.
>>> - Handle Bolt HID++ unpair notifications so child HID devices are 
>>> removed
>>>    after unpairing.
>>>
>>>   drivers/hid/hid-logitech-dj.c    | 48 
>>> +++++++++++++++++++++++++++++---
>>>   drivers/hid/hid-logitech-hidpp.c | 48 
>>> ++++++++++++++++++++++++++++++--
>>>   2 files changed, 89 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-logitech-dj.c 
>>> b/drivers/hid/hid-logitech-dj.c
>>> index 9c574ab8b60b..571d5caa5bb5 100644
>>> --- a/drivers/hid/hid-logitech-dj.c
>>> +++ b/drivers/hid/hid-logitech-dj.c
>>> @@ -121,6 +121,7 @@ enum recvr_type {
>>>       recvr_type_27mhz,
>>>       recvr_type_bluetooth,
>>>       recvr_type_dinovo,
>>> +    recvr_type_bolt,
>>>   };
>>>     struct dj_report {
>>> @@ -1156,6 +1157,10 @@ static void 
>>> logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>>>           logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, 
>>> &workitem);
>>>           workitem.reports_supported |= STD_KEYBOARD;
>>>           break;
>>> +    case 0x10:
>>> +        device_type = "Bolt";
>>> +        logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, 
>>> &workitem);
>>> +        break;
>>>       }
>>>         /* custom receiver device (eg. powerplay) */
>>> @@ -1745,6 +1750,24 @@ static int logi_dj_hidpp_event(struct 
>>> hid_device *hdev,
>>>         dj_dev = djrcv_dev->paired_dj_devices[device_index];
>>>   +    /*
>>> +     * Bolt receivers send explicit unpair notifications as HID++ 
>>> events;
>>> +     * queue device removal when we receive one.
>>> +     */
>>> +    if (djrcv_dev->type == recvr_type_bolt &&
>>> +        hidpp_report->report_id == REPORT_ID_HIDPP_SHORT &&
>>> +        hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
>>> +        struct dj_workitem workitem = {
>>> +            .device_index = device_index,
>>> +            .type = WORKITEM_TYPE_UNPAIRED,
>>> +        };
>>> +
>>> +        kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
>>> +        schedule_work(&djrcv_dev->work);
>>> +        spin_unlock_irqrestore(&djrcv_dev->lock, flags);
>>> +        return false;
>>> +    }
>>> +
>>>       /*
>>>        * With 27 MHz receivers, we do not get an explicit unpair event,
>>>        * remove the old device if the user has paired a *different* 
>>> device.
>>> @@ -1884,6 +1907,9 @@ static int logi_dj_probe(struct hid_device *hdev,
>>>        * treat these as logitech-dj interfaces then this causes 
>>> input events
>>>        * reported through this extra interface to not be reported 
>>> correctly.
>>>        * To avoid this, we treat these as generic-hid devices.
>>> +     *
>>> +     * Bolt receivers only use LOGITECH_DJ_INTERFACE_NUMBER for 
>>> receiver
>>> +     * reporting. Treat all other Bolt interfaces as generic-hid 
>>> devices.
>>>        */
>>>       switch (id->driver_data) {
>>>       case recvr_type_dj:        no_dj_interfaces = 3; break;
>>> @@ -1897,10 +1923,20 @@ static int logi_dj_probe(struct hid_device 
>>> *hdev,
>>>       }
>>>       if (hid_is_usb(hdev)) {
>>>           intf = to_usb_interface(hdev->dev.parent);
>>> -        if (intf && intf->altsetting->desc.bInterfaceNumber >=
>>> -                            no_dj_interfaces) {
>>> -            hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
>>> -            return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>>> +        if (intf) {
>>> +            bool generic_hid_interface;
>>> +
>>> +            if (id->driver_data == recvr_type_bolt)
>>> +                generic_hid_interface =
>>> + intf->altsetting->desc.bInterfaceNumber !=
>>> +                    LOGITECH_DJ_INTERFACE_NUMBER;
>>> +            else
>>> +                generic_hid_interface =
>>> + intf->altsetting->desc.bInterfaceNumber >= no_dj_interfaces;
>>> +            if (generic_hid_interface) {
>>> +                hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
>>> +                return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>>> +            }
>>>           }
>>>       }
>>>   @@ -2103,6 +2139,10 @@ static const struct hid_device_id 
>>> logi_dj_receivers[] = {
>>>         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
>>>        .driver_data = recvr_type_gaming_hidpp_ls_1_3},
>>> +    { /* Logitech Bolt receiver (0xc548) */
>>> +      HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> +             USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
>>> +     .driver_data = recvr_type_bolt},
>>>       { /* Logitech lightspeed receiver (0xc54d) */
>>>         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
>>> diff --git a/drivers/hid/hid-logitech-hidpp.c 
>>> b/drivers/hid/hid-logitech-hidpp.c
>>> index 90b0184df777..0b5d0a322ae8 100644
>>> --- a/drivers/hid/hid-logitech-hidpp.c
>>> +++ b/drivers/hid/hid-logitech-hidpp.c
>>> @@ -4161,8 +4161,50 @@ static int hidpp_initialize_battery(struct 
>>> hidpp_device *hidpp)
>>>       return ret;
>>>   }
>>>   +static bool hidpp_is_bolt_child(struct hid_device *hdev)
>>> +{
>>> +    struct device *parent = hdev->dev.parent;
>>> +    struct hid_device *receiver_hdev;
>>> +
>>> +    if (!parent)
>>> +        return false;
>>> +
>>> +    receiver_hdev = to_hid_device(parent);
>>> +    return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
>>> +           receiver_hdev->product == 
>>> USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
>>> +}
>>> +
>>> +static int hidpp_bolt_init(struct hidpp_device *hidpp)
>>> +{
>>> +    struct hid_device *hdev = hidpp->hid_dev;
>>> +    char *name;
>>> +    int ret;
>>> +
>>> +    ret = hidpp_serial_init(hidpp);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    name = hidpp_get_device_name(hidpp);
>>> +    if (!name)
>>> +        return -EIO;
>>> +
>>> +    snprintf(hdev->name, sizeof(hdev->name), "%s", name);
>>> +    dbg_hid("HID++ Bolt: Got name: %s\n", name);
>>> +
>>> +    kfree(name);
>>> +    return 0;
>>> +}
>>> +
>>> +static int hidpp_receiver_init(struct hidpp_device *hidpp)
>>> +{
>>> +    if (hidpp_is_bolt_child(hidpp->hid_dev))
>>> +        return hidpp_bolt_init(hidpp);
>>> +
>>> +    return hidpp_unifying_init(hidpp);
>>> +}
>>> +
>>>   /* Get name + serial for USB and Bluetooth HID++ devices */
>>> -static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
>>> +static void hidpp_non_receiver_init(struct hidpp_device *hidpp)
>>>   {
>>>       struct hid_device *hdev = hidpp->hid_dev;
>>>       char *name;
>>> @@ -4510,9 +4552,9 @@ static int hidpp_probe(struct hid_device 
>>> *hdev, const struct hid_device_id *id)
>>>         /* Get name + serial, store in hdev->name + hdev->uniq */
>>>       if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
>>> -        hidpp_unifying_init(hidpp);
>>> +        hidpp_receiver_init(hidpp);
>>>       else
>>> -        hidpp_non_unifying_init(hidpp);
>>> +        hidpp_non_receiver_init(hidpp);
>>>         if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
>>>           connect_mask &= ~HID_CONNECT_HIDINPUT;
