From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/4] hid-multitouch: a first step towards multitouch
 unification
Date: Fri, 10 Dec 2010 15:08:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012101507590.15140@pobox.suse.cz>
References: <20101013222811.6EC0B95210@smtp.lii-enac.fr> <E8092693-D2F3-4544-A18E-C7F5DCD8507A@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42606 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab0LJOIx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 09:08:53 -0500
In-Reply-To: <E8092693-D2F3-4544-A18E-C7F5DCD8507A@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: rydberg@euromail.se, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, benjamin.tissoires@enac.fr, tissoire@lii-enac.fr

On Thu, 14 Oct 2010, St=E9phane Chatty wrote:

>=20
> Le 14 oct. 10 =E0 00:28, Stephane Chatty a =E9crit :
>=20
> >=20
> > St=E9phane Chatty (4):
> >  hid-multitouch: support for PixCir-based panels in a generic code =
structure
> >  hid-multitouch: migrated support for Cando panels
> >  hid-multitouch: added support for Cypress TrueTouch panels
> >  hid-multitouch: migrated support for MosArt panels
>=20
> I forgot to mention that:
> - I am looking for testers for Quanta panels
> - I have code that works for the GeneralTouch panels found in some re=
cent
> tablets. But these panels appear to have the exact same device ID as
> previously existing single touch panels, with a different protocol. I=
 am
> working on a solution to discriminate the two types of panels.

[ adding Bejnamin to CC ]

Hi guys,

Henrik had quite a few reasonable comments to this patchset, and then=20
there was a long silence :)

Is there any respin going to happen?

Thanks!

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
