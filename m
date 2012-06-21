From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: /dev/input/by-path/<link> unreliable with MultiTouch device
Date: Thu, 21 Jun 2012 22:31:04 +0200
Message-ID: <CAN+gG=F8eH-p3S3gH=_8+UZf63LcoyEU_9xu+hFcfsQwmqbWwg@mail.gmail.com>
References: <73A57920-C505-48DF-A1F2-393BF18585DC@kayser.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36772 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760200Ab2FUUbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 16:31:06 -0400
Received: by gglu4 with SMTP id u4so926125ggl.19
        for <linux-input@vger.kernel.org>; Thu, 21 Jun 2012 13:31:05 -0700 (PDT)
In-Reply-To: <73A57920-C505-48DF-A1F2-393BF18585DC@kayser.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Donald Kayser <linux@kayser.net>
Cc: linux-input@vger.kernel.org

Hello Donald,

I think that you are encountering at least 3 problems:
1) your devices are not correctly handled by the kernel
2) solving the handling of multitouch devices by adding the quirk
HID_QUIRK_MULTI_INPUT is __really__ a bad idea in your case
3) you seem to use very old kernels.

So:
1) between 2.6.34 and 2.6.39, Mosart devices are handled in
hid-mosart, and since 3.0 through hid-multitouch. Using these drivers
will allow you to have a better support of your devices.
However I'm not 100% sure it won't create more than one input device
if your hardware declares more than one interface.

2) Using the quirk HID_QUIRK_MULTI_INPUT is the exact opposite of what
you want to do -> it creates several inputs when it sees several
touches -> you then have a lot of inputs with unusable stuff.

3) By using a kernel >=3D3.4 and by modprobing hid-multitouch, your
mosart devices will be correctly handled by the kernel.

However, if you can not update your kernel here are some ideas:
- use the right module for your devices (hid-mosart or hid-multitouch)
- patch your kernel (> 2.6.35) using the patches here:
http://www.lii-enac.fr/en/architecture/linux-input/multitouch-howto.htm=
l#get
(but I did not tested old kernel releases) -> you will get the same
input layer for multitouch than a 3.4 kernel (the older the kernel is,
the more intrusive it is).
- work on an udev rule that detect the physical path, and creates a
symlink /dev/input/mosart-X
- rely on xorg input rules system to detect your devices (though I
don't know when they added the physical path in the configuration
options).

Cheers,
Benjamin



On Thu, Jun 21, 2012 at 4:52 PM, Donald Kayser <linux@kayser.net> wrote=
:
> Hello All,
>
> I am part of development of a product that uses touchscreens extensiv=
ely. We
> have to maintain touchscreen calibration and X Display association ac=
ross
> boots. We support up to six screens, 3 internal to our product, 3 ext=
ernal
> to our product. All internal screens have touchscreens with cables th=
at
> don't move, so using the device /dev/input/by-path/<devicelink> I cou=
ld
> modify xorg.conf with an InputSection and associate the screen and
> touchscreen, include calibration, and every time the user returned, i=
t was
> already calibrated and working correctly. It has worked great until w=
e
> started adding multi-touch devices. The line of multi-touch devices w=
e are
> using is manufactured my MosArt.
>
> I added the defines for the products in my local kernel tree's
> driver/hid/hid-ids.h and added the quirk for HID_QUIRK_MULTI_INPUT in
> hid-quirks.c. With the kernel 2.6.39.4 and earlier to 2.6.32.n, there=
 is
> confusion with the /dev/input/by-path/<devlink>. =A0These multi-touch=
 devices
> show up with four entries in /dev/input/<dev>. From looking at the ou=
tput of
> lsinput, two of the entries have identical information with regards t=
o event
> bits. Only one of these identical entries in /dev/input/<dev> actuall=
y work;
> one reports 13 axis, one reports 3 axis. When the
> /dev/input/by-path/<devlink> points to the 'working' /dev/input/<dev>=
 all is
> fine. This only happens 50% of the time and with three screens it is =
not
> likely to get all three right on any boot.
>
> So, is this a good place to ask this question? What other information=
 would
> be beneficial? I purposely left out a bunch of debug info so not to g=
et too
> noisy.
>
> Thanks in advance,
> Donald Kayser
> linux at kayser dot net
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
