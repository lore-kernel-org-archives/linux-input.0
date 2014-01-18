From: Omar Loggiodice <ologgio@yahoo.com>
Subject: New ALPS not detected EC=88 b6 06 - Lenovo Ideapad Flex 15D
Date: Fri, 17 Jan 2014 16:06:50 -0800 (PST)
Message-ID: <1390003610.16861.YahooMailNeo@web162404.mail.bf1.yahoo.com>
Reply-To: Omar Loggiodice <ologgio@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm9-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.154]:40216 "EHLO
	nm9-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750937AbaARAMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 19:12:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,


=A0=A0 First, thank you for your excellent work. I recently bought a ne=
w Lenovo Ideapad Flex 15D, it comes with Windows 8.1.

I have been able to run linux, however the ALPS touchpad is only recogn=
ized as a PS/2 mouse. I also have some problems with the screen=20
turning off and the GPU stalling, but this is outside of the scope of=20
this list.=A0 This is what dmesg shows for the touchpad:

psmouse serio1: alps: Unknown ALPS touchpad: E7=3D73 03 0a, EC=3D88 b6 =
06

I hacked alps.c with the following code in alps_identify(...):

[...]

} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0xb6 &&
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ec[2] =3D=3D 0x0=
6 )
 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 priv->proto_version =3D A=
LPS_PROTO_V5;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 alps_set_defaults(priv);=20

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
=A0=A0=A0=A0=A0=A0=A0 }
[...]

With this code the module seems to recognize the card and dmesg reports=
 the following:

[=A0 791.663876] input: PS/2 Mouse as /devices/platform/i8042/serio1/in=
put/input22
[=A0 791.692023] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i=
8042/serio1/input/input21


However, the touchpad still operates only as a PS/2 mouse (no scroll, n=
o middle=20
button emulation, no touch gestures) even if I disable the PS/2 mouse=20
with xinput.

any help would be appreciated, I am willing to test patches if you send=
 them to me.

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
