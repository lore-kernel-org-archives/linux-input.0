From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Missing axis on Gembird JPD-DUALFORCE2 since Linux 3.18
Date: Mon, 10 Aug 2015 10:27:30 -0400
Message-ID: <CAN+gG=EmtKjR2bw1c=LedYv24PPaPVijW-HqsyxA0mF6F4+FrQ@mail.gmail.com>
References: <20150810082642.3a0880ab@orivej.orivej.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35115 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbbHJO1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 10:27:32 -0400
Received: by wicne3 with SMTP id ne3so24425883wic.0
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2015 07:27:30 -0700 (PDT)
In-Reply-To: <20150810082642.3a0880ab@orivej.orivej.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Orivej Desh <orivej@gmx.fr>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On Mon, Aug 10, 2015 at 4:26 AM, Orivej Desh <orivej@gmx.fr> wrote:
> I have one of those gamepads, and since Linux 3.18 the kernel hides o=
ne
> of its axes.
>
> In Linux 3.17 jstest reports it as
>
>      Joystick (PC Game Controller       ) has 7 axes (X, Y, Z, Rx, Rz=
, Hat0X, Hat0Y)
>
> and in Linux 3.18 as
>
>      Joystick (PC Game Controller       ) has 6 axes (X, Y, Z, Rz, Ha=
t0X, Hat0Y)
>
> It has 6 physical axes (X, Y, Rx, Ry, Hat0X, Hat0Y), but Ry is report=
ed
> as Rz, and Z emits noise (which had to be silenced with jscal).
>
> I bisected disappearing axis to the following commit [1], but if I
> understand correctly, it is the device that is wrong by misreporting
> some property of Rx.

Thanks for the bisect. Could you please run a hid-recorder from
http://bentiss.github.io/hid-replay-docs/ and record a few events from
your joypad? Depending on the output, we will be able to tell you
where this should be fixed (but I strongly suspect that the kernel
should be fixed).

Cheers,
Benjamin

>
> I can remap Rz to Ry in userspace with ioctl(fd, JSIOCSAXMAP, ...),
> though I never had to.  Can I likewise restore Rx in userspace (and a=
lso
> delete Z)?  If not, or if this device justifies a quirk, how should i=
t
> be added?
>
> usb-devices report: [2].
>
> [1]
> commit 79346d620e9de87912de73337f6df8b7f9a46888
> Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date:   Mon Aug 25 13:07:10 2014 -0400
>
>     HID: input: force generic axis to be mapped to their user space a=
xis
>
>     Atmel 840B digitizer presents a stylus interface which reports tw=
ice
>     the X coordinate and then twice the Y coordinate. In its current
>     implementation, hid-input assign the first X to X, then the secon=
d to Y,
>     then the first Y to Z, then the second one to RX.
>
>     This is wrong, and X should always be mapped to X, no matter what=
=2E
>     A solution consists in forcing X, Y, Z, RX, RY, RZ to be mapped t=
o their
>     correct user space counter part.
>
>     Reported-by: =C3=89ric Brunet <Eric.Brunet@lps.ens.fr>
>     Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..2df7fdd 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -599,6 +599,12 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
>                 /* These usage IDs map directly to the usage codes. *=
/
>                 case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
>                 case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
> +                       if (field->flags & HID_MAIN_ITEM_RELATIVE)
> +                               map_rel(usage->hid & 0xf);
> +                       else
> +                               map_abs_clear(usage->hid & 0xf);
> +                       break;
> +
>                 case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHE=
EL:
>                         if (field->flags & HID_MAIN_ITEM_RELATIVE)
>                                 map_rel(usage->hid & 0xf);
>
> [2]
> T:  Bus=3D09 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D1=
=2E5 MxCh=3D 0
> D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D=
  1
> P:  Vendor=3D11ff ProdID=3D3331 Rev=3D01.07
> S:  Product=3DPC Game Controller
> C:  #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D03(HID  ) Sub=3D00 Prot=3D00 Dr=
iver=3Dusbhid
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
