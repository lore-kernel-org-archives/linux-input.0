From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC v2] input: Introduce device information ioctl
Date: Thu, 16 Dec 2010 08:43:02 +0100
Message-ID: <4D09C306.4050207@euromail.se>
References: <1292440807-18502-1-git-send-email-rydberg@euromail.se> <4D09302C.4000309@canonical.com> <201012151352.23229.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201012151352.23229.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>>> As an example of how this would work for the

>>> touchpad/tablet/touchscreen triplet, there are two properties defined,
>>> INPUT_PROP_POINTER and INPUT_PROP_DIRECT. A touchpad is an indirect
>>> pointer device, a tablet is a direct pointer device, and the
>>> touchscreen is simply a direct device.
>>>
>>> What do you think?
>>
>> I must have missed the first version of this patch, but I give two
>> thumbs way up :). The detection code for touchpad/tablet/touchscreen in
>> xf86-input-evdev is large and unwieldy, and seemingly simple changes to
>> an input driver can cause incorrect interpretation. Having this
>> available should help quite a bit!
>>
>> Acked-by: Chase Douglas <chase.douglas@canonical.com>
> 
> As long as we document that !pointer && !direct means "unknown" or
> "unspecified" so as to avoid having to update all devices at once that
> should be OK.
> 
> We also need to wire up uinput.


Great, will cook a proper patch.

Thanks,
Henrik
