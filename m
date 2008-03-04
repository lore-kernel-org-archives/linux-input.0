From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 21:42:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803042138050.15209@jikos.suse.cz>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi>
 <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi>
 <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz> <20080304184004.GC531@sci.fi>
 <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz> <20080304195320.GD531@sci.fi>
 <Pine.LNX.4.64.0803042126360.15209@jikos.suse.cz> <20080304203212.GE531@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-903827204-1204663342=:15209"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40136 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751864AbYCDUmX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 15:42:23 -0500
In-Reply-To: <20080304203212.GE531@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-903827204-1204663342=:15209
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:

> > Actually, this is the very same issue we discussed with respect to=20
> > ati_remote2 changes ... this device has Keyboard usages as well as=20
> > Mouse/Pointer. As we set the EV_REP (because of the Keyboard usage),=20
> > this inputdevice-wide flag applies also to the mouse button events and=
=20
> > they get repeated.
> Except this device does actually register two input devices since the
> endpoints for the keyboard and mouse are separate, and here it even
> makes sense since they are physically separate devices.

Yes, but unfortunately both interfaces contain Keyboard usage in their=20
report descriptor -- please see the debug output you sent me. The first=20
interface's descriptor states to send Keyboard usages in Field(1) of INPUT=
=20
report, the second one presents it in Field(1) of INPUT[1] report.

I guess that one of the report descriptors contains redundant information,=
=20
not both interfaces are actually sending Keyboard/Consumer/etc events,=20
right?

The possibility for this particular device might be fixing the report=20
descriptor on the fly, before it enters the parser. We do it for certain=20
broken HID devices already.

--=20
Jiri Kosina
SUSE Labs
--336216065-903827204-1204663342=:15209--
