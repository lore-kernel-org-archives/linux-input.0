From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: in kernel contact tracking
Date: Fri, 11 Jun 2010 12:04:46 +0200
Message-ID: <AANLkTikB3leWMK6-P32FZf5zIzQQRpxVNiEW_hXPK-qG@mail.gmail.com>
References: <4C10393F.40303@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54536 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0FKKFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 06:05:07 -0400
Received: by gye5 with SMTP id 5so548172gye.19
        for <linux-input@vger.kernel.org>; Fri, 11 Jun 2010 03:05:06 -0700 (PDT)
In-Reply-To: <4C10393F.40303@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, Ping <pinglinux@gmail.com>

Hi,

I think it's better for the kernel to send event to user space and the
tracking would be done inside a daemon where we can add also other
features than tracking.

Many differences exist for MT devices, some do the tracking inside the
firmware others don't, so maybe a user space daemon can handle all
this.
Isn't all this similar to touchpads that present a very non stable
input when used directly and where we add after in the stack a
module/function to remove the shaking (I think in X) ?

What you think about that ?

ik.



On Thu, Jun 10, 2010 at 3:00 AM, Rafi Rubin <rafi@seas.upenn.edu> wrote=
:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Now that Henrik's slots seem to be coming along, I'd like to see what=
 people
> think about in kernel contact tracking.
>
> I'd certainly like to see it available for hid-ntrig, but would rathe=
r see the
> centralized code to make it available to all the devices lacking or w=
ith poor
> tracking.
>
> Any objection on general principles, or would this simply be a matter=
 of getting
> it right?
>
>
> Cheers,
> Rafi
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkwQOTsACgkQwuRiAT9o60/ADQCeJMOK9sLcyN0CNcEeSFvEY1Xc
> GFsAoLkC6PvzZjrQfWjQC1qcgmBExpjn
> =3Dy+qv
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
