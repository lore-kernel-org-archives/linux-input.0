From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Wed, 13 Jan 2016 17:20:57 +0000
Message-ID: <56968779.5060302@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
 <5672EF68.3000800@itdev.co.uk> <20160111232413.GA39766@dtor-ws>
 <20160112081041.GB19287@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:53713 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcAMRVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 12:21:13 -0500
In-Reply-To: <20160112081041.GB19287@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>

Hi Ben/Dmitry-

On 12/01/16 08:10, Benjamin Tissoires wrote:
> On Jan 11 2016 or thereabouts, Dmitry Torokhov wrote:
>> On Thu, Dec 17, 2015 at 05:22:48PM +0000, Nick Dyer wrote:
>>>> This is a series of patches to add diagnostic data support to the Atmel
>>>> maXTouch driver. There's an existing implementation in the open-source mxt-app
>>>> tool, however there are performance advantages to moving this code into the driver.
>>>> The algorithm for retrieving the data has been fairly consistent across a range of
>>>> chips, with the exception of the mXT1386 series (see patch).
>>>>
>>>> The intention is to open-source a utility which can read/display this data, this
>>>> should be available very shortly.
>>>
>>> The utility to read this data has now been released, and you can find it at:
>>> https://github.com/ndyer/heatmap
>>>
>>> I've recorded a couple of videos of the utility in action on a Pixel 2:
>>> * https://youtu.be/M0VD2gZt8Zk
>>> * https://youtu.be/nwDLB4zikzU
>>
>> Thank you for sharing the utility and the recording, but it seems that
>> there is a desire to get access to the heat maps not only for
>> validation, but also for certain processing purposes, and so I do not
>> think that we should try to standardize on debugfs as the interface, but
>> rather look for something that allows better performance.
>>
>> I wonder if the interface should look similar to the V4L2 capture API
>> where application opens a character device, uses several ioctls to query
>> its capabilities/set up capture parameters (i.e reference or deltas),
>> select()s file descriptor for reading and then uses mmap() to access the
>> captured heat map.
>>
>> I've CCed a few people who might be interested in this topic.
> 
> I've added Florian, who worked on the driver for the Surface 2.0 which
> does exactly that, exports the heat map through V4L2.
> 
> See drivers/input/touchscreen/sur40.c for his driver.

That's very interesting, thanks. I do think there is a difference in intent
between the debugfs interface we are proposing and the video interface.

The devices we want to support are I2C based and the frame rate is low:
typically less than 10 fps with 1386 nodes, as an example. So performance
is not critical and doing meaningful processing is not really feasible.

The use cases we want to support are diagnostic, for instance tuning and
analysing touch sensor manufacturing defects. It's useful in this context
to be able to interrogate the device using the command line or shell scripts.

Nick
