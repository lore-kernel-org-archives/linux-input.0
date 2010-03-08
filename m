From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] USB: N-trig Finger Pen Multitouch fix
Date: Mon, 8 Mar 2010 13:51:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003081348470.17799@pobox.suse.cz>
References: <48A28051AC6D7A48B64F28272458190301AF29@Exchange-IL.n-trig.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52006 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab0CHMvZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 07:51:25 -0500
In-Reply-To: <48A28051AC6D7A48B64F28272458190301AF29@Exchange-IL.n-trig.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Micki Balanga <micki@n-trig.com>
Cc: rafi@seas.upenn.edu, chatty@enac.fr, peterhuewe@gmx.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 7 Mar 2010, Micki Balanga wrote:

> The purpose of this patch is to enable Linux users to experience the=20
> complete N-trig DuoSense pen and true multi-touch solution capabiliti=
es=20
> over a Linux platform. This driver has been carefully and thoroughly=20
> tested by N-trig, over a period of several months.
>=20
> N-trig is changing the way people interact with computers by providin=
g a=20
> dual-mode pen and true multi-touch input device, specifically designe=
d=20
> for today's advanced computing world. N-trig DuoSense=AE solution pro=
vides=20
> a real Hands-on computing=AE experience, and sets the stage for OEMs =
and=20
> ISVs to introduce innovative computer products and applications for a=
n=20
> intuitive, Hands-on=AE experience directly onscreen. DuoSense digitiz=
ers=20
> are easily integrated into existing technologies, support all LCDs, k=
eep=20
> devices slim and light, and can be implemented in a broad range of=20
> products, ranging from small notebooks to large LCDs. N-trig has offi=
ces=20
> in Israel, the US, Taiwan and Japan.
>=20
> Signed-off-by: Micki Balanga <micki@n-trig.com>

Thanks for the patch.

As you are very well aware, we already have n-trig driver written by Ra=
fi=20
Rubin. I understand that your patch is implementing new features that=20
Rafi's patch is not able to handle, and also re-factoring the driver in=
 a=20
non-trivial way.

Therefore it would be nice, if you could separate out the individual=20
changes/additions to be based on top of the driver that we already have=
,=20
and accompany them with nice changelog describing what changes are bein=
g=20
done and why=20

Or even Rafi volunteered to do this, as I can see -- thanks for that! I=
t=20
would still be nice to get Acked-by from the N-Trig guys for the change=
s=20
at least.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
