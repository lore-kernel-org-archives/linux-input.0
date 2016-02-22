From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
Date: Mon, 22 Feb 2016 11:41:37 -0800
Message-ID: <56CB6471.3020400@broadcom.com>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160218143617.GH9654@rob-hp-laptop>
 <CAAFb_vq6_uQbcWvwV8TZqVqH_C-ueUd+gBRA=mXUQrWqxoz=ww@mail.gmail.com>
 <20160222193604.GA26177@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:21135
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236AbcBVTmu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 14:42:50 -0500
In-Reply-To: <20160222193604.GA26177@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

My comments below

On 16-02-22 11:36 AM, Dmitry Torokhov wrote:
> On Fri, Feb 19, 2016 at 11:43:50AM +0530, Raveendra Padasalagi wrote:
>> On Thu, Feb 18, 2016 at 8:06 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Wed, Feb 17, 2016 at 03:13:44PM +0530, Raveendra Padasalagi wrote:
>>>> In Cygnus SOC touch screen controller registers are shared
>>>> with ADC and flex timer. Using readl/writel could lead to
>>>> race condition. So touch screen driver is enhanced to support
>>>>
>>>> 1. If touchscreen register's are not shared. Register access
>>>> is handled through readl/writel if "brcm,iproc-touchscreen"
>>>> compatible is provided in touchscreen dt node. This will help
>>>> for future SOC's if comes with dedicated touchscreen IP register's.
>>>>
>>>> 2. If touchscreen register's are shared with other IP's, register
>>>> access is handled through syscon framework API's to take care of
>>>> mutually exclusive access. This feature can be enabled by selecting
>>>> "brcm,iproc-touchscreen-syscon" compatible string in the touchscreen
>>>> dt node.
>>>>
>>>> Hence touchscreen dt node bindings document is updated to take care
>>>> of above changes in the touchscreen driver.
>>>>
>>>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>>>   .../input/touchscreen/brcm,iproc-touchscreen.txt   | 57 +++++++++++++++++++---
>>>>   1 file changed, 51 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>> index 34e3382..f530c25 100644
>>>> --- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
>>>> @@ -1,12 +1,30 @@
>>>>   * Broadcom's IPROC Touchscreen Controller
>>>>
>>>>   Required properties:
>>>> -- compatible: must be "brcm,iproc-touchscreen"
>>>> -- reg: physical base address of the controller and length of memory mapped
>>>> -  region.
>>>> +- compatible: should be one of
>>>> +        "brcm,iproc-touchscreen"
>>>> +        "brcm,iproc-touchscreen-syscon"
>>>
>>> More specific and this is not how you do syscon. Either the block is or
>>> isn't. You can't have it both ways.
>>
>> Existing driver has support for reg, if we modify now to support only syscon
>> then this driver will not work if some one wishes to use previous
>> kernel version's
>> dt and vice versa. Basically this breaks dt compatibility. Is that ok ?
>
> But the issue is that the driver does not actually work correctly with
> direct register access on those systems, since the registers are
> actually shared with other components. I am not quite sure if it is OK
> to break DT binding in this case...

The driver does work correctly with direct register access on those 
systems because the other components using those registers are not 
active in those systems - so syscon is not needed in those cases.

I'm ok with not containing backwards compatibility though and always 
using syscon.  There are no deployed systems using older versions of the 
upstreamed kernel.
>
> Thanks.
>

Regards,
Scott
