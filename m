From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Sun, 1 Feb 2015 21:49:31 -0800
Message-ID: <20150202054931.GB20333@dtor-ws>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
 <201501171101.56430@pali>
 <20150118072245.GA35316@dtor-ws>
 <201501181047.06541@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52891 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbBBFtg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 00:49:36 -0500
Received: by mail-ie0-f178.google.com with SMTP id rd18so6207757iec.9
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2015 21:49:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201501181047.06541@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Vadim Klishko <vadim@cirque.com>

On Sun, Jan 18, 2015 at 10:47:06AM +0100, Pali Roh=E1r wrote:
> On Sunday 18 January 2015 08:22:45 Dmitry Torokhov wrote:
> > On Sat, Jan 17, 2015 at 11:01:56AM +0100, Pali Roh=E1r wrote:
> > > On Thursday 15 January 2015 22:02:16 Dmitry Torokhov wrote:
> > > > On Thu, Jan 15, 2015 at 09:28:41PM +0100, Pali Roh=E1r wrote:
> > > > > On Thursday 15 January 2015 20:38:18 Dmitry Torokhov=20
> wrote:
> > > > > > On Thu, Jan 15, 2015 at 08:19:59PM +0100, Pali Roh=E1r=20
> wrote:
> > > > > > > On Thursday 15 January 2015 19:18:20 Dmitry Torokhov
> > >=20
> > > wrote:
> > > > > > > > On Thu, Jan 15, 2015 at 11:49:32AM +0100, Pali
> > > > > > > > Roh=E1r
> > >=20
> > > wrote:
> > > > > > > > > On Wednesday 14 January 2015 23:55:48 Dmitry
> > > > > > > > > Torokhov
> > > > >=20
> > > > > wrote:
> > > > > > > > > > Hi Pali,
> > > > > > > > > >=20
> > > > > > > > > > This series try to address the issue you
> > > > > > > > > > brought regarding trackstick initialization
> > > > > > > > > > on Dell Latitudes in a different way than the
> > > > > > > > > > patches you proposed. Basically in this
> > > > > > > > > > series we move resetting and all detection in
> > > > > > > > > > alps_detect() and make sure we keep the state
> > > > > > > > > > so alps_init() can reuse it and not perform
> > > > > > > > > > the detection all over again. Doing this
> > > > > > > > > > allows us to set up device characteristics
> > > > > > > > > > (name, version, etc) properly from the get go
> > > > > > > > > > while still performing reset only once.
> > > > > > > > > >=20
> > > > > > > > > > This is untested as I do not have any ALPS
> > > > > > > > > > devices anymore so I'd appreciate you giving
> > > > > > > > > > it a spin.
> > > > > > > > > >=20
> > > > > > > > > > Thanks!
> > > > > > > > >=20
> > > > > > > > > Hi Dmitry,
> > > > > > > > >=20
> > > > > > > > > on top of which branch/repository should I apply
> > > > > > > > > your patches?
> > > > > > > >=20
> > > > > > > > Should be applicable to my 'next' branch (which I
> > > > > > > > just upreved to 3.19-rc4).
> > > > > > > >=20
> > > > > > > > Thanks.
> > > > > > >=20
> > > > > > > Not working at top of next (0c3e994).
> > > > > > >=20
> > > > > > > Applying: Input: ALPS - renumber protocol numbers
> > > > > > > Applying: Input: ALPS - make Rushmore a separate
> > > > > > > protocol error: patch failed:
> > > > > > > drivers/input/mouse/alps.c:1275 error:
> > > > > > > drivers/input/mouse/alps.c: patch does not apply
> > > > > > > Patch failed at 0002 Input: ALPS - make Rushmore a
> > > > > > > separate protocol
> > > > > >=20
> > > > > > Hmm.. I created a new alps branch (based on 3.19-rc4),
> > > > > > can you try it?
> > > > > >=20
> > > > > > Thanks.
> > > > >=20
> > > > > Compiled from your new alps branch (with "if (!priv)"
> > > > > fix) and modprobing psmouse.ko caused laptop freeze :-(
> > > > > Even sysrq not responded. So something is not
> > > > > working...
> > > >=20
> > > > Hmm, is it on text console or in X? Any chance you could
> > > > go through pathes - there are only 8 of them including 2
> > > > of yours that should be unmodified.
> > > >=20
> > > > Thanks.
> > >=20
> > > Hi, now I tested patch by patch and kernel crash is caused
> > > only by last patch 6/6 and only after I touch touchpad or
> > > trackstick.
> > >=20
> > > In text console it prints lot of panic messages and because
> > > it prints lot of messages I cannot read (or record) more
> > > then last.
> > >=20
> > > In last call trace I see that alps_register_bare_ps2_mouse()
> > > was called and it generated page_fault.
> >=20
> > That happens because while you added priv->psmouse pointer it
> > looks like you forgot to initialize it and I missed that
> > too...
> >=20
>=20
> Right your patch 6/6 does not initialize priv->psmouse. I looked=20
> into my original patch and it initialize it, so there was some
> copy-paste error.
>=20
> Look at other emails... can you fix problems and send new version=20
> of your patches for testing?

I think I did. Can you please take another look at my alps branch?

Thanks!

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
