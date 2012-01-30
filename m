From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] input: mc13783_ts: rename to mc13xxx_ts
Date: Mon, 30 Jan 2012 08:33:39 +0100
Message-ID: <20120130073339.GI6305@pengutronix.de>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
 <1327877464-23526-2-git-send-email-marc@cpdesign.com.au>
 <CAOMZO5C4CfUXWZqSn+0g_gi6wEmv7L+mKhfggcV8evdUJEtVhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54514 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2A3Hdq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jan 2012 02:33:46 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5C4CfUXWZqSn+0g_gi6wEmv7L+mKhfggcV8evdUJEtVhg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marc Reilly <marc@cpdesign.com.au>, linux-input@vger.kernel.org, s.hauer@pengutronuix.de, linux-arm-kernel@lists.infradead.org

Hello,

On Mon, Jan 30, 2012 at 12:52:59AM -0200, Fabio Estevam wrote:
> On Sun, Jan 29, 2012 at 8:51 PM, Marc Reilly <marc@cpdesign.com.au> w=
rote:
> > Start moving this driver towards support for both mc13892 and mc137=
83.
> >
> > This patch simply renames mc13783 specific identifiers to the gener=
ic
> > mc13xxx. A platform_device_id table is also added so that the drive=
r
> > is still created correctly for the mc13783 only.
> >
> > Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> > ---
> > =A0drivers/input/touchscreen/Kconfig =A0 =A0 =A0| =A0 =A08 +-
> > =A0drivers/input/touchscreen/Makefile =A0 =A0 | =A0 =A02 +-
> > =A0drivers/input/touchscreen/mc13783_ts.c | =A0259 ----------------=
---------------
> > =A0drivers/input/touchscreen/mc13xxx_ts.c | =A0267 ++++++++++++++++=
++++++++++++++++
> > =A04 files changed, 272 insertions(+), 264 deletions(-)
> > =A0delete mode 100644 drivers/input/touchscreen/mc13783_ts.c
> > =A0create mode 100644 drivers/input/touchscreen/mc13xxx_ts.c
>=20
> For the rename, it is better to do:
> git mv  drivers/input/touchscreen/mc13783_ts.c
> drivers/input/touchscreen/mc13xxx_ts.c
>=20
> git commit -a
>=20
> and then git format -M -1 , as it will detect the rename.
git format-patch -M will detect the rename independently of how the
commit was created. Using git mv doesn't result in adding any special
metadata to the commit, it's just mv $old $new; git rm $old; git add
$new.

But +1 on using -M (or not renaming the driver).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
