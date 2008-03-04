From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 15:01:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi>
 <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-1955659092-1204639304=:15209"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:55582 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751524AbYCDOBp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 09:01:45 -0500
In-Reply-To: <20080304134751.GA531@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-1955659092-1204639304=:15209
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:

> > I don't seem to see you in MAINTAINERS entry, so that's probably why yo=
u=20
> > didn't receive confirmation when Andrew has put this patch into -mm.
> I guess MODULE_AUTHOR() isn't enough then. I'll send a patch for
> MAINTAINERS.

I don't know the exact algorithm Andrew uses to send out CCs when patch is=
=20
merged, but MAINTAINERS entry would definitely help.

> Hmm. IIRC I had one USB mouse which also sent repeat events and the=20
> driver didn't seem to filter them out which is why I added checks to=20
> DirectFB's input driver to filter them in user space. Was that a bug in=
=20
> the usbhid driver or does it depend on the actual hardware? I still have=
=20
> that mouse so I can re-test the behavior if needed.=20

Button events from mice definitely shouldn't be auto-repeated, if they are=
=20
reported probably by the hardware (i.e. HID_UP_BUTTON usage page,=20
MOUSE/POINTER application).

If you could recompile your kernel with CONFIG_HID_DEBUG, modprobe the=20
'hid' module with 'debug=3D1' parameter, and send me the output that appear=
s=20
in kernel log when you press (and hold) the button, I will look into it.

--=20
Jiri Kosina
SUSE Labs
--336216065-1955659092-1204639304=:15209--
