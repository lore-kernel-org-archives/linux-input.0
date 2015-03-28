From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Fri, 27 Mar 2015 20:43:35 -0700
Message-ID: <20150328034335.GA9145@dtor-ws>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
 <201503272108.57759@pali>
 <CAPXTYCVGpm27naqu723f8kC0h75TT6XSN0X_EWCu6cXJS0G2kg@mail.gmail.com>
 <201503272154.04582@pali>
 <CAPXTYCUqibXqTBf8VKGKixKeM49LhucxFDhS+04fUsiSEKMKOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33644 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbC1Dnj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 23:43:39 -0400
Content-Disposition: inline
In-Reply-To: <CAPXTYCUqibXqTBf8VKGKixKeM49LhucxFDhS+04fUsiSEKMKOg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Mar 28, 2015 at 01:30:58AM +0000, Santiago Gala wrote:
> The behaviour is the same with 3.19.1 as with 4.0.0-rc5 + the patched
> psmouse you give me. The difference in lsinput is just name and curre=
nt
> position:
>=20
> $ diff -u alps06.txt alps11-new.txt
> --- alps06.txt  2015-03-18 07:21:08.827315595 +0100
> +++ alps11-new.txt      2015-03-27 21:24:44.285503438 +0100
> @@ -1,5 +1,5 @@
>  # EVEMU 1.2
> -# Input device name: "AlpsPS/2 ALPS DualPoint TouchPad"
> +# Input device name: "AlpsPS/2 ALPS GlidePoint"
>  # Input device ID: bus 0x11 vendor 0x02 product 0x08 version 0x700
>  # Supported events:
>  #   Event type 0 (EV_SYN)
> @@ -15,14 +15,14 @@
>  #     Event code 335 (BTN_TOOL_QUADTAP)
>  #   Event type 3 (EV_ABS)
>  #     Event code 0 (ABS_X)
> -#       Value   1076
> +#       Value   1549
>  #       Min        0
>  #       Max     4095
>  #       Fuzz       0
>  #       Flat       0
>  #       Resolution 42
>  #     Event code 1 (ABS_Y)
> -#       Value    869
> +#       Value    877
>  #       Min        0
>  #       Max     2047
>  #       Fuzz       0
> @@ -59,7 +59,7 @@
>  # Properties:
>  #   Property  type 0 (INPUT_PROP_POINTER)
>  #   Property  type 2 (INPUT_PROP_BUTTONPAD)
> -N: AlpsPS/2 ALPS DualPoint TouchPad
> +N: AlpsPS/2 ALPS GlidePoint
>  I: 0011 0002 0008 0700
>  P: 05 00 00 00 00 00 00 00
>  B: 00 0b 00 00 00 00 00 00 00

Hmm, if resolution is the same I wonder if we are dropping some
packets... Is there any messages from psmouse module in dmesg?

Thanks.

