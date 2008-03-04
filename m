From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 14:20:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-77326895-1204636819=:18589"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:35858 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758137AbYCDNUa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 08:20:30 -0500
In-Reply-To: <20080304124715.GK8473@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-77326895-1204636819=:18589
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:

> > The attached patch reconfigures the ati_remote2 driver to use soft-auto=
repeat=20
> > functionality and adds support for loadable key maps.
> Why was this submitted (and even accepted) without cc:ing me?

I don't seem to see you in MAINTAINERS entry, so that's probably why you=20
didn't receive confirmation when Andrew has put this patch into -mm.

Merging into -mm doesn't mean that the patch is accepted at all, it just=20
exposes it for wider audience for feedback and testing.


With respect to autorepeat -- I think that the easiest solution would be=20
registering two separate input devices, one for keyboard and one for=20
mouse, and perform the switching in the driver, depending on the type of=20
received events.

--=20
Jiri Kosina
SUSE Labs

---1747641777-77326895-1204636819=:18589--
