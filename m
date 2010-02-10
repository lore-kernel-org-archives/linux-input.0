From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fixed bug in single-touch emulation on the Stantum
 panel
Date: Wed, 10 Feb 2010 12:04:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002101204160.30967@pobox.suse.cz>
References: <20100206141912.71BA89520A@smtp.lii-enac.fr> <alpine.LNX.2.00.1002091633250.30967@pobox.suse.cz> <51CE0FF9-9B5D-4AEC-A5D7-882AE79CB194@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44217 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab0BJLEy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 06:04:54 -0500
In-Reply-To: <51CE0FF9-9B5D-4AEC-A5D7-882AE79CB194@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org

On Tue, 9 Feb 2010, St=E9phane Chatty wrote:

> Obviously I got the version number wrong when I submitted the driver =
(was 0.6,
> should have been 1.00). But the bug is there alright: when I look at =
the code
> in your 'for-next' branch, sd->first is reset at line 150 when it sho=
uld be
> reset at line 160 or 161.

I have now applied your fix, thanks.

> > Perhaps you forgot to submit a patch refreshing the driver to newer
> > version (or perhaps I have missed it?).
>=20
> I guess I just ticked the version number to 1.00 *after* submitting t=
he driver
> instead of doing it before. Sorry for the confusion.

I suggest we remove the version number once the driver is merged upstre=
am,=20
as git is much better tracking the versions.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
