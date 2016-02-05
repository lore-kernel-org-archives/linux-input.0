From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/7] HID: sony: make the check for BUZZ_CONTROLLER more
 readable
Date: Fri, 5 Feb 2016 14:30:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602051430110.22727@cbobk.fhfr.pm>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it> <1454001827-26732-5-git-send-email-ao2@ao2.it> <E1835BCB-CF3E-47D8-B782-A971D64685C5@gmail.com> <20160202161913.111f39918038b91287c234f2@ao2.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44248 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbcBENar (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 08:30:47 -0500
In-Reply-To: <20160202161913.111f39918038b91287c234f2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Frank Praznik <frank.praznik@gmail.com>, linux-input@vger.kernel.org

On Tue, 2 Feb 2016, Antonio Ospite wrote:

> > My nitpick here is that moving the common case to the =E2=80=98else=
=E2=80=99 branch
> > can mean more branch mispredictions.  This isn=E2=80=99t a particul=
arly hot
> > piece of code, but I still prefer common-case first.
> >
>=20
> Hi Frank,
>=20
> I see your point. Let's drop 4/7 for now then.
> Jiri, will you apply the other patches? They have Frank's ACK.

=46or some reason I can't seem to find any traces of this thread neithe=
r in=20
my inbox nor in my linux-input@ archives.

Could you please resend the patchset (with 4/7 removed)? Thanks.

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
