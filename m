From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] use more descriptive KEY_ROTATE_DISPLAY instead of
 KEY_DIRECTION
Date: Fri, 6 Mar 2015 16:34:24 -0800
Message-ID: <20150307003424.GA26151@dtor-ws>
References: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
 <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de>
 <cf97f856-7e6d-4753-a3f0-51c410cc2db4@HUB2.rwth-ad.de>
 <20150306075600.GB14237@dtor-ws>
 <20150306181508.GF19001@vmdeb7>
 <alpine.LNX.2.00.1503062244140.26925@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38631 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbbCGAea (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 19:34:30 -0500
Received: by iecrl12 with SMTP id rl12so7231810iec.5
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 16:34:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503062244140.26925@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Darren Hart <dvhart@infradead.org>, Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>, linux-input@vger.kernel.org

On Fri, Mar 06, 2015 at 10:45:52PM +0100, Jiri Kosina wrote:
> On Fri, 6 Mar 2015, Darren Hart wrote:
>=20
> > > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > >=20
> > > This should go through HID and platform trees unless I hear other=
wise.
> >=20
> > I'll defer to Jiri on this. Jiri, please feel free to pull the
> > drivers/platform/x86 changes through your tree.
>=20
> Dmitry, as you already merged the patch which aliases KEY_ROTATE_DISP=
LAY=20
> to KEY_DIRECTION, please also take this one so that we avoid unnecess=
ary=20
> cross-tree dependencies. Feel free to add
>=20
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
