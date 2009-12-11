From: Tim Cole <tim.cole@canonical.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Fri, 11 Dec 2009 18:02:09 -0500
Message-ID: <1260572529.3656.12.camel@bede>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com>
	 <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de>
	 <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>
	 <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>
	 <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>
	 <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de>
	 <4B21308F.5070304@canonical.com> <1260541128.3656.6.camel@bede>
	 <4B225601.3080002@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-jZ/xnIvkPoNVlWknYCj8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47596 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396AbZLKXCI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 18:02:08 -0500
In-Reply-To: <4B225601.3080002@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--=-jZ/xnIvkPoNVlWknYCj8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-12-11 at 15:24 +0100, Stefan Bader wrote:
> The problem moved though. For the older kernels it was the tablets that
> were incorrectly detected as joysticks. But that patch of you went upstre=
am
> and now it is the one joystick model that does not work.
> In our tree we reverted the patch in Jaunty, but with Karmic we have the =
other
> behavior. So in essence, someone is always complaining. :-P

I know what you mean, but well -- ideally we want to converge on the
correct behavior.  Otherwise we'll just keep spinning and things stay
broken.

To my view, blacklisting a joystick which (wrongly) reports itself as a
digitizer tablet is an improvement over creating broken joystick devices
for anything that reports itself as a tablet.  From that position we can
fix the problem with the single device reporting the wrong device type
and then everyone can be happy.

-Tim

--=-jZ/xnIvkPoNVlWknYCj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksiz3EACgkQFlpmZvrZ1oxINQCfSmB7tZS4KQ5foP6pxUGqL0b8
cT0AoImcAxpQTvp66SjmBSeXF3GCpkvO
=/e6Z
-----END PGP SIGNATURE-----

--=-jZ/xnIvkPoNVlWknYCj8--

