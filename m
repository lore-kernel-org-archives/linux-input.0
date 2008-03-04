From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 23:25:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803042320450.15209@jikos.suse.cz>
References: <200802161622.43223.linux@dadeos.co.uk> <200803041855.50138.linux@dadeos.co.uk>
 <20080304203822.GF531@sci.fi> <200803042134.30339.linux@dadeos.co.uk>
 <20080304221749.GH531@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-1025804574-1204669522=:15209"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42435 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756689AbYCDWZX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 17:25:23 -0500
In-Reply-To: <20080304221749.GH531@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-1025804574-1204669522=:15209
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Mar 2008, Ville Syrj=E4l=E4 wrote:

> However I don't see why the repeat vs. no repeat case should depend on=20
> the device reporting or not reporting keyboard keys. I don't see any=20
> real connection with a device having some keyboard keys and sending=20
> repeat events for buttons.

The problem is, that currently EV_REP is per-device flag. Once we set it,=
=20
it is valid for all EV_KEY events (which includes keyboard events, but=20
also mouse buttons).

I think it might be good to redesign this a little bit, but I'd like to=20
hear Dmitry's opinion here, let's see when he will appear.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--336216065-1025804574-1204669522=:15209--
