From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH v3] Support for Alps SS5 touchpad
Date: Mon, 03 Oct 2016 08:14:10 -0400
Message-ID: <87int9aaul.fsf@ben-laptop.smart-cactus.org>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org> <alpine.LRH.2.00.1607291045590.21952@gjva.wvxbf.pm> <20160829071455.GB2968@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from turtle.smart-cactus.org ([163.172.166.228]:55534 "EHLO
        mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbcJCMUn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 08:20:43 -0400
In-Reply-To: <20160829071455.GB2968@dhcp22.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 29-07-16 10:46:31, Jiri Kosina wrote:
>> On Tue, 21 Jun 2016, Ben Gamari wrote:
>>=20
>> > Hello all,
>> >=20
>> > Here is the third iteration of my patchset adding support for the Alps=
 SS5
>> > touchpad used in the Dell Latitude E7470. The patch is largely unchang=
ed except
>> > for a reorganization of the DUALPOINT flag detection logic and the add=
ition of
>> > protocol documentation.
>> >=20
>> > Thanks to everyone who has offered reviews so far.
>>=20
>> Seems like this went by unnoticed. Adding Dmitry to CC.
>
> Thanks to Jiri for pointing me to these patches. I was running with them
> for few days and they seem to be working reasonably well on my Latitude
> E7470. The only annoying thing is that the vertical scrolling mode seems
> to be hard to exit - sometimes you can get almost to the (horizontal)
> middle of the touch pad and the scrolling is still active. I haven't
> found any scrolling area width configuration knob though.
>
> Anyway, feel free to add my
> Tested-by: Michal Hocko <mhocko@suse.com>
>
Thanks Michael!

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJX8kuSAAoJEHPt6ejPuu8BywwH/0qZH+TDgwM57q9tYTygxeRI
7Zz1eMblwmG1Wg0QiPOTvvrBO40JGxXTvFQWXXtzUryK16WlffGXioiqEmCbRanz
/xeTTv3VwSHyquW41dA93RSYuYgh8kp27s9lW+zG+lTWCLWfzra+o0Y5H8Zr5R7i
OIQ3akA60oiR2+32N06zUPwpbSh+FgBmmKr+OeX6w53jNL9kiwTm8I8XiyrXycGY
pZ3kda9AcE0coxj/D6TspC5j//zqQKxriruKB+dAeeY6YploKJgkW9i8kUhOw6Nd
/FB+6mm3vTHwuLiP7DeyJMwK8AWjQradLAfGIoQ5Bj38YnNoSzhbq5/GmIBC9A8=
=eqT8
-----END PGP SIGNATURE-----
--=-=-=--
