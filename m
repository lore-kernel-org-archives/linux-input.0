From: Michael Wright <michaelwr@android.com>
Subject: Re: ABS_MT_TOUCH_MAJOR metric
Date: Thu, 22 May 2014 12:45:55 -0700
Message-ID: <CALDEARic5B86+Cfo+HgCeeGX2t4=LHRTOiLmACN1=YsoGaKS0A@mail.gmail.com>
References: <537DD98C.5090800@cypress.com> <20140522172353.GA1984@core.coreip.homeip.net>
 <537E5027.9010705@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:55557 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaEVTqQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 15:46:16 -0400
Received: by mail-yh0-f43.google.com with SMTP id v1so3435364yhn.30
        for <linux-input@vger.kernel.org>; Thu, 22 May 2014 12:46:15 -0700 (PDT)
In-Reply-To: <537E5027.9010705@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Yes, you do know the min / max values via EVICGABS. That being said,
you don't want to use these values to scale from surface units to
screen coordinates, as those only tell you the max reported width.
ABS_MT_TOUCH_MAJOR should be in the same units that ABS_X and ABS_Y
are for that device, so you should use those scaling values to do the
mapping. Theoretically the resolution should be exactly the same for
both, if you want to do the conversion into physical units (i.e. mm).

On Thu, May 22, 2014 at 12:29 PM, Ferruh Yigit <fery@cypress.com> wrote:
> On 05/22/2014 08:23 PM, Dmitry Torokhov wrote:
>> Hi Ferruh,
>>
>> On Thu, May 22, 2014 at 02:03:40PM +0300, Ferruh Yigit wrote:
>>> Hi,
>>>
>>> What is the metric of ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR events?
>>>
>>> The Linux documentation
>>> <https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt> says:
>>> "The length of the major axis of the contact. The length should be given
>>> in surface units. ..."
>>>
>>> What does "surface units" means, is it millimeter or pixels?
>> It is whatever unit the device reports, similarly to ABS_MT_POSITION_X
>> and ABS_MT_POSITION_Y. Userspace can use EVIOCGABS to map device units
>> onto common units.
>>
>> From include/uapi/linux/input.h (struct input_absinfo):
>>
>>  * Resolution for main axes (ABS_X, ABS_Y, ABS_Z) is reported in
>>  * units per millimeter (units/mm), resolution for rotational axes
>>  * (ABS_RX, ABS_RY, ABS_RZ) is reported in units per radian.
>>
>> Hope this helps.
>>
> Hi Dmitry,
>
> I understand this works for Dmitry ABS_X, ABS_Y,
> touchscreen reports between 0..A, screen resolution is 0..B, a mapping
> can be done 0..A -> 0..B
>
> But for ABS_MT_TOUCH_MAJOR how this scaling can be done,
> touchscreen reports between 0..A, do we know the min/max values for
> application side?
>
> --
>
> Thanks,
> ferruh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
