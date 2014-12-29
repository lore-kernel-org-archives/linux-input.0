From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add a new id 0x501a for Genius MousePen i608X
Date: Mon, 29 Dec 2014 11:14:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412291112460.1680@pobox.suse.cz>
References: <1419632910-12773-1-git-send-email-giedrius.statkevicius@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34766 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaL2KOY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Dec 2014 05:14:24 -0500
In-Reply-To: <1419632910-12773-1-git-send-email-giedrius.statkevicius@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?Giedrius_Statkevi=E8ius?= <giedrius.statkevicius@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, 27 Dec 2014, Giedrius Statkevi=C4=8Dius wrote:

> New Genius MousePen i608X devices have a new id 0x501a instead of the
> old 0x5011 so add a new #define with "_2" appended and change require=
d
> places.
>=20
> The remaining two checkpatch warnings about line length
> being over 80 characters are present in the original files too and th=
is
> patch was made in the same style (no line break).
>=20
> Just adding a new id and changing the required places should make the
> new device work without any issues according to the bug report in the
> following url.
>=20
> This patch was made according to and fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D67111
>=20
> Signed-off-by: Giedrius Statkevi=C4=8Dius <giedrius.statkevicius@gmai=
l.com>

Applied to for-3.19/upstream-fixes.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
