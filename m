From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Mon, 18 Oct 2010 16:48:30 -0700
Message-ID: <201010181648.30715.dmitry.torokhov@gmail.com>
References: <4CBC6D60020000230002205C@novprvlin0050.provo.novell.com> <AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com> <20101018092346.GA19058@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56875 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab0JRXsl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 19:48:41 -0400
In-Reply-To: <20101018092346.GA19058@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Monday, October 18, 2010 02:23:46 am Matthew Garrett wrote:
> On Mon, Oct 18, 2010 at 10:19:37AM +0200, Corentin Chary wrote:
> > But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
> > Then bind it to XF86XK_TouchpadToggle (what's the right way to do that
> > ? keymaps ?)
> 
> Yeah, we can add it to the X evdev map. That's not a problem. The only
> problem I see is that we don't have a good semantic definition - some
> machines send a toggle keycode, whereas others send on/off. That
> wouldn't in itself be a problem, but sometimes that's accompanied by the
> touchpad being disabled by the BIOS. In the latter case we probably
> don't want to map it, since the BIOS can do it anyway, but there's an
> argument that we need some way to expose that to userspace.

Well, unsurprisingly, this mirrors the case with RF switches and hotkeys.

-- 
Dmitry
