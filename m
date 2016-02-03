From: Chris Diamand <chris@diamand.org>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Wed, 3 Feb 2016 08:58:16 +0000
Message-ID: <20160203085816.GA3307@smaug>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
 <20160203004153.GA15147@smaug>
 <CAHc7Qt3cMu4+qXvruXtY7-GxL=skaUda1c4bfA5DDdNMfOfKGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37544 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcBCI6U (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2016 03:58:20 -0500
Received: by mail-wm0-f51.google.com with SMTP id l66so59488774wml.0
        for <linux-input@vger.kernel.org>; Wed, 03 Feb 2016 00:58:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHc7Qt3cMu4+qXvruXtY7-GxL=skaUda1c4bfA5DDdNMfOfKGg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Pospesel <pospeselr@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Richard,

> Reporting absolute position allows the synaptics and libinput xorg drivers
> to treat the BYD touchpad as a touchpad, rather than a mouse.  This allows
> edge scrolling, tap to click, natural scrolling and any other location
> based single touch gesture to work.
>
> I opted to completely disable the hardware multitouch gesture recognition
> (including two finger scroll) for a couple of reasons:
>
> 1.  time delta between gesture packets was very large resulting in a rather
> jerky scrolling experience, especially compared to touchpad with real
> multitouch reporting.
> 2.  Reporting absolute position and touch support enables the users to
> configure the touchpad in the touchpad settings section of gnome, cinnamon,
> etc because those applets configure synaptics and libinput.  Otherwise xorg
> thinks it's just a mouse.

This all sounds good - I look forward to trying your patch!

Also, how did you figure out how to enable the absolute packets? I couldn't
find anything like that with the Windows driver I was using.

> 3.  Enabling multitouch gesture recognition results in the mouse cursor
> freezing up when the user uses two fingers, one to move the mouse cursor
> and another to click.  This is because movement packets stop getting sent
> while a gesture (such as pinch, rotate, etc) is being detected and/or
> reported.

So with your patch, how will this gesture work, if it can only recognise one
finger at a time? I guess you'd have to enable the "double-tap then drag"
thing in synaptics and use that?

> Disabling all hardware gesture detection, including two finger
> scroll, provides the most fluid user experience.

Yep, I agree that if it works, good one-finger scrolling would be much better
than the touchpad's internal gesture recognition.

> Regarding serio_pause_rx(), I was following a pattern similar to another
> touchpad driver in psmouse.  That whole callback mechanism is required to
> report the touch had ended, since the BYD hardware only sends packets when
> a touch is occurring.  Is there a better way?

You're right, actually - I was worried that the input_report_* functions might
sleep, but I just had a proper look and they don't.

> I'll try to rebase and post an updated patch tonight.

Cheers!
Chris
