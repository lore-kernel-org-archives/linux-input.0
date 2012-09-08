From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: picoLCD: fix a NULL test in picolcd_raw_cir()
Date: Sat, 8 Sep 2012 21:20:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209082119470.31277@pobox.suse.cz>
References: <20120907064740.GB12028@elgon.mountain> <20120907233818.62aa63d2@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60826 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174Ab2IHTUQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 8 Sep 2012 15:20:16 -0400
In-Reply-To: <20120907233818.62aa63d2@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 7 Sep 2012, Bruno Pr=C3=A9mont wrote:

> > Smatch complains that the NULL checking in this function is not
> > consistent and could lead to a NULL dereference.  The comments say =
that
> > we should return here if rc_dev is NULL so I've changed the test to
> > match the comment.
>=20
> Good catch! Currently thanks to HID mutex around probe()/remove()
> we should never be able to see rc_dev being NULL here.
>=20
>=20
> Once the probe()/remove() mutex gets tied to hw_start()/hw_stop() or
> otherwise changed to allow drivers to chat with device during probe()
> ->rc_dev might be NULL in picolcd_raw_cir().
>=20
>=20
> Reviewed-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Applied, thanks Dan, thanks Bruno.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