>=20
>=20
> El vie., 27 de marzo de 2015 a las 21:56, Pali Roh=E1r (<pali.rohar@g=
mail.com>)
> escribi=F3:
>=20
> > On Friday 27 March 2015 21:32:12 Santiago Gala wrote:
> > > I guess the difference is more due to new limits reported.
> > >
> > > Now I get only one device:
> > >
> > > /dev/input/event11
> > >    bustype : BUS_I8042
> > >    vendor  : 0x2
> > >    product : 0x8
> > >    version : 1792
> > >    name    : "AlpsPS/2 ALPS GlidePoint"
> > >    phys    : "isa0060/serio1/input0"
> > >    bits ev : EV_SYN EV_KEY EV_ABS
> > >
> >
> > Ok, it means that trackstick detection patch detected that you do
> > not have trackstick (and you have only touchpad device).
> >
> > And also that psmouse.ko is really using ALPS driver.
> >
> > > And it produces different output in evemu-describe. I attach
> > > alps11-new.txt (the new one). See fragment of difference with
> > > relevant previous one:
> > >
> > > @@ -38,17 +38,17 @@
> > >  #     Event code 53 (ABS_MT_POSITION_X)
> > >  #       Value      0
> > >  #       Min        0
> > > -#       Max      448
> > > +#       Max     4095
> > >  #       Fuzz       0
> > >  #       Flat       0
> > > -#       Resolution 4
> > > +#       Resolution 42
> > >  #     Event code 54 (ABS_MT_POSITION_Y)
> > >  #       Value      0
> > >  #       Min        0
> > > -#       Max        0
> > > +#       Max     2047
> > >  #       Fuzz       0
> > >  #       Flat       0
> > > -#       Resolution 0
> > > +#       Resolution 38
> > >  #     Event code 57 (ABS_MT_TRACKING_ID)
> > >  #       Value      0
> > >  #       Min        0
> > >
> > > So resolutions are reported clearly different than with the
> > > broken patch.
> > >
> >
> > Can you look at difference between old 3.19 kernel version and
> > this new one? To check if there is no regression.
> >
> > > Regards
> > > Santiago
> > >
> > > El vie., 27 de marzo de 2015 a las 21:09, Pali Roh=E1r
> > > (<pali.rohar@gmail.com>)
> > >
> > > escribi=F3:
> > > > Hello,
> > > >
> > > > there should no functional changes (e.g. acceleration speed,
> > > > etc.). And if yes, there is probably some side effect which
> > > > should be investigated.
> > > >
> > > > Please can you provide output from dmesg (grep for psmouse
> > > > or input) and also output from lsinput?
> > > >
> > > > That changed acceleration/speed sounds like psmouse
> > > > fallbacks to some ImPS/2 relative protocol and not ALPS...
> > > >
> > > > On Friday 27 March 2015 20:46:59 Santiago Gala wrote:
> > > > > It works quite well! :)
> > > > >
> > > > > I got some issues: at first it didn't work after I mv'ed
> > > > > the original and put the unzipped new in its place. After
> > > > > reboot it failed exactly the same, but after I "sudo
> > > > > /etc/init.d/lightdm stop; sudo modprobe -r psmouse; sudo
> > > > > modprobe psmouse; sudo /etc/init.d/lightdm start" it
> > > > > worked. Then I remembered about the initrd.img which
> > > > > should contain it. So I did "sudo dpkg-reconfigure
> > > > > linux-image-4.0.0-040000rc5-generic", rebooted again and
> > > > > here I am.
> > > > >
> > > > >
> > > > > Things seem to work all right. The only thing I notice is
> > > > > that the old driver moved fast in console mode (with gpm)
> > > > > while the new one is rather slow, would need to tweak the
> > > > > acceleration configuration. even after adding
> > > > > "responsiveness=3D15" to the configuration, as the sample
> > > > > /etc/gpm.conf says, it is slower than the previous kernel
> > > > > with the stock configuration.
> > > > >
> > > > >
> > > > > Regards
> > > > >
> > > > > Santiago
> > > > >
> > > > >
> > > > > El vie., 27 de marzo de 2015 a las 18:17, Pali Roh=E1r
> > > > > (<pali.rohar@gmail.com>) escribi=F3:
> > > > >
> > > > > On Thursday 26 March 2015 16:33:13 you wrote:
> > > > > > El mar., 24 de marzo de 2015 a las 17:48, Pali Roh=E1r
> > > > > > (<pali.rohar@gmail.com>)
> > > > > >
> > > > > > escribi=F3:
> > > > > > > Hello, I can compile psmouse.ko module for you. Just
> > > > > > > let me know which ubuntu kernel (and from) are you
> > > > > > > using.
> > > > > >
> > > > > > This one could do:
> > > > > >
> > > > > > http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-rc5-v
> > > > > > ivid /
> > > > > >
> > > > > > or at a choice any further one (they get published as
> > > > > > they are released)
> > > > > >
> > > > > > Regards
> > > > > > Santiago
> > > > >
> > > > > Hello, in attachment is gzipped psmouse.ko module compiled
> > > > > against above ubuntu kernel from linus git tree (3c435c1e)
> > > > > with additional patches:
> > > > >
> > > > > https://lkml.org/lkml/2015/3/21/282
> > > > > https://lkml.org/lkml/2015/3/22/93
> > > > > https://lkml.org/lkml/2015/3/22/94
> > > > >
> > > > > Test it and if everything works as expected, please send
> > > > > email to all all people and ML. Thanks.
> > > > >
> > > > > --
> > > > > Pali Roh=E1r
> > > > > pali.rohar@gmail.com
> > > >
> > > > --
> > > > Pali Roh=E1r
> > > > pali.rohar@gmail.com
> >
> > --
> > Pali Roh=E1r
> > pali.rohar@gmail.com
> >

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
