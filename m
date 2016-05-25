From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 14:09:57 +0200
Message-ID: <87a8jejq3u.fsf@smart-cactus.org>
References: <87eg9j6zf7.fsf@smart-cactus.org> <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM> <87bn45gr0e.fsf@smart-cactus.org> <20160517082309.GZ29844@pali> <877fet10a9.fsf@smart-cactus.org> <20160517131629.GE29844@pali> <23E0F704395E694FA4710C833FA087E50D40B8C592@TPEX7ADC101.APAC.DELL.COM> <20160517152239.GF29844@pali> <23E0F704395E694FA4710C833FA087E50D40D0723A@TPEX7ADC101.APAC.DELL.COM> <20160525073949.GY29844@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56170 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcEYMKH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 08:10:07 -0400
In-Reply-To: <20160525073949.GY29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Allen_Hung@Dell.com
Cc: Mario_Limonciello@Dell.com, linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> On Wednesday 25 May 2016 12:38:15 Allen_Hung@Dell.com wrote:
>>=20
>> I got responds from Alps and they confirmed that the Alps devices in
>> Dell systems are speaking in protocol V8. The devices that speak in
>> protocol V9 are using different ASIC hardware and they are not used
>> in Dell systems..
>>=20

Thanks Allen!

>
> Hi Allen, thank you for confirmation.
>
> Ben, V8 protocol is supported by linux kernel since version 4.1. Do you
> have needed version?

Yes, I have been running 4.5 and 4.6.

> If yes and your touchpad does not work, please compile psmouse.ko in
> debug mode and send us dmesg output. Maybe there can be something
> interesting...
>
As I mentioned earlier, the device is certainly not recognized as an
ALPS device,

     [  367.097253] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/s=
erio1/input/input21

If I `rmmod psmouse; modprobe psmouse dyndbg=3D=3Dpm` I find this,

    [  714.520655] psmouse: psmouse serio1: cypress_ps2: send extension cmd=
 0x00, [0 0 0 0]
    [  714.748482] psmouse: psmouse serio1: cypress_ps2: Command 0x00 respo=
nse data (0x): 00 00 14
    [  714.781858] psmouse: psmouse serio1: alps: E6 report: 00 00 64
    [  714.804749] psmouse: psmouse serio1: alps: E7 report: 73 03 28
    [  714.830829] psmouse: psmouse serio1: alps: EC report: 73 01 13
    [  714.833568] psmouse: psmouse serio1: alps: Likely not an ALPS touchp=
ad: E7=3D73 03 28, EC=3D73 01 13
    [  714.860923] psmouse: psmouse serio1: elantech: unexpected magic knoc=
k result 0x00, 0x02, 0x64.
    [  714.947527] psmouse: psmouse serio1: byd: BYD touchpad detected
    [  715.869113] input: ImPS/2 BYD TouchPad as /devices/platform/i8042/se=
rio1/input/input24

This seems like quite a hint.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRZYVAAoJEHPt6ejPuu8BFwgH/2uUyW3Z9wAM0LuMw/mwrfCr
GxbTAaYOmvoMCWFOTM7lJOpRtbl2/z8759pddNk4ErAeJimo7zn0zXzEnO2/PNtF
0wX+IuH/MC1LguSqUN0/aO5sV93KmkEnYR9Zo7GsmFqVliEkNfpQiQWJyxhYwfHQ
DWSDOUzRKYwQ/nTNjMnHYiwYlDKk5MaoAsa7gQS+glXYk2ftTVNo7vIiE37O6caP
ADjq3prMiJmnYmFYJN130RNe6XuQrVJGiBMPaV5Ln2xiCw5lRR9K/0Y0vA6SNas1
tvrIV0bi3Ggzqv4rGq/60dFKmAeZmhklwcs9+V4qn/mOmkno+UuctAFcy9LI/58=
=SbQq
-----END PGP SIGNATURE-----
--=-=-=--
