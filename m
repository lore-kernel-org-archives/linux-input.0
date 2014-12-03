From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] input/speaker: additional clicks and tones for future
 accessibility
Date: Wed, 3 Dec 2014 23:57:14 +0100
Message-ID: <20141203225714.GA19950@suse.cz>
References: <20141102001740.eklhad@comcast.net>
 <20141203195811.GB16951@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jablonecka.jablonka.cz ([91.219.244.36]:34485 "EHLO
	jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaLCX2c (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 18:28:32 -0500
Content-Disposition: inline
In-Reply-To: <20141203195811.GB16951@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Karl Dahlke <eklhad@comcast.net>, linux-input@vger.kernel.org

On Wed, Dec 03, 2014 at 11:58:11AM -0800, Dmitry Torokhov wrote:
> Hi Karl,
> 
> On Tue, Dec 02, 2014 at 12:17:40AM -0500, Karl Dahlke wrote:
> > From: Karl Dahlke <eklhad@gmail.com>
> > 
> > Add clicks, tones, and tone sequences to the pc speaker.
> > 
> > The speaker driver can play a tone at a specified frequency,
> > or the standard control G bell,
> > which is a special case of TONE at 1000 hz 0.1 seconds.
> > Add kd_mkpulse() to generate a soft click.
> > This is introduced to support accessibility modules and adapters in the future.
> > It is a means to an end.
> > With this function in place, a module can easily provide soft clicks,
> > i.e. audible feedback, whenever a key is depressed,
> > or when that keystroke is echoed on screen.
> > This allows a blind user, for example, to have rapid feedback while typing,
> > even if he is, at the same time, listening to text that is already on screen.
> > It is faster and more convenient than having characters echoed verbally.
> > And it works all the time, even if speech or braille is not working
> > for whatever reason.
> > 
> > Also add the function kd_mknotes,
> > which plays a series of tones in the background.
> > Of course this can already be done with kd_mksound and timers,
> > but why should everyone reinvent the wheel?
> > It is better to write the function once, properly, in the kernel,
> > and let modules use it thereafter.
> > Again, this is a means to an end.
> > Accessibility modules can generate rapid sequences of notes
> > to indicate various conditions, sometimes error conditions,
> > especially if speech or braille is not working.
> > These notes may be the only feedback the user has to diagnose the problem.
> > This may be useful to other developers in other situations as well.
> > 
> > Finally add kd_mksteps to run something like a chromatic scale,
> > from one frequency to another in specified steps.
> > The half-tone scale, with a step of 6%, starting at middle C, is approximately
> > kd_mksteps(260, 530, 6, 150);
> 
> I have exactly the same response as a year earlier:
> 
> "I do not think it is a good idea to add SND_PULSE as it can be easily
> implemented by SND_TONE with the additional benefit that parameters of
> the click can be adjusted. Also, if clicking is done elsewhere, it would
> work with other speaker drivers besides pcspkr.

SND_PULSE would make sense in case (and only in case) there are devices
that can emit that kind of sound without being able to implement
SND_TONE.

This is the reason why SND_CLICK and SND_BELL exist.

And, by the way, the implementation of SND_PULSE in the patch is quite
horrible. If a variable-width pulse makes sense at all (based on the
speaker dynamics, a long enough pause will be two clicks and high power
consumption inbetween), it should be done by programming the i8253 to do
a one-shot timer rather than bitbanging it.

> [re kd_mknotes] Can it be put into a library instead? Especially given
> David's work on trying to push the VT code out of the kernel. Also, what
> if you want clicks to go through sound card and not the speaker
> interface?"
> 
> In other words, I'd rather have it all be done in userpsace by a daemon
> that listens to all keystrokes and emits notes or clicks or something
> else via whatever sound device is present on the system, be it a PC
> speaker, SPARC speaker, a sound card, or maybe something else.
> 
> Thanks.
> 
> -- 
> Dmitry
> 

-- 
Vojtech Pavlik
Director SUSE Labs
