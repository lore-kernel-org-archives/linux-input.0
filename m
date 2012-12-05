From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: HID-sensor(-hub.c) and device IDs
Date: Wed, 05 Dec 2012 22:08:05 +0100
Message-ID: <50BFB7B5.4000403@ahsoftware.de>
References: <50BF961D.5080101@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C95FE7C@ORSMSX108.amr.corp.intel.com> <50BFAB5C.6060207@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C95FEB6@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91C95FEB6-P5GAC/sN6hk8Ug9VwtkbtrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am 05.12.2012 21:24, schrieb Pandruvada, Srinivas:
> Yes, We can have a black list instead of white list. Are you planning to submit changes?

I've just have implemented my first version of a time sensor. So yes (at 
least the time sensor).

That's why I stumbled over that. I had to add a vendor and device ID to 
those two files. I also noticed that hid-sensors(-hub) doesn't work with 
combined HID devices (e.g. mouse/keyboard/sensor) and as a first 
workaround I've just modified the HID-tree of my device. As I'm fairly 
new to the HID stuff, I'm still in the evaluation phase (reading source 
and such).

In regard to a blacklist, I don't know how to fill it. I only have the 
one sensor device I've build myself (it's a spare-time project).

I think the first step would be to identify devices usable by 
hid-sensor-hub, sensor_hub_check_for_sensor_page() looks like the way to 
go, at least for the current state of the hid-sensor-framework.

Regards,

Alexander

> Thanks,
> Srinivas
>
>
> -----Original Message-----
> From: Alexander Holler [mailto:holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org]
> Sent: Wednesday, December 05, 2012 12:15 PM
> To: Pandruvada, Srinivas
> Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: HID-sensor(-hub.c) and device IDs
>
> Am 05.12.2012 20:21, schrieb Pandruvada, Srinivas:
>> We have not tested on sensor hubs from different vendors except few. It is possible that some vendors are using sensor hub as raw devices . We can remove vendor product ids once we have a good list for support.
>
> Hmm, sorry, I don't understand that fully. Does that mean that the list is there to use the driver only with a small group of devices because otherwise some HID-sensors aren't usable as raw devices?
>
> I don't know how many HID-sensor devices are already out in the wild, but because the standard looks fairly new, I don't think there are that many. And I wonder how you want to get the list larger, if nobody notifies that they should use hid-sensor-hub.c.
>
>
> I think the correct way would be to build a blacklist instead of a whitelist.
>
> Regards,
>
> Alexander
>
>> Thanks,
>> Srinivas
>>
>> -----Original Message-----
>> From: Alexander Holler [mailto:holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org]
>> Sent: Wednesday, December 05, 2012 10:45 AM
>> To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> Pandruvada, Srinivas
>> Subject: HID-sensor(-hub.c) and device IDs
>>
>> Hello,
>>
>> is there any special reason why vendor and devices IDs for HID-sensors must be listed in drivers/hid/hid-sensor-hub.c and drivers/hid/hid-core.c?
>>
>> Maybe I'm missing something, but I don't think this is how HID is supposed to work.
>>
>> Regards,
>>
>> Alexander
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
