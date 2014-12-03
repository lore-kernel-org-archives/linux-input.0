From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/speaker: additional clicks and tones for future
 accessibility
Date: Wed, 3 Dec 2014 11:58:11 -0800
Message-ID: <20141203195811.GB16951@dtor-ws>
References: <20141102001740.eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:50189 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaLCT6Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 14:58:16 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so9092276ier.6
        for <linux-input@vger.kernel.org>; Wed, 03 Dec 2014 11:58:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141102001740.eklhad@comcast.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karl Dahlke <eklhad@comcast.net>
Cc: vojtech@ucw.cz, linux-input@vger.kernel.org

Hi Karl,

On Tue, Dec 02, 2014 at 12:17:40AM -0500, Karl Dahlke wrote:
> From: Karl Dahlke <eklhad@gmail.com>
> 
> Add clicks, tones, and tone sequences to the pc speaker.
> 
> The speaker driver can play a tone at a specified frequency,
> or the standard control G bell,
> which is a special case of TONE at 1000 hz 0.1 seconds.
> Add kd_mkpulse() to generate a soft click.
> This is introduced to support accessibility modules and adapters in the future.
> It is a means to an end.
> With this function in place, a module can easily provide soft clicks,
> i.e. audible feedback, whenever a key is depressed,
> or when that keystroke is echoed on screen.
> This allows a blind user, for example, to have rapid feedback while typing,
> even if he is, at the same time, listening to text that is already on screen.
> It is faster and more convenient than having characters echoed verbally.
> And it works all the time, even if speech or braille is not working
> for whatever reason.
> 
> Also add the function kd_mknotes,
> which plays a series of tones in the background.
> Of course this can already be done with kd_mksound and timers,
> but why should everyone reinvent the wheel?
> It is better to write the function once, properly, in the kernel,
> and let modules use it thereafter.
> Again, this is a means to an end.
> Accessibility modules can generate rapid sequences of notes
> to indicate various conditions, sometimes error conditions,
> especially if speech or braille is not working.
> These notes may be the only feedback the user has to diagnose the problem.
> This may be useful to other developers in other situations as well.
> 
> Finally add kd_mksteps to run something like a chromatic scale,
> from one frequency to another in specified steps.
> The half-tone scale, with a step of 6%, starting at middle C, is approximately
> kd_mksteps(260, 530, 6, 150);

I have exactly the same response as a year earlier:

"I do not think it is a good idea to add SND_PULSE as it can be easily
implemented by SND_TONE with the additional benefit that parameters of
the click can be adjusted. Also, if clicking is done elsewhere, it would
work with other speaker drivers besides pcspkr.

...

[re kd_mknotes] Can it be put into a library instead? Especially given
David's work on trying to push the VT code out of the kernel. Also, what
if you want clicks to go through sound card and not the speaker
interface?"

In other words, I'd rather have it all be done in userpsace by a daemon
that listens to all keystrokes and emits notes or clicks or something
else via whatever sound device is present on the system, be it a PC
speaker, SPARC speaker, a sound card, or maybe something else.

Thanks.

-- 
Dmitry
