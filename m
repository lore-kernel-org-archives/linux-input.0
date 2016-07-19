From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance
 Mat
Date: Tue, 19 Jul 2016 09:08:27 +0300
Message-ID: <78cafd15-850f-3110-f63e-bb41f6b69c5c@kapsi.fi>
References: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
 <20160718142837.GK4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718142837.GK4663@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-input@vger.kernel.org

On 07/18/16 17:28, Benjamin Tissoires wrote:
> On Jul 17 2016 or thereabouts, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>> ...
>>  #include <linux/list.h>
>>  #include <linux/idr.h>
>>  #include <linux/input/mt.h>
>> +#include <linux/usb.h>
>> +
>> +#include "usbhid/usbhid.h"
>
> I spent a lot of effort 2 years ago to remove the usb dependency, I'd
> prefer not adding a strong deps on it again.
>

I see, I'll remove it.

>>
>>  #include "hid-ids.h"
>>
>> @@ -51,6 +54,7 @@
>>  #define NAVIGATION_CONTROLLER_USB BIT(9)
>>  #define NAVIGATION_CONTROLLER_BT  BIT(10)
>>  #define SINO_LITE_CONTROLLER      BIT(11)
>> +#define FUTUREMAX_DANCE_MAT       BIT(12)
>>
>>  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
>>  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
>> @@ -1125,7 +1129,7 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
>>  {
>>  	struct sony_sc *sc = hid_get_drvdata(hdev);
>>
>> -	if (sc->quirks & SINO_LITE_CONTROLLER)
>> +	if (sc->quirks & (SINO_LITE_CONTROLLER | FUTUREMAX_DANCE_MAT))
>>  		return rdesc;
>>
>>  	/*
>> @@ -2288,6 +2292,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  	unsigned long quirks = id->driver_data;
>>  	struct sony_sc *sc;
>>  	unsigned int connect_mask = HID_CONNECT_DEFAULT;
>> +	struct usb_device *usb_dev;
>> +
>> +	if (quirks & SIXAXIS_CONTROLLER_USB) {
>> +		usb_dev = hid_to_usb_dev(hdev);
>> +		if (usb_dev && usb_dev->product &&
>> +		    !strcmp(usb_dev->product, "FutureMax Dance Mat")) {i
>
> If they decided to reuse the same PID than one existing, and you have no
> other choice but to rely on the name, you can simply have a match on
> hdev->name instead of adding the USB dependency.

Ah, didn't notice this!

>
> Also, I think it would be better to have a check on the existing report
> descriptor instead of blindly fixing it. Other drivers make sure they
> are fixing the correct region before overriding it, but I think using a
> md5sum might be just easier (though that's not required for your patch I
> think).

I agree. In fact, the mat used to work back in 3.15 when the driver did 
some rudimentary checks before overwriting the descriptor. In any case, 
it would be difficult for me to add the checks since the mat is the only 
piece of hardware I own that is handled by this driver.

>
> Cheers,
> Benjamin
>
>>  ...

Cheers, and thanks for the review! I'll post a v2 once I get the chance.

Mikko
