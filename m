From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC ebeam PATCH v4 2/2] input: misc: New USB eBeam input driver.
Date: Mon, 03 Sep 2012 14:59:58 +0200
Message-ID: <1816600.0kCAv4ld5c@linux-lqwf.site>
References: <1345673514-11575-1-git-send-email-yann.cantin@laposte.net> <1555763.Oi7gGGn7BU@linux-lqwf.site> <503792CC.6050209@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45428 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab2ICNBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Sep 2012 09:01:17 -0400
In-Reply-To: <503792CC.6050209@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Friday 24 August 2012 16:42:20 Yann Cantin wrote:
> Hi,
>=20
> Le 24/08/2012 13:41, Oliver Neukum a =E9crit :
> > On Friday 24 August 2012 11:37:45 Yann Cantin wrote:
> >> Hi,
> >>
> >> Le 23/08/2012 09:23, Oliver Neukum a =E9crit :
> >>> On Thursday 23 August 2012 00:11:54 Yann Cantin wrote:
> >=20
> >>> These functions are identical. You should unify them.
> >>
> >> Removed reset_resume from the driver (optional, and not needed
> >> for this hardware).
> >=20
> > Why did you do that? It is always better to have reset_resume().
> > And you cannot tell whether it will be needed.
>=20
> This function was used in usbtouchscreen (which this driver is based =
on)
> for some hardware specific init after reset. eBeam devices doesn't ne=
ed that,
> and i didn't mention the similarity of the 2 functions after strippin=
g the code.
>=20
> According to power-management.txt, reset_resume is optional, and lot =
of input
> driver lack it. Anyway, if you think it's worth the code, i'll re-add=
 a=20
> reset_resume function proxing resume like wacom_sys.c do.

It is always better to have reset_resume() if it can be easily done.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
