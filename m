From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 21 Sep 2010 16:06:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211606180.26813@pobox.suse.cz>
References: <1284476919.3732.10.camel@PhEeeTab> <DAB0AEF8-B5D1-4D21-83E2-6535B8AA0A4B@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57214 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab0IUOGk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 10:06:40 -0400
In-Reply-To: <DAB0AEF8-B5D1-4D21-83E2-6535B8AA0A4B@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Philipp Merkel <mail@philmerk.de>, linux-input <linux-input@vger.kernel.org>

On Mon, 20 Sep 2010, St=E9phane Chatty wrote:

> > 3) Only multi-touch pressure events are sent, single touch emulatio=
n is
> >   missing pressure information. This patch adds single-touch
> >   ABS_PRESSURE events.
> >=20
> Oops, thx for the fix.

Stephane, can I consider this being your Acked-by: for the whole patch?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
