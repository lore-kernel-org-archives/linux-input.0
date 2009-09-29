From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: keypad input method question
Date: Tue, 29 Sep 2009 11:30:24 +0200
Message-ID: <20090929113024.6f006e25.kristoffer.ericson@gmail.com>
References: <3ea34a000909250601n5127dd2bt6a84aab7a93c26ed@mail.gmail.com>
	<20090928170240.GE21455@core.coreip.homeip.net>
	<3ea34a000909281242h5b7702cbt8005b100f58bee9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:38934 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbZI2J1p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2009 05:27:45 -0400
Received: by bwz6 with SMTP id 6so1848364bwz.37
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2009 02:27:47 -0700 (PDT)
In-Reply-To: <3ea34a000909281242h5b7702cbt8005b100f58bee9c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Friedt <chrisfriedt@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 28 Sep 2009 21:42:55 +0200
Christopher Friedt <chrisfriedt@gmail.com> wrote:

> Hi Dimitry,
> 
> Thanks for the reply!

Please resend with patch inside email (pasted) since its alot easier
to comment on code that way.

> 
> On Mon, Sep 28, 2009 at 7:02 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Just post in on the mailing list (and mark that it is for initial
> > review).
> 
> My patch is here [1]. There are some obvious sections to remove - for
> one, declaring a massive static array of string <-> register
> combinations that I was using to debug before I discovered i2c-dev /
> i2c-utils. I also need to properly unregister the input device when
> rmmod is called, and cancel any pending work. It was giving me a
> kernel panic when I tried that before, so I just commented that part
> out (very bad, i know), so every time the module is inserted it
> creates a new input device without entirely removing the previous one.
> Also, because I'm using bitmaps for the actual pin configuration, it
> might make it tricky for big-endian systems.
> 
> Regarding the keypad complexity ...
> 
> > ... nothing stops userspace from accessing
> > the device through both inetrfaces (evdev and legacy one) at the same
> > time.
> >
> > It would be curious to see what kind of keypad you have.
> 
> There is an image of the keypad here [2]. The alpha key cycles through
> 3 states: 0=numbers, 1=lowercase, 2=uppercase. The keys also respond
> to multi-tap, so hitting the '2' key twice would result in 'b' when
> alpha=1. The way I implemented multi-tap was to use a state machine &
> timer, and send a backspace followed by the next logical key, if the
> timer had not expired first. Aside from the alpha key, there's also
> the 'fn' modifier key, which would generate e.g. pageup when fn, then
> up, were pressed. I currently also don't support holding buttons down,
> simply because it's a bit clumsy with small keypads like this. All of
> the modifier keys work on a sequential basis, not a combinatorial
> basis.
> 
> This keypad driver can obviously be done in userspace just as well as
> kernel space, but would require a special driver in that case too...
> unless you can suggest some magical keycode-scanning method. I did
> think about using alpha-states to encode numlock & capslock, so in
> that case there might only be one actual modifier key. Also, it's
> possible to have a userspace driver change the keycode-mapping for
> multi-tap and issue backspaces as appropriate... so that is one
> possibility for a keycode-scanning method, but again, I'm not really
> sure where to start with that for X ... or Android (yet). It works
> fine in X and on the console right now, but I think I'll need to
> implement a userspace driver for Android because the lack of a
> keycode-scanning feature makes webkit crash.
> 
> Of course, it's only _my_ keypad that is so complicated - the
> complexity of the keypad is entirely independent from the stmpe2401
> driver. The device is capable of reporting 2 simultaneous button
> presses, or 3 if dedicated keys are also used, but I'm currently only
> reporting one at a time with the initial driver, just to make life
> easier.
> 
> Please feel free to give me as much constructive criticism as you wish :)
> 
> C
> 
> [1] http://virta.visibleassets.com/~cfriedt/cl/kernel/stmpe2401-20090923.patch
> [2] http://virta.visibleassets.com/~cfriedt/cl/keypad-28.jpg
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
