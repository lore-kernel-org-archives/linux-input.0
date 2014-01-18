From: Omar Loggiodice <ologgio@yahoo.com>
Subject: Re: New ALPS not detected EC=88 b6 06 - Lenovo Ideapad Flex 15D
Date: Fri, 17 Jan 2014 21:18:12 -0800 (PST)
Message-ID: <1390022292.30501.YahooMailNeo@web162402.mail.bf1.yahoo.com>
References: <1390003610.16861.YahooMailNeo@web162404.mail.bf1.yahoo.com> <CA+F6ckMtidbKYONs=cFLvhqePwWhg14UDRCxVZ+8eTa_8P2hAA@mail.gmail.com>
Reply-To: Omar Loggiodice <ologgio@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm11-vm1.bullet.mail.bf1.yahoo.com ([98.139.213.152]:48949 "EHLO
	nm11-vm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbaARFSN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jan 2014 00:18:13 -0500
In-Reply-To: <CA+F6ckMtidbKYONs=cFLvhqePwWhg14UDRCxVZ+8eTa_8P2hAA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Elaine Chen <elaineee66@gmail.com>, Qiting Chen <qiting.chen@cn.alps.com>

The patch works very well! I now need to adjust the settings. I wanted =
to let you know=A0 two=20
finger middle button works, along with two finger scrolling, circular=20
scrolling, edge scrolling, right button, etc. Everything is working.=20


Thank you all for the good work you do for the linux community.





On Friday, January 17, 2014 9:49 PM, Tommy Will <tommywill2011@gmail.co=
m> wrote:
Hi Omar,

Thanks for your mail. This is Tommy from ALPS.
According to your info "E7=3D73 03 0a, EC=3D88 b6 06", I think you're n=
ow
using ALPS_PROTO_V7 device.
My colleague Elaine(Qiting) is now working with this touchpad's
support and has released a patch last week.
You can have a try ~

=A0 =A0 http://www.spinics.net/lists/linux-input/msg29084.html

If you find any issue or have any suggestion, please kindly let us
know. We'll try our best to make the driver better.

Thanks!

--=20
Best Regards,
Tommy


2014/1/18 Omar Loggiodice <ologgio@yahoo.com>:
> Hi,
>
>
>=A0 =A0 First, thank you for your excellent work. I recently bought a =
new Lenovo Ideapad Flex 15D, it comes with Windows 8.1.
>
> I have been able to run linux, however the ALPS touchpad is only reco=
gnized as a PS/2 mouse. I also have some problems with the screen
> turning off and the GPU stalling, but this is outside of the scope of
> this list.=A0 This is what dmesg shows for the touchpad:
>
> psmouse serio1: alps: Unknown ALPS touchpad: E7=3D73 03 0a, EC=3D88 b=
6 06
>
> I hacked alps.c with the following code in alps_identify(...):
>
> [...]
>
> } else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0xb6 &&
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ec[2] =3D=3D 0x06 )
>=A0 {
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  priv->proto_version =3D ALPS_PROTO_V5=
;
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  alps_set_defaults(priv);
>
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  return 0;
>=A0 =A0 =A0 =A0  }
> [...]
>
> With this code the module seems to recognize the card and dmesg repor=
ts the following:
>
> [=A0 791.663876] input: PS/2 Mouse as /devices/platform/i8042/serio1/=
input/input22
> [=A0 791.692023] input: AlpsPS/2 ALPS GlidePoint as /devices/platform=
/i8042/serio1/input/input21
>
>
> However, the touchpad still operates only as a PS/2 mouse (no scroll,=
 no middle
> button emulation, no touch gestures) even if I disable the PS/2 mouse
> with xinput.
>
> any help would be appreciated, I am willing to test patches if you se=
nd them to me.
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
