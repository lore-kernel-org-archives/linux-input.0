From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v4] Input: synaptics-rmi4: Add F30 support
Date: Thu, 13 Aug 2015 10:40:16 -0700
Message-ID: <55CCD680.5060503@synaptics.com>
References: <1406245641-6263-1-git-send-email-aduggan@synaptics.com> <20140727072624.GA15556@core.coreip.homeip.net> <55C54F23.2020306@synaptics.com> <20150813163807.GB15693@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:41520 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753608AbbHMRkR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 13:40:17 -0400
In-Reply-To: <20150813163807.GB15693@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

Hi Dmitry,

On 08/13/2015 09:38 AM, Dmitry Torokhov wrote:
> Hi Andrew,
>
> On Fri, Aug 07, 2015 at 05:36:51PM -0700, Andrew Duggan wrote:
>> Hi Dmitry,
>>
>> With the renewed interest in supporting SMBus with the Synaptics
>> RMI4 driver I thought I would look into this again. I'm sorry for
>> not responding to your comments sooner, especially since you took
>> the time to read the F30 spec. Now that it has been over a year
>> later we may need to essentially start over. But, this time I will
>> make sure to follow up and hopefully not waste your time in the
>> future.
> This is great and I agree that we need to get RMI4 into kernel proper.
> Unfortunately it is quite large body of code and I am afraid that I wont
> be able to give it enough attention until mid-September.
>
> In the meantime, Benjamin, maybe you could work with Andrew? You have
> done a lot of work on input side.

I understand, it is a lot of code. If you have time later this year to 
work on it then that would be great! In the meantime, I'll post the 
device tree related patches I've been working on the last couple of days 
and then we can go from there when you have time.

Thanks,
Andrew

> Thanks.
>
>> On 07/27/2014 12:26 AM, Dmitry Torokhov wrote:
>>> Hi Andrew,
>>>
>>>
>>> On Thu, Jul 24, 2014 at 04:47:21PM -0700, Andrew Duggan wrote:
>>>> RMI4 Function 0x30 provides support for GPIOs, LEDs and mechanical
>>>> buttons.  In particular, the mechanical button support is used in
>>>> an increasing number of touchpads.
>>>>
>>> I was reading the spec for F30 and it looks to me that instead instead of basic
>>> keymap it should actually implement a gpio chip plus LED devices (probably
>>> later). Then, if GPIOs are indeed attached to buttons one can use standard
>>> gpio_keys driver to create input device.
>> The most common use of F30 is handling input from the tact switch on
>> clickpads. Since the tact switch is wired up to the touch
>> controller, it's the touch controller that handles the GPIO. The
>> touch controller then asserts attention to the host, which then
>> issues reads to see what interrupted, and then reads the F30 data
>> register to get the state of the GPIO. Would gpio chip work with
>> this setup? After looking at gpio chip a little bit I'm not really
>> seeing how that would work. It looks like to work with gpio_keys
>> each button would need it's own irq? I couldn't find an example of a
>> driver doing something similar, but if there is one could you point
>> me to it?
>>
>> For touchpad buttons we know based on convention which GPIOs
>> represent which buttons. In the case of touchpads we can avoid
>> creating a button map in the platform data. For touchpads we also
>> want to report the input events for F30 from the same input device
>> which is reporting finger data. Benjamin's patchset contains a patch
>> which allows for a unified input device which will allow more then
>> one function to use the same input device.
>>
>> The F30 spec is fairly generic so it could be used for things
>> besides the touchpad buttons and we might want to report events
>> independently of finger position. However, besides touchpad LEDs I'm
>> not sure F30 has ever been used for other applications in production
>> so I'm not sure its worth implementing something more generic at
>> this time.
> OK, fair enough. I'll have to take another look then - the details are
> quite hazy ;)
>
>>> Thanks.
>>>
>> Also, the fact that it took me over a year to reply to these
>> comments highlights that we at Synaptics have been inconsistent in
>> our effort to get the synaptics-rmi4 driver upstreamed. I think it's
>> about time we have a single upstreamed driver which can support all
>> of our RMI devices so I'm willing do more on behalf of Synaptics to
>> help get it upstreamed.
>>
>> Thanks,
>> Andrew
> Thanks.
>

