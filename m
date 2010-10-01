From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Fri, 1 Oct 2010 15:40:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011540180.29535@pobox.suse.cz>
References: <1284476919.3732.10.camel@PhEeeTab>   <4CA242B7.7020609@euromail.se>   <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr>  <1285703702.1653.26.camel@PhEeeTab>  <A03B2B76-DA22-49AF-9484-4365BE6AB3D9@enac.fr> <alpine.LNX.2.00.1010011532130.29535@pobox.suse.cz>
 <1412A8D8-6B7A-46AA-859A-A7CCFF1E2148@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51988 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab0JANkk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 09:40:40 -0400
In-Reply-To: <1412A8D8-6B7A-46AA-859A-A7CCFF1E2148@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Philipp Merkel <mail@philmerk.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>

On Fri, 1 Oct 2010, St=E9phane Chatty wrote:

> > > > > By the way, since you apparently have access to a Joojoo and =
I did
> > > > > not get any response from any Joojoo owner, can you tell us w=
hether
> > > > > it exhibits the bogus Xs and Ys that Philipp has observed? It=
 would
> > > > > be consistent with the range inconsistency that you have obse=
rved.
> > > >=20
> > > > As I wrote in my previous message (but was too slow and didn't =
read
> > > > yours before sending it), the problem Henrik is describing soun=
ds
> > > > exactly like the one I experienced which is fixed by the three =
bit
> > > > shift.
> > >=20
> > > Then we could take Philipp's fix for now, and start looking for a=
 way to
> > > cross-test Henrik's proposal. Jiri, do you agree on this?
> >=20
> > Sounds reasonable to me. So can I add
> >=20
> > 	Acked-by: St=E9phane Chatty <chatty@enac.fr>
> >=20
> > to Philipp's patch?
>=20
> Fine by me. And Henrik's solution should come soon, from what I hear.

Excellent. Applied now, thanks!

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
