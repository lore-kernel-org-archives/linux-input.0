From: "don@homedns" <don@prince.homedns.org>
Subject: Re: [PATCH 2.6.34-rc7] HID: hid-samsung: add support for Creative
 Desktop Wireless 6000
Date: Sun, 16 May 2010 13:12:22 +0100
Message-ID: <4BEFE126.4080606@prince.homedns.org>
References: <4BEF3D1F.6080403@yahoo.co.uk> <4BEFCA05.8000402@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BEFCA05.8000402@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schedel <r.schedel@yahoo.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 16/05/10 11:33, Robert Schedel wrote:

> Hello,
>
> On 16.05.2010 02:32, Don Prince wrote:
>   
>> Add support for the Creative Desktop Wireless 6000 keyboard/mouse
>> bundle's multimedia buttons which are not currently handled by
>> the default/samsung HID driver.
>>
>> Signed-off-by: Don Prince <dhprince-devel@yahoo.co.uk>
>>
>> ---
>> [...]
>>     
> As originator of the "old" 0419:0001 IrDA driver parts had a short look at it:
> - Merging with old code looks OK. Tested with old 0419:0001 (184) device, still functional.
> - 0419:0600 not yet known in usb.ids, might be worth a contribution
> - As you merged in a new device, and for explaining why this handling was added, my suggestion is to adapt the existing comments, e.g.:
>
> /*
>  * This driver supports several HID devices:
>  *
>  * [0419:0001] Samsung IrDA remote controller (reports as Cypress USB Mouse).
>  *
>  * There are several variants:
>  *
>  * 1. 184 byte report descriptor
> [...]
>  * [0419:0600] Creative Desktop Wireless 6000 keyboard/mouse combo
>  *
>  * Several key mappings used from the consumer usage page
>  * deviate from the USB HUT 1.12 standard.
>  */
>
> Of course some HID maintainer should also review it, for general policy.
>
> Regards,
> Robert Schedel
>
>   
Ok I'll add some comments and re-submit patch as v2.

Regards

Don Prince
