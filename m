From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: Re: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
Date: Sat, 27 Feb 2016 12:19:00 +0530
Message-ID: <CAAFb_vqozomcuZ_OaB+d_HWsPqr1VPSTjfYc_Bh9a+vbaLPBpA@mail.gmail.com>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
	<1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
	<20160218143617.GH9654@rob-hp-laptop>
	<CAAFb_vq6_uQbcWvwV8TZqVqH_C-ueUd+gBRA=mXUQrWqxoz=ww@mail.gmail.com>
	<20160222193604.GA26177@dtor-ws>
	<56CB6471.3020400@broadcom.com>
	<47ef2a75-3f97-644f-a817-c93e6b3bc658@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34554 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0GtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2016 01:49:01 -0500
Received: by mail-yk0-f182.google.com with SMTP id u9so44544620ykd.1
        for <linux-input@vger.kernel.org>; Fri, 26 Feb 2016 22:49:01 -0800 (PST)
In-Reply-To: <47ef2a75-3f97-644f-a817-c93e6b3bc658@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

Thanks Scott and Ray for the inputs. I will implement syscon only
register access and send out the changes in patch set - v4.

Regards,
Raveendra

On Tue, Feb 23, 2016 at 1:18 AM, Ray Jui <ray.jui@broadcom.com> wrote:
>
>
> On 2/22/2016 11:41 AM, Scott Branden wrote:
>>
>> My comments below
>>
>> On 16-02-22 11:36 AM, Dmitry Torokhov wrote:
>>>
>>> On Fri, Feb 19, 2016 at 11:43:50AM +0530, Raveendra Padasalagi wrote:
>>>>
>>>> On Thu, Feb 18, 2016 at 8:06 PM, Rob Herring <robh@kernel.org> wrote:
>>>>>
>>>>> On Wed, Feb 17, 2016 at 03:13:44PM +0530, Raveendra Padasalagi wrote:
>>>>>>
>>>>>> In Cygnus SOC touch screen controller registers are shared
>>>>>> with ADC and flex timer. Using readl/writel could lead to
>>>>>> race condition. So touch screen driver is enhanced to support
>>>>>>
>>>>>> 1. If touchscreen register's are not shared. Register access
>>>>>> is handled through readl/writel if "brcm,iproc-touchscreen"
>>>>>> compatible is provided in touchscreen dt node. This will help
>>>>>> for future SOC's if comes with dedicated touchscreen IP register's.
>>>>>>
>>>>>> 2. If touchscreen register's are shared with other IP's, register
>>>>>> access is handled through syscon framework API's to take care of
>>>>>> mutually exclusive access. This feature can be enabled by selecting
>>>>>> "brcm,iproc-touchscreen-syscon" compatible string in the touchscreen
>>>>>> dt node.
>>>>>>
>>>>>> Hence touchscreen dt node bindings document is updated to take care
>>>>>> of above changes in the touchscreen driver.
>>>>>>
>>>>>> Signed-off-by: Raveendra Padasalagi
>>>>>> <raveendra.padasalagi@broadcom.com>
>>>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>>> ---
>>>>>>   .../input/touchscreen/brcm,iproc-touchscreen.txt   | 57
>>>>>> +++++++++++++++++++---
>>>>>>   1 file changed, 51 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>>
>>>>>> a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>>>>
>>>>>> b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>>>>
>>>>>> index 34e3382..f530c25 100644
>>>>>> ---
>>>>>>
>>>>>> a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>>>>
>>>>>> +++
>>>>>>
>>>>>> b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>>>>
>>>>>> @@ -1,12 +1,30 @@
>>>>>>   * Broadcom's IPROC Touchscreen Controller
>>>>>>
>>>>>>   Required properties:
>>>>>> -- compatible: must be "brcm,iproc-touchscreen"
>>>>>> -- reg: physical base address of the controller and length of
>>>>>> memory mapped
>>>>>> -  region.
>>>>>> +- compatible: should be one of
>>>>>> +        "brcm,iproc-touchscreen"
>>>>>> +        "brcm,iproc-touchscreen-syscon"
>>>>>
>>>>>
>>>>> More specific and this is not how you do syscon. Either the block is or
>>>>> isn't. You can't have it both ways.
>>>>
>>>>
>>>> Existing driver has support for reg, if we modify now to support only
>>>> syscon
>>>> then this driver will not work if some one wishes to use previous
>>>> kernel version's
>>>> dt and vice versa. Basically this breaks dt compatibility. Is that ok ?
>>>
>>>
>>> But the issue is that the driver does not actually work correctly with
>>> direct register access on those systems, since the registers are
>>> actually shared with other components. I am not quite sure if it is OK
>>> to break DT binding in this case...
>>
>>
>> The driver does work correctly with direct register access on those
>> systems because the other components using those registers are not
>> active in those systems - so syscon is not needed in those cases.
>>
>> I'm ok with not containing backwards compatibility though and always
>> using syscon.  There are no deployed systems using older versions of the
>> upstreamed kernel.
>>>
>>>
>>> Thanks.
>>>
>>
>> Regards,
>> Scott
>
>
> The iproc touchscreen is currently activated in the "bcm9hmidc.dtsi" that
> represents the optional daughter card installed on reference boards
> bcm958300k and bcm958305k. While not maintaining backwards compatibility
> *might not* be a serious issue, it would be nice if we can at least make
> sure the driver change and DT are merged into the same kernel version so
> they stay in sync.
>
> Going forward, if we are only going to support syscon based implementation,
> the existing compatible string "brcm,iproc-touchscreen" is preferred over
> "brcm,iproc-touchscreen-syscon".
>
> Thanks,
>
> Ray
