From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Fri, 27 Mar 2015 21:54:04 +0100
Message-ID: <201503272154.04582@pali>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com> <201503272108.57759@pali> <CAPXTYCVGpm27naqu723f8kC0h75TT6XSN0X_EWCu6cXJS0G2kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2239359.2VhlSMxutW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPXTYCVGpm27naqu723f8kC0h75TT6XSN0X_EWCu6cXJS0G2kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

--nextPart2239359.2VhlSMxutW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 27 March 2015 21:32:12 Santiago Gala wrote:
> I guess the difference is more due to new limits reported.
>=20
> Now I get only one device:
>=20
> /dev/input/event11
>    bustype : BUS_I8042
>    vendor  : 0x2
>    product : 0x8
>    version : 1792
>    name    : "AlpsPS/2 ALPS GlidePoint"
>    phys    : "isa0060/serio1/input0"
>    bits ev : EV_SYN EV_KEY EV_ABS
>=20

Ok, it means that trackstick detection patch detected that you do=20
not have trackstick (and you have only touchpad device).

And also that psmouse.ko is really using ALPS driver.

> And it produces different output in evemu-describe. I attach
> alps11-new.txt (the new one). See fragment of difference with
> relevant previous one:
>=20
> @@ -38,17 +38,17 @@
>  #     Event code 53 (ABS_MT_POSITION_X)
>  #       Value      0
>  #       Min        0
> -#       Max      448
> +#       Max     4095
>  #       Fuzz       0
>  #       Flat       0
> -#       Resolution 4
> +#       Resolution 42
>  #     Event code 54 (ABS_MT_POSITION_Y)
>  #       Value      0
>  #       Min        0
> -#       Max        0
> +#       Max     2047
>  #       Fuzz       0
>  #       Flat       0
> -#       Resolution 0
> +#       Resolution 38
>  #     Event code 57 (ABS_MT_TRACKING_ID)
>  #       Value      0
>  #       Min        0
>=20
> So resolutions are reported clearly different than with the
> broken patch.
>=20

Can you look at difference between old 3.19 kernel version and=20
this new one? To check if there is no regression.

> Regards
> Santiago
>=20
> El vie., 27 de marzo de 2015 a las 21:09, Pali Roh=C3=A1r
> (<pali.rohar@gmail.com>)
>=20
> escribi=C3=B3:
> > Hello,
> >=20
> > there should no functional changes (e.g. acceleration speed,
> > etc.). And if yes, there is probably some side effect which
> > should be investigated.
> >=20
> > Please can you provide output from dmesg (grep for psmouse
> > or input) and also output from lsinput?
> >=20
> > That changed acceleration/speed sounds like psmouse
> > fallbacks to some ImPS/2 relative protocol and not ALPS...
> >=20
> > On Friday 27 March 2015 20:46:59 Santiago Gala wrote:
> > > It works quite well! :)
> > >=20
> > > I got some issues: at first it didn't work after I mv'ed
> > > the original and put the unzipped new in its place. After
> > > reboot it failed exactly the same, but after I "sudo
> > > /etc/init.d/lightdm stop; sudo modprobe -r psmouse; sudo
> > > modprobe psmouse; sudo /etc/init.d/lightdm start" it
> > > worked. Then I remembered about the initrd.img which
> > > should contain it. So I did "sudo dpkg-reconfigure
> > > linux-image-4.0.0-040000rc5-generic", rebooted again and
> > > here I am.
> > >=20
> > >=20
> > > Things seem to work all right. The only thing I notice is
> > > that the old driver moved fast in console mode (with gpm)
> > > while the new one is rather slow, would need to tweak the
> > > acceleration configuration. even after adding
> > > "responsiveness=3D15" to the configuration, as the sample
> > > /etc/gpm.conf says, it is slower than the previous kernel
> > > with the stock configuration.
> > >=20
> > >=20
> > > Regards
> > >=20
> > > Santiago
> > >=20
> > >=20
> > > El vie., 27 de marzo de 2015 a las 18:17, Pali Roh=C3=A1r
> > > (<pali.rohar@gmail.com>) escribi=C3=B3:
> > >=20
> > > On Thursday 26 March 2015 16:33:13 you wrote:
> > > > El mar., 24 de marzo de 2015 a las 17:48, Pali Roh=C3=A1r
> > > > (<pali.rohar@gmail.com>)
> > > >=20
> > > > escribi=C3=B3:
> > > > > Hello, I can compile psmouse.ko module for you. Just
> > > > > let me know which ubuntu kernel (and from) are you
> > > > > using.
> > > >=20
> > > > This one could do:
> > > >=20
> > > > http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-rc5-v
> > > > ivid /
> > > >=20
> > > > or at a choice any further one (they get published as
> > > > they are released)
> > > >=20
> > > > Regards
> > > > Santiago
> > >=20
> > > Hello, in attachment is gzipped psmouse.ko module compiled
> > > against above ubuntu kernel from linus git tree (3c435c1e)
> > > with additional patches:
> > >=20
> > > https://lkml.org/lkml/2015/3/21/282
> > > https://lkml.org/lkml/2015/3/22/93
> > > https://lkml.org/lkml/2015/3/22/94
> > >=20
> > > Test it and if everything works as expected, please send
> > > email to all all people and ML. Thanks.
> > >=20
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2239359.2VhlSMxutW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUVw2wACgkQi/DJPQPkQ1IhNwCfTCW7xpYkgy/XJLnL/uB5SNEt
yO0Anj++8KS5wfXgnzBOrz0De/6jnSN2
=fhxr
-----END PGP SIGNATURE-----

--nextPart2239359.2VhlSMxutW--
