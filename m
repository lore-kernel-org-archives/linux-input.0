From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/5] Input: elantech - support the Fujitsu H730 laptop
Date: Mon, 01 Sep 2014 09:13:57 +0200
Message-ID: <54041CB5.7050502@redhat.com>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org> <5402F0D1.1050200@redhat.com> <20140831151434.GA15521@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbaIAHOG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Sep 2014 03:14:06 -0400
In-Reply-To: <20140831151434.GA15521@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>

Hi,

On 08/31/2014 05:14 PM, ulrik.debie-os@e2big.org wrote:
> Hi
> On Sun, Aug 31, 2014 at 11:54:25AM +0200, Hans de Goede wrote:
>> Date:	Sun, 31 Aug 2014 11:54:25 +0200
>> From: Hans de Goede <hdegoede@redhat.com>
>> To: Ulrik De Bie <ulrik.debie-os@e2big.org>, Dmitry Torokhov
>>  <dmitry.torokhov@gmail.com>
>> CC: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
>> Subject: Re: [PATCH 0/5] Input: elantech - support the Fujitsu H730 laptop
>> X-Mailing-List:	linux-input@vger.kernel.org
>>
>> Hi,
>>
>> On 08/30/2014 04:10 PM, Ulrik De Bie wrote:
>>> This patch set makes the elantech driver work for the Fujitsu H730 laptop. It
>>> also adds a sysfs knob to allow other laptops that are facing similar
>>> problems as the Fujitsu H730 to have working touchpad.
>>>
>>> I'm considering adding a WARN_ONCE when the crc_enabled signature check
>>> fails. The message would then point the user to the crc_enabled sysfs knob,
>>> and kindly ask the user to report the laptop to linux-input mailinglist ?
>>> Any suggestions ?
>>
>> WARN_ONCE includes a backtrace, which will just scare users, simply use a
>> function static variable to build your own warn_once, which really only does
>> warn. Other then that I think having a warning pointing to to the sysfs knob is
>> a good idea. Although maybe it should only trigger on 2 consecutive crc errors
>> to avoid false positives?
> 
> The static variable variant exists as printk_once. But of course, that one
> will not allow easy check on 2 consecutive.

Right, still spurious triggering is rather unlikely to actually happen, so lets
just go with printk_once.

>  
>>> Two users have tested the combination of this patchset and confirmed that
>>> it makes the H730 touchpad/trackpoint work.
>>>
>>> Here an overview of the patchset:
>>>
>>> Patch 1/ : Input: elantech - use elantech_report_trackpoint for hardware v4 too
>>> The Fujitsu H730 is the first v4 hardware identified that also sends the
>>> trackpoint packets. This patch enables the trackpoint on v4 hardware.
>>> With this patch the trackpoint will work.
>>>
>>> Patch 2/ : Input: elantech - Fix crc_enabled for Fujitsu H730
>>> Uses DMI to detect the H730 and ,if detected, will set crc_enabled to 1. 
>>> With this patch the touchpad and left/right button will start to work.
>>>
>>> Patch 3/ : Input: elantech - report the middle button of the touchpad
>>> The Fujitsu H730 is the first laptop listed in the elantech.c file with
>>> 3 touchpad buttons. This patch enables the middle button for all elantech
>>> hardware and enables the reporting for v4 hardware.
>>> I want to hear feedback here on what preferences exist for the conditions
>>> to enable the middle button:
>>> - DMI
>>> - enable only for v4
>>> - enable for all/report for v3+v4
>>
>> I assume you've tested this on a v4 model without a middle button ? Assuming
>> that that is the case I think that always enabling it on v4 is fine. I see no
>> reason to also enable it on v3 as long as we've no reports of v3 models with
>> 3 buttons.
> 
> No I have only tested myself on L530 (v3 with 2 touchpad buttons) and the two
> testers have tested on Fujitsu H730 (v4 with 3 touchpad buttons).
> 
> Looking at the list in elantech, that would preferably be a test on Asus
> G46VW or G750JX. Since you were able to come up with the list, do you
> happen also to know contact details of some with such a laptop ?

I made that list by manual scraping info from forum and bug tracker posts,
so I'm afraid I've no contact info. All the other touchpad drivers sofar
are able to test for a middle button press without getting spurious
presses on laptops which don't have a middle button. So lets just move forward
with your patch as is, we can always go the dmi quirk route if it turns out
to cause troubles.

> 
>>> ...
>>>
>>> Patch 4/ : Input: Elantech - provide a sysfs knob for crc_enabled
>>> Probably H730 will not remain the only elantech laptop that has this failing
>>> detection for the crc_enabled. This provides users with a workaround when
>>> the crc_enabled detection fails.
>>>
>>> Patch 5/ : Elantech - Update the documentation: trackpoint,v3/v4,crc_enabled
>>> This provides an update of the elantech documentation. 
>>>
>>> Patch 4 depends on patch 2, and for consistency, patch 5 depends on patch 1-2-4.
>>>
>>> Ulrik De Bie (5):
>>>   Input: elantech - use elantech_report_trackpoint for hardware v4 too
>>>   Input: elantech - Fix crc_enabled for Fujitsu H730
>>>   Input: elantech - report the middle button of the touchpad
>>>   Input: elantech - provide a sysfs knob for crc_enabled
>>>   Input: elantech - Update the documentation:
>>>     trackpoint,v3/v4,crc_enabled
>>
>> The entire series looks good to me (the adding of the warning can be done in a follow
>> up patch), and is:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
>>
>> Hans
> 
> Thanks for your feedback !
> 
> Regards,
> Ulrik
> 
