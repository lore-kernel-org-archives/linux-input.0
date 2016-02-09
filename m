From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 4/7] HID: sony: make the check for BUZZ_CONTROLLER more
 readable
Date: Tue, 9 Feb 2016 14:02:16 +0100
Message-ID: <20160209140216.57eced897fcf80eeca9b819e@ao2.it>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it>
	<1454001827-26732-5-git-send-email-ao2@ao2.it>
	<E1835BCB-CF3E-47D8-B782-A971D64685C5@gmail.com>
	<20160202161913.111f39918038b91287c234f2@ao2.it>
	<alpine.LNX.2.00.1602051430110.22727@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:61036 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507AbcBINCW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 08:02:22 -0500
In-Reply-To: <alpine.LNX.2.00.1602051430110.22727@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Frank Praznik <frank.praznik@gmail.com>, linux-input@vger.kernel.org

On Fri, 5 Feb 2016 14:30:45 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Tue, 2 Feb 2016, Antonio Ospite wrote:
>=20
> > > My nitpick here is that moving the common case to the =E2=80=98el=
se=E2=80=99 branch
> > > can mean more branch mispredictions.  This isn=E2=80=99t a partic=
ularly hot
> > > piece of code, but I still prefer common-case first.
> > >
> >=20
> > Hi Frank,
> >=20
> > I see your point. Let's drop 4/7 for now then.
> > Jiri, will you apply the other patches? They have Frank's ACK.
>=20
> For some reason I can't seem to find any traces of this thread neithe=
r in=20
> my inbox nor in my linux-input@ archives.
>=20
> Could you please resend the patchset (with 4/7 removed)? Thanks.
>

Sure.

I've just sent them again.

Please let me know if they arrived. If not, I think I'll have to check
if there is anything wrong with th SMTP I am using as it happened
before that some of my messages got lost.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
