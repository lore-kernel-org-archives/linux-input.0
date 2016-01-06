From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Wed, 6 Jan 2016 15:55:01 -0800
Message-ID: <20160106235501.GA3129@dtor-ws>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
 <20160105164421.GP22661@pali>
 <568CCC6E.7010707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34588 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbcAFXzF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 18:55:05 -0500
Content-Disposition: inline
In-Reply-To: <568CCC6E.7010707@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Santiago Gala <sgala@apache.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Hung <alex.hung@canonical.com>

On Wed, Jan 06, 2016 at 09:12:30AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 05-01-16 17:44, Pali Roh=E1r wrote:
> >On Sunday 22 March 2015 14:46:11 Pali Roh=E1r wrote:
> >>This patch adds detection of trackstick for v7 protocol devices. Co=
de in this
> >>patch is used in official Dell touchpad linux drivers for Dell mode=
ls:
> >>Dell Latitude E5250/5250, E5450/5450, E5550/5550
> >>
> >>Detection code and base reg for alps v3 rushmore and v7 devices is =
exacly same.
> >>
> >>Also user in bug https://bugzilla.kernel.org/show_bug.cgi?id=3D9480=
1 reported
> >>that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad device =
without
> >>trackstick and kernel reports to userspace also redundant trackstic=
k device.
> >>
> >>Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> >>---
> >
> >Hello!
> >
> >Alex now tested this patch on two Dell machines with ALPS: E5450 (wi=
th
> >TrackStick) and E5250 (without TrackStick).
> >
> >With patch nothing was changed for E5450. And E5250 with patch does =
not
> >show trackstick input device anymore.
> >
> >Tested-by: Alex Hung <alex.hung@canonical.com>
>=20
> With that this patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Pali, it is probably a good idea to send Dmitry a v2 of these 2
> patches rebased on top of the latest next and with Alex' Tested-By
> and my Reviewed-by-s added.

It's alright, I added the tags and applied.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
