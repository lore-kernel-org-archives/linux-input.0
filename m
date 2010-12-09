From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Thu, 09 Dec 2010 02:24:53 +0100
Message-ID: <4D002FE5.2070609@euromail.se>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se> <4CFFC3C2.1080905@canonical.com> <AANLkTikmomm2hd7AAJMTnY+=J2wPyVvodv2Ft0jFe7w2@mail.gmail.com> <20101208235805.GE15294@core.coreip.homeip.net> <4D002CE8.2060803@euromail.se> <20101209011752.GH15294@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33106 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928Ab0LIB00 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 20:26:26 -0500
In-Reply-To: <20101209011752.GH15294@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/09/2010 02:17 AM, Dmitry Torokhov wrote:

> On Thu, Dec 09, 2010 at 02:12:08AM +0100, Henrik Rydberg wrote:
>>>>>
>>
>>>>> Is it assumed that the envelop has only two touches comprising it? Or is
>>>>> it any number of touches? If it's any number of touches, how does one
>>>>> know how many touches it is?
>>>>
>>>> Those are good questions. Specifying how many touches are in the
>>>> envelop makes sense. It also covers rectangle as a special case of
>>>> envelop.
>>>
>>> I have a feeling that trying to accomodate non-rectangular, more than 2
>>> point shapes without using native MT data is over-engineering the
>>> problem... Do we have examples other than older generation Elantechs and
>>> Synaptics that need envelope notion?
>>>
>>
>>
>> Those are the ones targeted so far. Maybe appletouch could be added to the list
>> as well. I imagine all drivers will end up using zero, one and two envelope points.
> 
> Even ones that fully support independent finger tracking?
> 


No, sorry, that should read "all drivers in that list". The ones that can detect
individual fingers in space are fine as they are.
