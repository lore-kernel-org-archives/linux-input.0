From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Mon, 19 Sep 2011 16:40:46 -0700
Message-ID: <4E77D2FE.8060709@gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com> <20110913080911.GA4986@polaris.bitmath.org> <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com> <20110914071524.GA3422@polaris.bitmath.org> <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com> <20110916105036.GA4455@polaris.bitmath.org> <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com> <20110917112114.GA3015@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34881 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab1ISXkw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 19:40:52 -0400
Received: by yie30 with SMTP id 30so4504341yie.19
        for <linux-input@vger.kernel.org>; Mon, 19 Sep 2011 16:40:52 -0700 (PDT)
In-Reply-To: <20110917112114.GA3015@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On 09/17/2011 04:21 AM, Henrik Rydberg wrote:
> Hi Jason,
> 
>>>> Take Wacom's Intuos and Graphire series for example, those tablets
>>>> support both styli and mice. For styli, the default is absolute mode;
>>>> while for mice, it is relative. So, only valid property the tablet can
>>>> tell the user-land is: I am a tablet, i.e., not a touchscreen. Clients
>>>> have to check the tool types to set the default mode to relative
>>>> (BTN_TOOL_MOUSE/LENS) or absolute (BTN_TOOL_PEN/AIRBRUSH/RUBBER...).
>>>
>>> And those modes can be determined using the available axes. However,
>>> when all axes are the same, a statement like "I am a tablet" does not
>>> exist. In that case, distinguishing between touchscreen, touchpad and
>>> tablet becomes a question of interpreting the properties. Such a
>>> distinction cannot be achieved using a single bit of information, and
>>> that was never the intention.
>>>
>> It is certainly true that you cannot separate out the different cases
>> with a single bit. The more properties and hints we can expose to
>> userspace the better. However, at the device level, there's only so
>> much information we *can* expose. We know if its a direct input device
>> or not. We don't know if its relative or absolute, since that depends
>> on the tool in use at any given moment.
> 
> It seems the various arguments we have seen in this thread are all
> logical and well founded, but they originate in different assumptions
> about the semantics of POINTER and DIRECT. Such a debate does
> obviously not satisfy everyone.
> 
> The original intention of the properties are these:
> 
> POINTER - The device needs a visual guide in order to be useful. In
> most cirumstances, this is equivalent to not having a screen directly
> beneath the surface.
> 
> DIRECT - The input device is to be used as if it was overlaying a
> sreen. It could be separate from the screen, but the expected behavior
> should be the same.
> 
> From these definitions, it follows that a device could well be both
> POINTER and DIRECT. For instance, a multitouch tablet designed to
> replace the keyboard would fall into this category.

I think these are the clearest definitions I've seen of these
properties. It would be good to get them documented in
Documentation/input. Henrik, would you be able to do this?

-- Chase
