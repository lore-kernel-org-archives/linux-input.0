From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 15:47:51 +0200
Message-ID: <20080304134751.GA531@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi> <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:60504 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYCDNrw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 08:47:52 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 04, 2008 at 02:20:19PM +0100, Jiri Kosina wrote:
> On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:
>=20
> > > The attached patch reconfigures the ati_remote2 driver to use sof=
t-autorepeat=20
> > > functionality and adds support for loadable key maps.
> > Why was this submitted (and even accepted) without cc:ing me?
>=20
> I don't seem to see you in MAINTAINERS entry, so that's probably why =
you=20
> didn't receive confirmation when Andrew has put this patch into -mm.

I guess MODULE_AUTHOR() isn't enough then. I'll send a patch for
MAINTAINERS.

> Merging into -mm doesn't mean that the patch is accepted at all, it j=
ust=20
> exposes it for wider audience for feedback and testing.
>=20
>=20
> With respect to autorepeat -- I think that the easiest solution would=
 be=20
> registering two separate input devices, one for keyboard and one for=20
> mouse, and perform the switching in the driver, depending on the type=
 of=20
> received events.

Hmm. IIRC I had one USB mouse which also sent repeat events and the
driver didn't seem to filter them out which is why I added checks to
DirectFB's input driver to filter them in user space. Was that a bug
in the usbhid driver or does it depend on the actual hardware? I still
have that mouse so I can re-test the behavior if needed. I guess the
only issue with registering two input devices whould be that user space
might need some way to tell that they are really part of the same
remote.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
