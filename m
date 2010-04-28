From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: [PATCH] Reset ps/2 port  should psmouse_probe fail before retrying
Date: Wed, 28 Apr 2010 16:17:24 -0400
Message-ID: <4BD897D4.4060405@canonical.com>
References: <1271723857.6652.6.camel@lovely> <20100422215517.GB28213@core.coreip.homeip.net> <1271983668.16254.44.camel@lovely> <201004230953.52447.dmitry.torokhov@gmail.com> <4BD1EB1C.1070200@canonical.com> <20100428170721.GA6608@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51016 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0D1UR1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Apr 2010 16:17:27 -0400
In-Reply-To: <20100428170721.GA6608@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>, Christopher Heiny <cheiny@synaptics.com>

Dmitry,

This Dell in question do not have an option to disable the
touchpad. The BIOS options are unremarkable.

Peter

On 04/28/2010 01:07 PM, Dmitry Torokhov wrote:
> On Fri, Apr 23, 2010 at 02:46:52PM -0400, Peter M. Petrakis wrote:
>> Here are the dmesg boot logs with i8042.debug. 
>>
>> On 04/23/2010 12:53 PM, Dmitry Torokhov wrote:
>>> On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:
>>>> Am Donnerstag, den 22.04.2010, 14:55 -0700 schrieb Dmitry Torokhov:
>>>>> On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This one is a winner. with regards to your follow up. I wouldn't
>>>>>> want to reset something unless we have cause to. This code
>>>>>> seems to be doing the right thing e.g. I see "unable to query
>>>>>> synaptics hardware" followed by it's (re)discovery on return
>>>>>> from S3.
>>>>>>
>>>>>> When it's fully supported by the Synaptics driver, the initial
>>>>>> reconnect will succeed and we'll never get to this additional
>>>>>> failsafe code which is essentially a catch all for the bleeding
>>>>>> edge.
>>>>>
>>>>> I am confused here... what protocol does the kernel select upon fresh
>>>>> boot?
>>>>
>>>> Peter's dmesg:
>>>>
>>>> [    7.428561] Unable to query Synaptics hardware.
>>>>
>>>>  It's plain PS/2 or IMPS/2 because this bleeding edge device fails
>>>> somewehre in synaptics_query_hardware(). Most likely the test on
>>>> priv->identity.
>>>
>>> Ah, I missed that. Peter, could you boot with i8042.debug so we could see 
>>> where exactly Synaptics detection fails?
>>>
> 
> Indeed, capability request returns "d0 00 73" whereas we expect 0x47 in
> the middle byte.
> 
> Peter, please make sure that you do not have touchpad disabled in BIOS
> (at least other Dells that I seen had similar options).
> 
> Cristofer, do you know by any chance why touchpad reporing firmware 7.5
> would return such unexpected answer to 0x02 query?
> 
> Thanks!
> 
