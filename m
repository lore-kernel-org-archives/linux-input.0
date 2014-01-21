From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: PDT scan cleanup
Date: Tue, 21 Jan 2014 11:33:15 -0800
Message-ID: <52DECB7B.7080107@synaptics.com>
References: <1389126821-4066-1-git-send-email-cheiny@synaptics.com> <52D056B3.406@synaptics.com> <1754181.lppeTWGTml@dtor-d630.eng.vmware.com> <52D06B1C.1090403@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:18050 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaAUTdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jan 2014 14:33:16 -0500
In-Reply-To: <52D06B1C.1090403@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>


Ping - any followup on this and related patches?

On 01/10/2014 01:50 PM, Christopher Heiny wrote:
> On 01/10/2014 12:31 PM, Dmitry Torokhov wrote:
>> On Friday, January 10, 2014 12:23:15 PM Christopher Heiny wrote:
>>> >On 01/07/2014 12:33 PM, Christopher Heiny wrote:
>>>> > >Eliminates copy-paste code that handled scans of the Page Descriptor
>>>> > >Table,
>>>> > >replacing it with a single PDT scan routine that invokes a callback
>>>> > >function. The scan routine is not static so that it can be used
>>>> by the
>>>> > >firmware update code (under development, not yet submitted).
>>>> > >
>>>> > >Updated the copyright dates while we were at it.
>>> >
>>> >Hi Dmitry,
>>> >
>>> >Could you apply this or provide some feedback on it?  We've got a
>>> >pending patch that depends on it, and that pending work will bring the
>>> >driver back to a working (if not necessarily beautiful) state.  I don't
>>> >want to submit it if this change isn't satisfactory, though.
>  >
>> Speaking of the devil. I was just thinking about it and I wanted to ask
>> you to send me an example of how it is used as I can;t make my mind about
>> it.
>>
>> In general it is OK to submit a few patches at a time even if they are
>> depend on each other - it gives me better context (as long as there
>> aren't 80 of those so that I down in them ;) ).
>>
>> Thanks.
>
> No problem!
>
> Currently the rmi_driver.c iterates over the PDT twice during probe():
>
> 1) find F01 and reset the ASIC;
> 2) create and initialize the function devices & count the number of
> interrupt sources.
>
> followed by
>
> 3) a loop over the function devices allocating each one's interrupt
> related bitmasks.
>
> Unfortunately, depending on how the function drivers are loaded, a
> function driver might access the device's and the function device's
> bitmasks before step (3) is complete.  This causes all kinds of
> unintended consequences, none of which are amusing.
>
> We considered fixing this by splitting the function device creation and
> initialization, like so:
>
> 1) first to find F01 and reset the ASIC;
> 2) count the number of interrupt sources and create the function devices
>
> followed by
>
> 3) a loop over the function devices to allocate their interrupt related
> bitmasks and initialize the function devices
>
> However, this led to function device setup being in two different
> places, which obscured the code and could lead to bugs if someone added
> new code in the wrong place (initialization instead of creation, or vice
> versa).
>
> The PDT scan loops have a lot of redundant boilerplate and were quite
> large compared to the core code that was being iterated, obscuring just
> what the loop was supposed to be doing.  We found it clearer to
> implement a single PDT scan routine, and put the logic for the different
> step in callbacks.  Plus it eliminated the maintenance headaches of
> three (or more, see reflash, below) copy-paste PDT scan loops.
>
> The pending patch (I'll send that right after this note) changes
> rmi_driver.c the order to scan the PDT 3 times:
>
> 1) first to find F01 and reset the ASIC;
> 2) count the number of interrupt sources
> 3) create and initialize the function devices
>
> Similar logic applies in the reflash code, which has rescan the PDT
> after forcing the touch sensor firmware into bootloader mode (the
> bootloader might have a different register map, unfortunately).  Once we
> had the scan+callback routine in rmi_driver.c, it only made sense for
> the reflash library to use that as well.
>
>                  Thanks,
>                      Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
