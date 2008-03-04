From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 23:02:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803042300280.15209@jikos.suse.cz>
References: <20080304124715.GK8473@sci.fi> <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz>
 <20080304134751.GA531@sci.fi> <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz>
 <20080304184004.GC531@sci.fi> <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz>
 <20080304195320.GD531@sci.fi> <Pine.LNX.4.64.0803042126360.15209@jikos.suse.cz>
 <20080304203212.GE531@sci.fi> <Pine.LNX.4.64.0803042138050.15209@jikos.suse.cz>
 <20080304212105.GG531@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-1308092479-1204668159=:15209"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:41996 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754771AbYCDWCl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 17:02:41 -0500
In-Reply-To: <20080304212105.GG531@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-1308092479-1204668159=:15209
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:

> I've used the device so little that I honestly didn't even notice that=20
> the mouse claims to support pretty much every kind of event there is.=20
> Maybe they were just lazy when making this device and didn't want to=20
> think about the actual features of the device and instead just added=20
> every possible thing to the descriptors.

Exactly. We could either fix the report descriptor upon initialization, or=
=20
put some quirk into event handler, that will make sure that the mouse=20
buttons won't get repeated for this particular device.

--=20
Jiri Kosina
SUSE Labs
--336216065-1308092479-1204668159=:15209--
