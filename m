From: Chris J Arges <chris.j.arges-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: add quirk for SB arena headset v2
Date: Wed, 21 Nov 2012 09:29:35 -0600
Message-ID: <50ACF35F.2090206@canonical.com>
References: <1352145945-8035-1-git-send-email-chris.j.arges@canonical.com> <alpine.LNX.2.00.1211052117210.24253@pobox.suse.cz> <50983069.5080404@canonical.com> <alpine.LNX.2.00.1211061214030.24253@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1211061214030.24253-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 11/06/2012 05:14 AM, Jiri Kosina wrote:
> On Mon, 5 Nov 2012, Chris J Arges wrote:
> 
>>>> When an SB Arena USB headset is plugged in, it registers the volume
>>>> keys on the headset as a keyboard and continually sends events causing
>>>> issues with normal keyboard input. This quirk disables the volume keys.
>>>
>>> I don't know how the device looks like, but wouldn't it make more sense to 
>>> actually remap the bogus keys it's sending to produce KEY_VOLUMEUP and 
>>> KEY_VOLUMEDOWN?
>>>
>>
>> Yes, if I can track this hardware down or get data I'll fix it like
>> this. This happened to be a do-no harm fix for the following bug:
>> https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/1007575
> 
> You should be able to obtain it easily either by running evtest on 
> corresponding /dev/input/eventX node, or by looking into debugfs 
> hid/<device>/events file.
> 

Hi,
I've been able to track down this particular headset and have been
trying to fix it so that it doesn't interfere with normal clicking.
I've setup a script to remove and reinsert the usbhid module and then
run evtest on that event and found the following:

Event: time 1353511306.254194, type 4 (EV_MSC), code 4 (MSC_SCAN), value
c00e9
Event: time 1353511306.254199, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP),
value 1
Event: time 1353511306.254227, type 4 (EV_MSC), code 4 (MSC_SCAN), value
ff010002
Event: time 1353511306.254229, type 1 (EV_KEY), code 259 (BTN_3), value 1
Event: time 1353511306.254241, -------------- SYN_REPORT ------------
Event: time 1353511306.414246, type 4 (EV_MSC), code 4 (MSC_SCAN), value
c00e9
Event: time 1353511306.414250, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP),
value 0
Event: time 1353511306.414283, -------------- SYN_REPORT ------------


Whenever the EV_KEY event BTN_3 code occurs, then I can no longer click
on various items. I'm assuming the input system thinks that a 3rd mouse
button is down and never released.

Where would be the proper place to quirk this particular headset? The
goal would be to still have the EV_MSC/EV_KEY events for proper codes
such as KEY_VOLUMEUP and KEY_VOLUMEDOWN, but ignore BTN_3 events since
the headset device only has two buttons for adjusting volume.

I have actually seen a few other bug reports of other devices that have
this quirk so I think this might affect more than one device; however at
this point I only have one that I can verify myself.

Thanks,
--chris j arges

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
