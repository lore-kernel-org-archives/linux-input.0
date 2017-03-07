From: Paul Donohue <linux-kernel@paulsd.com>
Subject: Re: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint flag
 for 74 03 28 devices
Date: Mon, 6 Mar 2017 21:17:58 -0500
Message-ID: <20170307021758.GM4609@TopQuark.net>
References: <78be095c-a7ae-328d-dd0a-b8470dfc1318@canonical.com>
 <20170304161509.GI4609@TopQuark.net>
 <CAM67p+6UpxCNd23rkajZZL7Oyk1c658BEzLOXpABA0etE-A_tA@mail.gmail.com>
 <20170305175619.GJ4609@TopQuark.net>
 <20170305180841.GK4609@TopQuark.net>
 <KAWPR01MB10928839D5E4608128F925B5C72C0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <KAWPR01MB10928839D5E4608128F925B5C72C0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Nick Fletcher <nick.m.fletcher@gmail.com>, Joseph Salisbury <joseph.salisbury@canonical.com>, "ben@smart-cactus.org" <ben@smart-cactus.org>, "mhocko@suse.com" <mhocko@suse.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "pali.rohar@gmail.com" <pali.rohar@gmail.com>, "rydberg@bitmath.org" <rydberg@bitmath.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Excellent!  Thanks!  Let me know if you see anything else that needs to c=
hange.

