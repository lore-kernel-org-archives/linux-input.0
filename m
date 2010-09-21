From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Tue, 21 Sep 2010 19:05:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211904290.26813@pobox.suse.cz>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-3-git-send-email-rydberg@euromail.se> <B5146B49-1D7A-4AFD-B925-3F35E83A2A96@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36519 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab0IURF2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 13:05:28 -0400
In-Reply-To: <B5146B49-1D7A-4AFD-B925-3F35E83A2A96@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 21 Sep 2010, St=E9phane Chatty wrote:

> > The current code sometimes misses to report the last BTN_TOUCH even=
t
> > when multiple fingers are lifted simultaneously.  With the
> > introduction of MT slots, the tracking id is available to determine
> > the oldest active contact. Use this information to simplify and
> > correct the touchscreen emulation logic.
> >=20
>=20
> Acked-by: St=E9phane Chatty <chatty@enac.fr>

It doesn't apply without 2/3 being applied as well. So I'll not be=20
applying it for now, and either please rebase it, or re-send together w=
ith=20
2/3 once the situation with 0eef:72xx is sorted out. Ok?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
