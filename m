From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] Input: synaptics - add multi-finger and semi-mt
 support
Date: Tue, 21 Dec 2010 19:36:48 +0100
Message-ID: <20101221183648.GA1874@polaris.bitmath.org>
References: <1292852364-19127-1-git-send-email-rydberg@euromail.se>
 <1292852364-19127-3-git-send-email-rydberg@euromail.se>
 <4D10D75D.80400@canonical.com>
 <20101221165956.GA28702@polaris.bitmath.org>
 <AANLkTi=rxBMDB+JKLY9A4iMZEtCBGNhfJxAERMb4CEjR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=rxBMDB+JKLY9A4iMZEtCBGNhfJxAERMb4CEjR@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > Yes - the MT_TOOLs are only emitted when explicitly set in absbit, but
> > the internal interface always handles it. This is actually documented
> > in the code (and DocBook).
> 
> That note is good guidance for developer side.  Its also worth noting
> on app side that MT_TOOL_FINGER is a little special since its value is
> 0.  In most common case, I think it will get filtered out where as
> BTN_TOOL_FINGER will always be sent.
> 
> Since we can't yet query per slot ABS_MT_TOOL_TYPE, I guess apps have
> to just assume its a finger unless told otherwise?

Yes - but this is actually done for every ABS value already, so it
just follows the standard transfer method.

Thanks,
Henrik
