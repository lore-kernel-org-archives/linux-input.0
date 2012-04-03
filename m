From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] HID: hid-lg: Allow for custom device-specific properties
 to be stored in private drv data
Date: Tue, 3 Apr 2012 04:11:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204030411230.16928@pobox.suse.cz>
References: <4193443.YXckiBU47J@qosmio-x300> <04cae81f4bc46c65625e24eda03e0949.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40804 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309Ab2DCCLs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Apr 2012 22:11:48 -0400
In-Reply-To: <04cae81f4bc46c65625e24eda03e0949.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: =?ISO-8859-15?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

On Sun, 1 Apr 2012, simon@mungewell.org wrote:

> > Hi,
> >
> > I (hopefully) sorted out the mess. This patch only adds support for
> > custom device-specific properties which can now be stored as
> > private driver data and read/saved using hid_get/set_drvdata().
> >
> > Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
> Looks good to me, built and tested working with a G27.
>=20
> Signed-off-by: simon@mungewell.org
>=20

Thanks guys, applied with Simon's Tested-by.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
