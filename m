From: Juanito <juanitobananas@posteo.net>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Fri, 8 Sep 2017 07:00:34 +0200
Message-ID: <30e888e8-39a8-6d74-7610-e467ed96815e@posteo.net>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <20170907213123.GA19320@dtor-ws> <201709072354.02681@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:46808 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbdIHFAj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Sep 2017 01:00:39 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 3115920C82
        for <linux-input@vger.kernel.org>; Fri,  8 Sep 2017 07:00:36 +0200 (CEST)
In-Reply-To: <201709072354.02681@pali>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Juanito <juam+kernel@posteo.net>, linux-input@vger.kernel.org, "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>, Paul Donohue <linux-kernel@paulsd.com>

Hi,

Thanks for that!
> 
> ThinkPad with ALPS? Should not be it Synaptic? Maybe miss-detection?
> 

Sorry, I forgot to mention this. The ThinkPad came with a clickpad I
**really** disliked, so I bought this on the Internet.

> Anyway, for ALPS devices, buttons below touchpad area are reported from 
> touchpad device and buttons above touchpad are reported from the 
> trackstick device.
> 
> ALPS DualPoint means device with touchpad + trackpoint
> 
> ALPS GlidePoint means device with only touchpad (without trackpoint)
> 
> So error message "Rejected trackstick packet from non DualPoint device" 
> which is generated at time when you click at buttons, would mean that 
> those buttons are reported via trackstick. And if kernel detected that 
> ALPS device as GlidePoint, then events from trackpoint (so also buttons) 
> are dropped.
> 

Is the trackpoint the red thingie between G, H and B?

>>> I have noticed that the touchpad gets assigned different names on
>>> both distros. On debian it is recognized as a GlidePoint and on
>>> Ubuntu as a DualPoint. In an upstream kernel 4.13 which I just
>>> built, it's also recognized as a GlidePoint. Unfortunately it
>>> doesn't work either.
> 
> Name is assigned based on detection if trackstick is present. Different 
> kernel versions is probably reasons, maybe one version has wrong 
> detection.
> 
> Is trackstick movement working? This is probably important to know as it 
> looks like buttons are reported via trackstick, not via touchpad.
> 

If by trackstick you mean the red thingie, it is **not** working.

>>> I am not sure if the device is actually a DualPoint or not (I don't
>>> really understand the terminology here), but the thing is that the
>>> buttons work when the kernel believes it to be one.
>>>
>>> This is the info I have managed to find about the device while
>>> running on the non-working debian:
>>>
>>> dmesg:
>>> [    2.914806] input: AlpsPS/2 ALPS GlidePoint as
>>> /devices/platform/i8042/serio1/input/input2
>>>
>>> lsinput:
>>> /dev/input/event11
>>>
>>>    bustype : BUS_I8042
>>>    vendor  : 0x2
>>>    product : 0x8
>>>    version : 1792
>>>    name    : "AlpsPS/2 ALPS GlidePoint"
>>>    phys    : "isa0060/serio1/input0"
>>>    bits ev : (null) (null) (null)
>>>
>>> I have played around with the drivers/input/mouse/alps.c file and
>>> found out the following:
>>>
>>> e7 and ec are important (although I don't know what these are
>>> exactly) and have the following values:
>>>
>>> e7: 73 03 0a
>>> ec: 88 b0 13
> 
> Masaki should know exact type of device...
> 
>>> This combination is recognized as an ALPS touchpad, but isn't
>>> assigned the ALPS_DUALPOINT flag. As far as I can see, it is
>>> actually being *removed* at this point:
>>>
>>> if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
>>>
>>>             priv->flags &= ~ALPS_DUALPOINT;
>>>
>>> The bit that says it has a trackpoint (I don't know what this is)
>>> is apparently saying my device doesn't have one and is removing
>>> the ALPS_DUALPOINT flag.
> 
> At least for V3 protocol that function tells touchpad to enable pass-
> thru mode to trackstick and detect if trackstick is there present. After 
> that leave pass-thru mode.
> 
>>> This flag makes the buttons work. I am not sure if it breaks other
>>> stuff.
> 
> Is that picture of your laptop, do you really have trackstick working?
> 

The picture is not from my laptop, but it might as well just be: mine
looks exactly the same. Actually it is from a blog which I read which
inspired be to change my touchpad:

https://www.camerongray.me/2015/02/fitting-physical-trackpoint-buttons-to-a-lenovo-thinkpad-t440s/

For the record, I don't have a T440 but an S440, should this be relevant.

> My idea is that alps_probe_trackstick_v3_v7 does not check presence of 
> trackstick correct and return information that trackstick is not present 
> (which contains also those buttons)...
> 
> Masaki, can you confirm if there can be problem with that function?
> 
>>> I have written a pretty dummy patch which actually adds the flag
>>> again making the buttons work. Again, I am not sure if it breaks
>>> other stuff but my system isn't whining. Here is the patch:
>>>
>>> diff --git a/drivers/input/mouse/alps.c
>>> b/drivers/input/mouse/alps.c index 850b00e3ad8e..17aba42e846f
>>> 100644
>>> --- a/drivers/input/mouse/alps.c
>>> +++ b/drivers/input/mouse/alps.c
>>> @@ -2804,6 +2804,9 @@ static int alps_set_protocol(struct psmouse
>>> *psmouse,
>>>
>>>                 if (alps_probe_trackstick_v3_v7(psmouse,
>>>
>>> ALPS_REG_BASE_V7) < 0)
>>>
>>>                         priv->flags &= ~ALPS_DUALPOINT;
>>>
>>> +               if (priv->fw_ver[1] == 0xb0)
>>> +                       priv->flags |= ALPS_DUALPOINT;
>>> +
>>>
>>>                 break;
>>>         
>>>         case ALPS_PROTO_V8:
>>> After applying this patch dmesg and lsinput say this:
>>>
>>> [    8.226543] input: AlpsPS/2 ALPS DualPoint Stick as
>>> /devices/platform/i8042/serio1/input/input13
>>> [    8.247595] input: AlpsPS/2 ALPS DualPoint TouchPad as
>>> /devices/platform/i8042/serio1/input/input2
>>>
>>> /dev/input/event11
>>>
>>>    bustype : BUS_I8042
>>>    vendor  : 0x2
>>>    product : 0x8
>>>    version : 1792
>>>    name    : "AlpsPS/2 ALPS DualPoint Stick"
>>>    phys    : "isa0060/serio1/input1"
>>>    bits ev : (null) (null) (null)
>>>
>>> /dev/input/event12
>>>
>>>    bustype : BUS_I8042
>>>    vendor  : 0x2
>>>    product : 0x8
>>>    version : 1792
>>>    name    : "AlpsPS/2 ALPS DualPoint TouchPad"
>>>    phys    : "isa0060/serio1/input0"
>>>    bits ev : (null) (null) (null)
>>>
