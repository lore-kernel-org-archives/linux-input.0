From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xpad: Add support for two more dance pads and one more
 guitar
Date: Wed, 22 Jun 2011 14:48:51 -0700
Message-ID: <20110622214850.GD978@core.coreip.homeip.net>
References: <1306823799.8840.8.camel@ubuntu>
 <20110531075348.GA13855@core.coreip.homeip.net>
 <1306829685.8840.13.camel@ubuntu>
 <1306841481.16310.5.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:33407 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab1FVVs7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2011 17:48:59 -0400
Received: by pzk26 with SMTP id 26so828259pzk.10
        for <linux-input@vger.kernel.org>; Wed, 22 Jun 2011 14:48:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306841481.16310.5.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Magnus =?iso-8859-1?Q?H=F6rlin?= <magnus@alefors.se>, linux-input@vger.kernel.org, oneukum@suse.de

On Tue, May 31, 2011 at 01:31:21PM +0200, Christoph Fritz wrote:
> On Tue, 2011-05-31 at 10:14 +0200, Magnus H=F6rlin wrote:
> > +       { 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO=
_BUTTONS, XTYPE_XBOX360 },
> > +       { 0x0e6f, 0x0105, "HSM3 Xbox360 dancepad", MAP_DPAD_TO_BUTT=
ONS, XTYPE_XBOX360 },
>=20
> Nice to see that MAP_DPAD_TO_BUTTONS is used.
>=20
> Reviewed-by: Christoph Fritz <chf.fritz@googlemail.com>
>=20

Applied to 'next', thanks Magnus.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
