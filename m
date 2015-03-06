From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] use more descriptive KEY_ROTATE_DISPLAY instead of
 KEY_DIRECTION
Date: Fri, 6 Mar 2015 22:45:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503062244140.26925@pobox.suse.cz>
References: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net> <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de> <cf97f856-7e6d-4753-a3f0-51c410cc2db4@HUB2.rwth-ad.de> <20150306075600.GB14237@dtor-ws> <20150306181508.GF19001@vmdeb7>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48957 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbbCFVp5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Mar 2015 16:45:57 -0500
In-Reply-To: <20150306181508.GF19001@vmdeb7>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-15?Q?Stefan_Br=FCns?= <stefan.bruens@rwth-aachen.de>, linux-input@vger.kernel.org

On Fri, 6 Mar 2015, Darren Hart wrote:

> > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> >=20
> > This should go through HID and platform trees unless I hear otherwi=
se.
>=20
> I'll defer to Jiri on this. Jiri, please feel free to pull the
> drivers/platform/x86 changes through your tree.

Dmitry, as you already merged the patch which aliases KEY_ROTATE_DISPLA=
Y=20
to KEY_DIRECTION, please also take this one so that we avoid unnecessar=
y=20
cross-tree dependencies. Feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

to this one.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
