From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: /dev/input/by-path/<link> unreliable with MultiTouch device
Date: Thu, 28 Jun 2012 23:38:08 +0200
Message-ID: <CAN+gG=H7BoESxasjFz-B4Rj9aQdQ2ZtQHROwxzFz6xW6me5V9g@mail.gmail.com>
References: <73A57920-C505-48DF-A1F2-393BF18585DC@kayser.net>
	<CAN+gG=F8eH-p3S3gH=_8+UZf63LcoyEU_9xu+hFcfsQwmqbWwg@mail.gmail.com>
	<2DE32D19-969D-44F6-BE9F-83CD2447D8E5@kayser.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36494 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab2F1ViJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 17:38:09 -0400
Received: by ghrr11 with SMTP id r11so2270037ghr.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jun 2012 14:38:08 -0700 (PDT)
In-Reply-To: <2DE32D19-969D-44F6-BE9F-83CD2447D8E5@kayser.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Donald Kayser <linux@kayser.net>
Cc: linux-input@vger.kernel.org

Hi Donald,

On Thu, Jun 28, 2012 at 10:34 PM, Donald Kayser <linux@kayser.net> wrot=
e:
> Hi Benjamin,
>
>
>> So:
>> 1) between 2.6.34 and 2.6.39, Mosart devices are handled in
>> hid-mosart, and since 3.0 through hid-multitouch. Using these driver=
s
>> will allow you to have a better support of your devices.
>> However I'm not 100% sure it won't create more than one input device
>> if your hardware declares more than one interface.
>>
>> 2) Using the quirk HID_QUIRK_MULTI_INPUT is the exact opposite of wh=
at
>> you want to do -> it creates several inputs when it sees several
>> touches -> you then have a lot of inputs with unusable stuff.
>>
> I have returned to this problem today. I've turned off the QUIRK and =
added
> the hid_mosart driver. These devices are new so I added their ID's so=
 the
> mosart driver would recognize them. I end up with the same results I =
had

You also have to add your device in the blacklist in hid-core.c.
Earlier kernels (< 3.2) do not detect multitouch devices and handle it
through the hid-generic layer no matter you assign them to another
driver.
This blacklist is called hid_have_special_driver in earlier kernels (>
2.6.38) and hid_blacklist in earlier kernels (<=3D 2.6.37).

> before ever trying the QUIRK: the event codes from the device are not=
 ABS_X
> and ABS_Y, but ABS_HAT2X and ABS_HAT2Y. =A0These ABS_HAT2? events mak=
e it
> through the system device files and I can read them using the linux i=
nput
> API. The problem is that the xorg evdev driver does not process the
> ABS_HAT2? events. The QUIRK made the events change to ABS_X and ABS_Y=
=2E The
> usbhid driver and hid_mosart driver end up giving the same results wi=
th
> respect to the data being reported via linux input API.

Yep, that's because you are not using the hid-mosart driver. When
using it, you should see in evtest the events ABS_MT_POSITION_X (and
Y) and MT_SYNC IIRC. The good point for you is that the mouse
emulation should work, and you can ignore those mt-events.

Cheers,
Benjamin

>
>>
>> - patch your kernel (> 2.6.35) using the patches here:
>>
>> http://www.lii-enac.fr/en/architecture/linux-input/multitouch-howto.=
html#get
>> (but I did not tested old kernel releases) -> you will get the same
>> input layer for multitouch than a 3.4 kernel (the older the kernel i=
s,
>> the more intrusive it is).
>
>
> I am reluctant to patch the kernel we end up qualifying for our syste=
ms. It
> is an unknown for me trying to deliver a product soon.
>
>
>> - work on an udev rule that detect the physical path, and creates a
>> symlink /dev/input/mosart-X
>
>
> This is helpful and made it where I could get the QUIRK solution work=
ing
> okay. Without the QUIRK there isn't an entry problem in the
> /dev/input/by-path directory.
>
>
>> - rely on xorg input rules system to detect your devices (though I
>> don't know when they added the physical path in the configuration
>> options).
>
>
>
>
> I have been attempting to get the driver layer to send up ABS_X and A=
BS_Y so
> that evdev would work. I mod'd evdev to process the new events but it=
 got
> screwy. I prefer to get the system to send up events that evdev will =
handle
> and I won't have to modify it further. I don't need any kind of multi=
-touch
> capability until the next major revision of our application software,=
 so I
> am taking the shortest path to get there.
>
> Thanks,
> Donald
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
