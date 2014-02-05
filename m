From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH 2/5] Port hid-lg4ff to ff-memless-next
Date: Wed, 05 Feb 2014 10:35:33 +0100
Message-ID: <7140464.ckcuvrghVW@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <63cea0aa616907d1186526ea155ff1d0.squirrel@mungewell.org> <CADbOyBSXKvRpTB-3NezDhFwggrD7i7qS9e6Aa4JWUe_BynVH3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:40321 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaBEJfl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Feb 2014 04:35:41 -0500
In-Reply-To: <CADbOyBSXKvRpTB-3NezDhFwggrD7i7qS9e6Aa4JWUe_BynVH3g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Wednesday 05 of February 2014 09:41:16 you wrote:
> On Wed, Feb 5, 2014 at 1:08 AM, <simon@mungewell.org> wrote:
> > > Ahh... please disregard this. 2/5 should have the same fix for zero
> > > force
> > > as
> > > we have right now - it should effectively stop the effect when the force
> > > is zero.
> > 
> > Hi,
> > We need to think carefully on this as a '+10' combined with '-10' force
> > will result in '0'; however we do not want to deactivate the wheel
> > (no-resistance mode) as this will result in 'ticking' on the wheel as
> > force transitions through 0.... ideally we'd need to know that there are
> > no forces set.
> 
> No problem Simon, this is thought about:
> If forces are active, and they cancel out, hid_lg4ff_start_combined is
> called with 0 force (scaled_x = 0x80), instead of hid_lg4ff_stop_combined
> as you assumed.

Okay, so to set things straight: I should modify to patch to send 0x13 when 
the effect is fully stopped and use 0x11 0x80 to only zeroize the force when 
the overall force is zero? My DFP doesn't differentiate between these states 
so I cannot tell what is the right thing to do.

Michal
