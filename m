From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Thu, 10 Jul 2014 09:32:16 +0200
Message-ID: <53BE4180.4030907@redhat.com>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz> <20140709165438.GC10364@core.coreip.homeip.net> <20140709174821.GA30912@suse.cz> <20140709193830.GE10364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbaGJHcW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 03:32:22 -0400
In-Reply-To: <20140709193830.GE10364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi,

On 07/09/2014 09:38 PM, Dmitry Torokhov wrote:
> On Wed, Jul 09, 2014 at 07:48:21PM +0200, Vojtech Pavlik wrote:
>> On Wed, Jul 09, 2014 at 09:54:38AM -0700, Dmitry Torokhov wrote:
>>> On Wed, Jun 25, 2014 at 11:42:43AM +0200, Jiri Kosina wrote:
>>>> Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
>>>> misbehaves rather randomly.
>>>>
>>>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>>>>
>>>> ---
>>>>
>>>> Hi Dmitry,
>>>>
>>>> I've come across this a few year old patch originating from our internal 
>>>> bugzilla, which was apparently been lost between the cracks somewhere. 
>>>> We've been carrying it in our kernel tree for quite some time ... could 
>>>> you please apply it? Thanks.
>>>
>>> I will. I also wonder if by now we should stop defaulting to MUX mode:
>>> all newer desktop/server boxes use USB, only laptops still use PS/2,
>>
>> MUX mode was only ever available on laptops - no desktop computer I'm
>> aware of ever had it.
> 
> Yeah, I don't recall seeing one either.
> 
>>
>>> and quite a few of them not implement active MUX properly. 
>>
>> Do you still get reports of non-working, but advertized Active
>> Multiplexing mode on new laptops?
> 
> Evey now and then... Vendors seem to not normally touch that code.
> 
>>
>>> I also expect
>>> that most of external PS/2 mice are dead by now, so number of cases when
>>
>> One would at least hope so. Sadly, internal mice and PS/2 keyboards
>> aren't going to go away any soon, due to larger power consumption of USB
>> devices.
> 
> Right, but we are not talking about mouse vs keyboard, they use separate
> ports anyway, it is touchpad plus external PS/2 mouse case where active
> MUX might help.

What about laptops with both a touchpad and a trackpoint ? I think in most
cases the trackpoint works through some sort of pass-through mode of the
touchpad (or is outright part of the touchpad ps/2 device), but are we
sure there are no cases where the trackpoint and touchpad are really
separate ps/2 devices hookedup through an active mux ?

> 
>>
>>> we have users with PS/2 touchpad + external PS/2 mouse + working active
>>> MUX is exceedingly small.
>>>
>>> Let's pull Vojtech in ;)
>>
>> What I'd prefer is to, based on DMI data, report but not enable by
>> default Active MUX mode on any machine manufactured after a certain
>> date. Plus have a DMI-based whitelist for machines that absolutely
>> needed, if any are found later.
> 
> Looking at the changes to nomux blacklist sometimes even trying MUX
> messes up KBC. Instead of playing date games I'd rather simply make
> i8042.nomux default. I'm fine with having whitelist for boxes that
> actually need and support muxing properly.

I'm a bit skeptical about making this change, see above.

Regards,

Hans
