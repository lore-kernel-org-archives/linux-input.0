From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 5/6] HID: magicmouse: enable Magic Trackpad support
Date: Tue, 31 Aug 2010 13:54:49 -0400
Message-ID: <1283277289.2255.63.camel@mini>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-5-git-send-email-chase.douglas@canonical.com>
	 <1283228806.14419.63.camel@graviton>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:36437 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0HaRyy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 13:54:54 -0400
In-Reply-To: <1283228806.14419.63.camel@graviton>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Tue, 2010-08-31 at 00:26 -0400, Michael Poole wrote:
> On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> > The trackpad speaks a similar, but different, protocol from the magic
> > mouse. However, only small code tweaks here and there are needed to make
> > basic multitouch work.
> > 
> > Extra logic is required for single-touch emulation of the touchpad. The
> > changes made here take the approach that only one finger may emulate the
> > single pointer when multiple fingers have touched the screen. Once that
> > finger is raised, all touches must be raised before any further single
> > touch events can be sent.
> > 
> > Sometimes the magic trackpad sends two distinct touch reports as one big
> > report. Simply splitting the packet in two and resending them through
> > magicmouse_raw_event ensures they are handled properly.
> > 
> > I also added myself to the copyright statement.
> > 
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> I have no technical concerns with the patch, just two questions.  (Once
> I get the chance to test it, I expect to add my Acked-by.)

<snip>
  
> > -		if (report_touches) {
> > -			last_up = 1;
> > -			for (ii = 0; ii < ARRAY_SIZE(msc->touches); ii++) {
> > -				if (msc->touches[ii].down) {
> > -					last_up = 0;
> > -					msc->touches[ii].down = 0;
> > -				}
> > -			}
> > -			if (last_up) {
> > -				input_mt_sync(input);
> > -			}
> > -		}
> > -
> 
> Maybe it is worth making magicmouse_emit_touch() return non-zero if the
> touch is down, so that "last_up" can be accumulated in a single pass
> (and we can remove the "down" field of the touch)?  I think that should
> be a separate commit, if the idea makes sense to you.

That makes sense to me without diving into the code. I don't really have
the time to work on it right now though, so is it ok if these patches
are applied first?

<snip>

> > @@ -388,12 +473,29 @@ static struct feature mouse_features[] = {
> >  	{ { 0xf8, 0x01, 0x32 }, 3 }
> >  };
> >  
> > +static struct feature trackpad_features[] = {
> > +	{ { 0xf1, 0xdb }, 2 },
> > +	{ { 0xf1, 0xdc }, 2 },
> > +	{ { 0xf0, 0x00 }, 2 },
> > +	{ { 0xf1, 0xdd }, 2 },
> > +	{ { 0xf0, 0x02 }, 2 },
> > +	{ { 0xf1, 0xc8 }, 2 },
> > +	{ { 0xf0, 0x09 }, 2 },
> > +	{ { 0xf1, 0xdc }, 2 },
> > +	{ { 0xf0, 0x00 }, 2 },
> > +	{ { 0xf1, 0xdd }, 2 },
> > +	{ { 0xf0, 0x02 }, 2 },
> > +	{ { 0xd7, 0x01 }, 2 },
> > +};
> > +
> 
> As I mentioned in another email, only the last entry here is required to
> turn on multitouch reports.  Do you know what the other entries do?

No clue. I just copied what OS X was sending to the device. It works for
myself and others, so I haven't messed with it.

Thanks,

-- Chase

