From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input: mt: Add pressure to pointer emulation code
Date: Tue, 30 Nov 2010 01:09:34 -0800
Message-ID: <20101130090934.GC3952@core.coreip.homeip.net>
References: <1291014802-17061-1-git-send-email-rydberg@euromail.se>
 <1291014802-17061-5-git-send-email-rydberg@euromail.se>
 <20101129094715.GA9303@core.coreip.homeip.net>
 <4CF38C67.20509@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CF38C67.20509@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 29, 2010 at 12:20:07PM +0100, Henrik Rydberg wrote:
> >> @@ -124,9 +125,13 @@ void input_mt_report_pointer_emulation(struct input_dev
> *dev)
> 
> >>  	if (oldest) {
> >>  		int x = input_mt_get_value(oldest, ABS_MT_POSITION_X);
> >>  		int y = input_mt_get_value(oldest, ABS_MT_POSITION_Y);
> >> +		int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
> > 
> > What if device does not report ABS_MT_PRESSURE/ABS_PRESSURE? Do we rely
> > on input core to suppress unsupported events? A comment would be nice...
> 
> 
> Yes, the setup values are the only ones producing output here. How about this
> addition to the function text: "The input core ensures only the KEY and ABS axes
> already setup for this device will produce output."?

Yep, that works.

> 
> > Also, is there a gelper to set up pointer emulation capabilities for MT
> > device?
> 
> 
> This is certainly the plan with time, but currently it seemed best to leave the
> rest of the event setup code untouched.
> 

OK, just throwing ideas around ;)

-- 
Dmitry
