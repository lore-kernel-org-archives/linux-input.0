From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Fri, 1 Oct 2010 15:32:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011532130.29535@pobox.suse.cz>
References: <1284476919.3732.10.camel@PhEeeTab>  <4CA242B7.7020609@euromail.se>  <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr> <1285703702.1653.26.camel@PhEeeTab> <A03B2B76-DA22-49AF-9484-4365BE6AB3D9@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51783 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521Ab0JANct (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 09:32:49 -0400
In-Reply-To: <A03B2B76-DA22-49AF-9484-4365BE6AB3D9@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Philipp Merkel <mail@philmerk.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>

On Tue, 28 Sep 2010, St=E9phane Chatty wrote:

> > > By the way, since you apparently have access to a Joojoo and I di=
d
> > > not get any response from any Joojoo owner, can you tell us wheth=
er
> > > it exhibits the bogus Xs and Ys that Philipp has observed? It wou=
ld
> > > be consistent with the range inconsistency that you have observed=
=2E
> >=20
> > As I wrote in my previous message (but was too slow and didn't read
> > yours before sending it), the problem Henrik is describing sounds
> > exactly like the one I experienced which is fixed by the three bit
> > shift.
>=20
> Then we could take Philipp's fix for now, and start looking for a way=
 to
> cross-test Henrik's proposal. Jiri, do you agree on this?

Sounds reasonable to me. So can I add

	Acked-by: St=E9phane Chatty <chatty@enac.fr>

to Philipp's patch?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
