From: Masaki Ota <masaki.ota@jp.alps.com>
Subject: RE: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint flag
 for 74 03 28 devices
Date: Wed, 8 Mar 2017 02:36:38 +0000
Message-ID: <KAWPR01MB1092E107491DFBAD78B2E1B6C72E0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
References: <78be095c-a7ae-328d-dd0a-b8470dfc1318@canonical.com>
 <20170304161509.GI4609@TopQuark.net>
 <CAM67p+6UpxCNd23rkajZZL7Oyk1c658BEzLOXpABA0etE-A_tA@mail.gmail.com>
 <20170305175619.GJ4609@TopQuark.net> <20170305180841.GK4609@TopQuark.net>
 <KAWPR01MB10928839D5E4608128F925B5C72C0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170307021758.GM4609@TopQuark.net>
 <KAWPR01MB1092FD2304E3F2BC7E7C6305C72F0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170307175813.GC13740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170307175813.GC13740@dtor-ws>
Content-Language: ja-JP
Sender: stable-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: Paul Donohue <linux-kernel@paulsd.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, Joseph Salisbury <joseph.salisbury@canonical.com>, "ben@smart-cactus.org" <ben@smart-cactus.org>, "mhocko@suse.com" <mhocko@suse.com>, "pali.rohar@gmail.com" <pali.rohar@gmail.com>, "rydberg@bitmath.org" <rydberg@bitmath.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi, Dmitry,

OK, I will do it.

Best Regards,
Masaki Ota
-----Original Message-----
From: dmitry.torokhov@gmail.com [mailto:dmitry.torokhov@gmail.com]=20
Sent: Wednesday, March 08, 2017 2:58 AM
To: =1B$BB@ED=1B(B =1B$B??4n=1B(B Masaki Ota <masaki.ota@jp.alps.com>
Cc: Paul Donohue <linux-kernel@paulsd.com>; Nick Fletcher <nick.m.fletcher@=
gmail.com>; Joseph Salisbury <joseph.salisbury@canonical.com>; ben@smart-ca=
ctus.org; mhocko@suse.com; pali.rohar@gmail.com; rydberg@bitmath.org; linux=
@roeck-us.net; open list:HID CORE LAYER <linux-input@vger.kernel.org>; LKML=
 <linux-kernel@vger.kernel.org>; stable@vger.kernel.org
Subject: Re: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint flag=
 for 74 03 28 devices

Hi Masaki,

On Tue, Mar 07, 2017 at 08:40:20AM +0000, Masaki Ota wrote:
> Hi, Paul,
>=20
> I have modified the source code.=20
>=20
> There are three issues.
> #1. E7=3D73 03 28 Button pad device is not assigned "ALPS_BUTTONPAD" Flag=
 correctly.
> #2. E7=3D73 03 28 devices are not assigned " ALPS_DUALPOINT" Flag correct=
ly.
> #3. E7=3D73 03 28 device cursor speed is slow.
>=20
> Actually, the cause is all the same.
> E7=3D73 03 28 device does not get correct information from OTP.
> OTP is the device information byte. I specified correct bit.
>=20
> Then, I think it is also the issue.
> #4. Stick Pointer cursor speed is fast.
>=20
> I will check Stick parameter.

Could you please submit this as a proper patch now that we have confirmatio=
n that it works? Also, I wonder if V8PLUS should be full protocol instead o=
f a flag.

Thanks.
