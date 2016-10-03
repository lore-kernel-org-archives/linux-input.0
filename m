From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH v3] Support for Alps SS5 touchpad
Date: Mon, 03 Oct 2016 08:15:19 -0400
Message-ID: <87fuodaaso.fsf@ben-laptop.smart-cactus.org>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org> <alpine.LRH.2.00.1607291045590.21952@gjva.wvxbf.pm> <20160829071455.GB2968@dhcp22.suse.cz> <alpine.LNX.2.00.1610030922340.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from turtle.smart-cactus.org ([163.172.166.228]:55538 "EHLO
        mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbcJCMUn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 08:20:43 -0400
In-Reply-To: <alpine.LNX.2.00.1610030922340.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jiri Kosina <jikos@kernel.org> writes:

> On Mon, 29 Aug 2016, Michal Hocko wrote:
>>=20
>> Thanks to Jiri for pointing me to these patches. I was running with them
>> for few days and they seem to be working reasonably well on my Latitude
>> E7470. The only annoying thing is that the vertical scrolling mode seems
>> to be hard to exit - sometimes you can get almost to the (horizontal)
>> middle of the touch pad and the scrolling is still active. I haven't
>> found any scrolling area width configuration knob though.
>>=20
>> Anyway, feel free to add my
>> Tested-by: Michal Hocko <mhocko@suse.com>
>>=20
>> Btw. I've noticed that none of the patches has your signed-off-by which
>> is required for any patch to be applied.
>
> Ben, Dmitry, has this fallen in between the cracks?
>
Indeed it sadly has. Sending a new version right now. Thanks for the
ping.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJX8kvXAAoJEHPt6ejPuu8BEhIIALtjlPxKVoKu/U4tSBgxz6yZ
yB5s4lMsN/Ye4RSCxIG1HYvIidgYrNNR12mt+h3ccD/lUHM5VA/YynEZXxA/N1In
xfVkyEDtt2YqQ5CeBTjOkoXWu0rKzuVjWlIkq5XdqKQrczWMhaJy6gVx6goHhUZd
1OwEwUyjMwE3kINLRRAUGfPvkiiw2WAbvTt89e0fDXMlVEarHf2dzEIcAj2vZo2z
Jq1lZRkBvKtm8bqRvyQcfLlGOWKNeuJzWnBp2nh+u4Wp+MD4kgOoG6EWOAJ9BS20
xsO0DPWM5JYIGNFx5o/rGiSw9mIkCEXvgXlIdVXqgkFU7HC7vdX5aTSVeMmuYUg=
=olRy
-----END PGP SIGNATURE-----
--=-=-=--
