From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Wed, 14 May 2014 21:40:05 +0200
Message-ID: <2533450.JrQEqMHNCJ@sigyn>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net> <1398524543-15012-2-git-send-email-madcatxster@devoid-pointer.net> <20140514181402.GF30089@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devoid-pointer.net ([31.31.77.140]:60850 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaENTkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 15:40:08 -0400
In-Reply-To: <20140514181402.GF30089@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

On Wednesday 14 of May 2014 11:14:02 Dmitry Torokhov wrote:
> On Sat, Apr 26, 2014 at 05:02:00PM +0200, Michal Mal=FD wrote:
> > +
> > +/** input_ff_create_mlnx() - Register a device within ff-memless-n=
ext and
> > + *                           the kernel force feedback system
> > + * @dev: Pointer to the struct input_dev associated with the devic=
e.
> > + * @data: Any device-specific data that shall be passed to the cal=
lback.
> > + *        function called by ff-memless-next when a force feedback=
 action
> > + *        shall be performed.
> > + * @control_effect: Pointer to the callback function.
> > + * @update_date: Delay in milliseconds between two recalculations =
of
> > periodic + *               effects, ramp effects and envelopes. Not=
e that
> > this value will + *               never be lower than (CONFIG_HZ / =
1000)
> > + 1 regardless of the + *               value specified here. This =
is not
> > a "hard" rate limiter. + *               Userspace still can submit
> > effects at a rate faster than + *               this value.
>=20
> The update rate change seems useful whether we use new ff implementat=
ion
> or enhance the old one but I would prefer having a separate call to
> control it.

OK, that should not be a problem. Please note that the plan is to use t=
his=20
value to do proper "hard" rate limiting in the future.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