On Mon, Mar 06, 2017 at 08:45:33AM +0000, Masaki Ota wrote:
> Hi, Paul,
>=20
> I understand the current situation.
> We have three devices that have ID: E7=3D73 03 28.
>=20
> DELL: Normal Pad type (There are Left and right button below Touchpad.)
> ID: E7=3D73 03 28, EC=3D73 01 13
> ID: E7=3D73 03 28, EC=3D73 01 22
>=20
> TOSHIBA: Button Pad type
> ID: E7=3D73 03 28, EC=3D73 01 14
>=20
> I think Nick mentioned about TOSHIBA device.
> I have checked the source code and I guess EC=3D73 01 14 device does no=
t have "ALPS_BUTTONPAD" Flag, although it is the Button Pad.
> Because "alps_update_btn_info_ss4_v2()" does not support E7=3D73 03 28 =
devices.
>=20
> E7=3D73 03 14 device can use below code.
> is_btnless =3D (otp[1][1] >> 3) & 0x01;
>=20
> E7=3D73 03 28 device has to use below bit.
> is_btnless =3D (otp[1][0] >> 1) & 0x01;
>=20
> I will check other parts of source code.
>=20
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Paul Donohue [mailto:linux-kernel@paulsd.com]=20
> Sent: Monday, March 06, 2017 3:09 AM
> To: Nick Fletcher <nick.m.fletcher@gmail.com>; =E5=A4=AA=E7=94=B0 =E7=9C=
=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.com>
> Cc: Joseph Salisbury <joseph.salisbury@canonical.com>; ben@smart-cactus=
.org; mhocko@suse.com; dmitry.torokhov@gmail.com; pali.rohar@gmail.com; r=
ydberg@bitmath.org; linux@roeck-us.net; open list:HID CORE LAYER <linux-i=
nput@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; stable@vger.k=
ernel.org
> Subject: Re: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint =
flag for 74 03 28 devices
>=20
> Oops, forgot the attachments
>=20
> On Sun, Mar 05, 2017 at 12:56:19PM -0500, Paul Donohue wrote:
> > Masaki: Do you have any information about this touchpad you can share=
?  Is the third byte in EC relevant to the protocol and something we shou=
ld look for when identifying devices in the driver?
> >=20
> > Nick:
> >=20
> > Unfortunately, I didn't print quite enough information in the two-fin=
ger message, but yeah, this kinda looks like a different protocol.
> >=20
> > I've attached two tarballs this time:
> > 1) alps_2a.tar.gz prints some additional info in the two-finger messa=
ge which may help figure out what protocol your device is speaking:
> > sudo -s
> > dkms remove alps_ss5/1.0 --all
> > cd /usr/src/
> > rm -rf alps_ss5-1.0
> > tar -xvzf alps_2a.tar.gz
> > dkms install alps_ss5/1.0
> > modprobe -r psmouse ; modprobe psmouse # Try two-finger scrolling,=20
> > then run:
> > dmesg | grep 'two-finger'
> >=20
> > 2) alps_2b.tar.gz disables the driver unless the third byte in EC is =
0x13 (the value my device uses) ... This driver should make your mouse wo=
rk properly:
> > sudo -s
> > dkms remove alps_ss5/1.0 --all
> > cd /usr/src/
> > rm -rf alps_ss5-1.0
> > tar -xvzf alps_2b.tar.gz
> > dkms install alps_ss5/1.0
> > modprobe -r psmouse ; modprobe psmouse
> >=20
> > Try those out and let's see where that gets us.
> >=20
> > When you are done testing, you can revert back to whatever driver cam=
e with your kernel by running:
> > sudo -s
> > dkms remove alps_ss5/1.0 --all
> > modprobe -r psmouse ; modprobe psmouse
> >=20
> > -Paul
> >=20
> > On Sun, Mar 05, 2017 at 09:09:01AM +0000, Nick Fletcher wrote:
> > > Hi All,
> > >=20
> > > My touchpad has the physical buttons above the touchpad.
> > >=20
> > > I have cut and pasted the the results of the two dmesg commands=20
> > > below.  The trackpad of course stopped working correctly again afte=
r=20
> > > installing alps_ss5-1.0.
> > >=20
> > > I'm afraid any experimenting with the code myself may be beyond my =
ability.
> > > :-(
> > >=20
> > > root@brassneck-test:/usr/src# modprobe -r psmouse ; modprobe psmous=
e=20
> > > root@brassneck-test:/usr/src# dmesg | grep 'ALPS ID'
> > > [  239.983818] psmouse serio1: alps: ALPS ID: E7=3D73 03 28, EC=3D7=
3 01=20
> > > 14 [  240.433532] psmouse serio1: alps: ALPS ID: E7=3D73 03 28, EC=3D=
73=20
> > > 01 14 root@brassneck-test:/usr/src# dmesg | grep two-finger [ =20
> > > 279.294490] psmouse serio1: alps: ALPS two-finger packet w/ button
> > > (buttonpad: 0): d9 73 24
> > >=20
> > >=20
> > > Thank you for your help in this and thank you to Joseph for buildin=
g=20
> > > all the test kernels whilst attempting to find out which commit=20
> > > first caused my issue.
> > >=20
> > > Cheers,
> > > Nick.
> > >=20
> > > On 4 March 2017 at 16:15, Paul Donohue <linux-kernel@paulsd.com> wr=
ote:
> > >=20
> > > > I have a 74 03 28 device on a Dell Precision laptop that handles=20
> > > > two-finger scrolling fine.  Without this patch, my mouse function=
s=20
> > > > only as a dumb PS/2 mouse, which means I lose all multi-touch and=
=20
> > > > scrolling capabilities entirely.  So I would rather not see this=20
> > > > reverted. :)
> > > >
> > > > I suspect one of two things:
> > > > 1) My device has physical buttons below the touchpad.  There are=20
> > > > some different code paths for devices without physical buttons=20
> > > > below the touchpad.  Perhaps there is a bug in those alternate=20
> > > > code paths?  Does the buggy device have physical buttons?
> > > > 2) Perhaps this is a new ALPS variant which speaks a new protocol=
=20
> > > > that is not currently handled by the driver but which isn't=20
> > > > properly identified/differentiated by the alps_identify() functio=
n?
> > > >
> > > > To get some additional data, grab the attached tarball, then:
> > > > sudo -s
> > > > cd /usr/src/
> > > > tar -xvzf alps_1.tar.gz
> > > > apt install dkms
> > > > dkms install alps_ss5/1.0
> > > > # Do not copy and paste the modprobe command!  Type it manually!
> > > > # Otherwise the mouse click used to paste the command at the same=
=20
> > > > time as # reloading the driver may crash the kernel.
> > > > modprobe -r psmouse ; modprobe psmouse dmesg | grep 'ALPS ID'
> > > >
> > > > In the dmesg output, you should see something like:
> > > > psmouse serio1: alps: ALPS ID: E7=3D73 03 28, EC=3D73 01 13
> > > >
> > > > Are the E7 and EC numbers identical to the above?
> > > >
> > > > Then try two-finger scrolling, then run:
> > > > dmesg | grep 'two-finger'
> > > >
> > > > In the dmesg output, I expect you should see something like:
> > > > psmouse serio1: alps: ALPS two-finger packet (buttonpad: 0): 1c 5=
1=20
> > > > 46
> > > >
> > > > We can compare your output to mine to see what is different.
> > > >
> > > > If you're willing to experiment with the code yourself to try to=20
> > > > figure out more, the relevant code is in alps_decode_ss4_v2() in=20
> > > > src/alps.c in that tarball.  You should see the "ALPS two-finger=20
> > > > packet" debug message I added there ... you can add additional=20
> > > > debugging messages to figure out what exactly the decoder is=20
> > > > doing.  The SS4_* macros for bit manipulation and field extractio=
n=20
> > > > are defined near the top of src/alps.h.  To recompile/reload the =
driver after making changes:
> > > > dkms remove alps_ss5/1.0 --all
> > > > dkms install alps_ss5/1.0
> > > > modprobe -r psmouse ; modprobe psmouse
> > > >
> > > > On Fri, Mar 03, 2017 at 02:58:34PM -0500, Joseph Salisbury wrote:
> > > > > Hi Ben,
> > > > >
> > > > > A kernel bug report was opened against Ubuntu [0].  After a=20
> > > > > kernel bisect, it was found that reverting the following commit=
=20
> > > > > resolved this
> > > > bug:
> > > > >
> > > > > commit aeaa881f9b17823028b464893b89c42db797b717
> > > > > Author: Ben Gamari <ben@smart-cactus.org>
> > > > > Date:   Tue Oct 4 11:43:30 2016 -0700
> > > > >
> > > > >     Input: ALPS - set DualPoint flag for 74 03 28 devices
> > > > >
> > > > > The regression was introduced as of v4.9-rc1.
> > > > >
> > > > > I was hoping to get your feedback, since you are the patch=20
> > > > > author.  Do you think gathering any additional data will help=20
> > > > > diagnose this issue, or would it be best to submit a revert req=
uest?
> > > > >
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Joe
> > > > >
> > > > > [0] http://pad.lv/1662589
> > > > >
> > > >
>=20
