From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] Input: ALPS - fix trackstick detection on some Dell
 Latitudes
Date: Thu, 15 Jan 2015 13:00:59 -0800
Message-ID: <20150115210059.GC19367@dtor-ws>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
 <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
 <201501152121.35052@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:51068 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbbAOVBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 16:01:04 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so41404igj.4
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 13:01:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201501152121.35052@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 09:21:34PM +0100, Pali Roh=E1r wrote:
> On Wednesday 14 January 2015 23:55:53 Dmitry Torokhov wrote:
> > +	/*
> > +	 * Reset the device to make sure it is fully operational:
> > +	 * on some laptops, like certain Dell Latitudes, we may
> > +	 * fail to properly detect presence of trackstick if device
> > +	 * has not been reset.
> > +	 */
> > +	psmouse_reset(psmouse);
> > +
> > +	priv =3D kzalloc(sizeof(struct alps_data), GFP_KERNEL);
> > +	if (priv)
>=20
> if (!priv)

Yep, thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
