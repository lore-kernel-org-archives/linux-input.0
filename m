From: Jiri Kosina <jikos@kernel.org>
Subject: Re: drivers/hid/wacom_wac.c:2484: bad if test ?
Date: Mon, 16 Nov 2015 23:39:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511162336270.20111@pobox.suse.cz>
References: <DUB128-W780599F7F3EBF63F33B96A9C1E0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45022 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbKPWjL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 17:39:11 -0500
In-Reply-To: <DUB128-W780599F7F3EBF63F33B96A9C1E0@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Skomra <aaron.skomra@wacom.com>

On Mon, 16 Nov 2015, David Binderman wrote:

> Hello there,
>=20
> drivers/hid/wacom_wac.c:2484:35: warning: logical =91or=92 of collect=
ively=20
> exhaustive tests is always true [-Wlogical-op]
>=20
> Source code is
>=20
> if (features->type>=3D INTUOSHT || features->type <=3D BAMBOO_PT)

Good catch, that code is obviously crappy.

Adding Ping, Aaron and Jason to CC.

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
