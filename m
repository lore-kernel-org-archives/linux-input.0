From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v2 0/2] hid: sony: Clear and restore controller state on
 suspend and resume
Date: Thu, 19 Nov 2015 11:51:40 +0100
Message-ID: <20151119115140.426f28d26d25788fca48ad3b@ao2.it>
References: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
	<20151115163049.a5dc8380db1280ca1532f112@ao2.it>
	<E0EFFAFE-F9E3-435B-A89A-089F5C30A471@gmail.com>
	<20151119113955.e88576e0bcfdad68c9aaacd9@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:28491 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758299AbbKSKvn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 05:51:43 -0500
In-Reply-To: <20151119113955.e88576e0bcfdad68c9aaacd9@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Thu, 19 Nov 2015 11:39:55 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> On Tue, 17 Nov 2015 08:57:05 -0500
> Frank Praznik <frank.praznik@gmail.com> wrote:
> =20
> > > On Nov 15, 2015, at 10:30, Antonio Ospite <ao2@ao2.it> wrote:
> [...]=20
> > >=20
> > > Hi Frank, the changes are basically OK, but there are warnings an=
d
> > > errors from scripts/checkpatch.pl
> > >=20
> > > Would you care to send a v3 which fixes those?
> [...]
> >=20
> > I think checkpatch.pl has some issues at the moment as all of the
> > whitespace errors it reports are are single spaces and are part of =
the
> > patch file formatting and not in the code itself (a space at the
> > beginning of lines that don=E2=80=99t begin with a =E2=80=98+' or =E2=
=80=98-' and after the
> > final =E2=80=98=E2=80=94').  To be sure, I double checked that the =
formatting in the
> > source file was free of extra whitespace, regenerated the patches a=
nd
> > checkpatch still complains because it=E2=80=99s git format-patch pu=
tting the
> > spaces there (as it always has).
>=20
> I tried again with checkpatch.pl from 4.4-rc1 and the errors and
> warnings seem about right: they are about the newly added lines, and
> about the commit message wrapping.
>=20

OK, just saw Jiri's message, so the patches are in.

I guess I can send fixups myself then, should anything really bother
me :)

Ciao ciao,
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
