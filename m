From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Thu, 26 Apr 2007 10:24:51 +0200
Message-ID: <1177575892.6814.9.camel@johannes.berg>
References: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YkUwZKj+gfBLskrhNLNx"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Barton C Massey <bart@cs.pdx.edu>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org


--=-YkUwZKj+gfBLskrhNLNx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 17:21 -0700, Barton C Massey wrote:

>   2) You can use an xorg.conf entry as simple as

[as corrected by your subsequent mail]

>   Section "InputDevice"
>     Identifier  "EvMightyMouse0"
>     Driver "evdev"
>     Option "Name" "Mitsumi Electric Apple Optical USB Mouse"
>   EndSection

The only way I've been able to make it work with evdev is this:
=20
Section "InputDevice"
        Identifier      "EvDev"
        Driver          "evdev"
        Option          "SendCoreEvents"        "true"
        Option          "evBits"                "+1-2"
        Option          "keyBits"               "~272-287"
        Option          "relBits"               "~0-2 ~6 ~8"
        Option          "Pass"                  "3"
#(optional)
#       Option          "WHEELRelativeAxisButtons"      "4 5"
        Option          "HWHEELRelativeAxisButtons"     "7 6"
EndSection

(You use Name to match, I used the *Bits stuff but that doesn't matter,
I tried your version too, albeit with SendCoreEvents or I get nothing at
all)

This seems really strange since we both use the evdev driver and all I
do is some matching on which devices are allowed. What version of evdev
are you using? It surely wasn't built before Jan 2005, was it? :)

Oh and before I forget to ask this, are you using a big or little endian
machine? I've had stupid input layer endianness bugs because the kernel
exports the bits there in a strange way... The changelog indicates it
was fixed in May 2006 for evdev though.

What programs are you using for testing? In xev now, I get:
move finger up: button 4
move finger down: button 5
move finger left: button 6
move finger right: button 7

Is that wrong? It seems to indicate that the coordinate system is rooted
at the upper left corner which seems sane. But this is with the
inversion programmed into my X config.

I can live with this inversion in there, but it seems very strange that
the same hardware and same driver should give different results for you
and me.

johannes

--=-YkUwZKj+gfBLskrhNLNx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMGHT/ETPhpq3jKURAmopAJ9/YnMgdku5wWCh59SC4pcKaq6Y7wCgk1Fw
0dM7ka014Z7Kp/1damlOJbw=
=552x
-----END PGP SIGNATURE-----

--=-YkUwZKj+gfBLskrhNLNx--
