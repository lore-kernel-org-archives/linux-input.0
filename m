From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Mon, 18 Oct 2010 10:23:46 +0100
Message-ID: <20101018092346.GA19058@srcf.ucam.org>
References: <4CBC6D60020000230002205C@novprvlin0050.provo.novell.com> <20101018081218.GA8655@core.coreip.homeip.net> <AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 18, 2010 at 10:19:37AM +0200, Corentin Chary wrote:

> But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
> Then bind it to XF86XK_TouchpadToggle (what's the right way to do that
> ? keymaps ?)

Yeah, we can add it to the X evdev map. That's not a problem. The only 
problem I see is that we don't have a good semantic definition - some 
machines send a toggle keycode, whereas others send on/off. That 
wouldn't in itself be a problem, but sometimes that's accompanied by the 
touchpad being disabled by the BIOS. In the latter case we probably 
don't want to map it, since the BIOS can do it anyway, but there's an 
argument that we need some way to expose that to userspace.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
