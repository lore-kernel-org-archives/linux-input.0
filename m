From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add LED_0..LED_15 define
Date: Sun, 12 Feb 2017 17:31:55 -0800
Message-ID: <20170213013155.GC528@dtor-ws>
References: <20170208004141.30540-1-me@paulo.costa.nom.br>
 <CAKdAkRSL1uqCTbyX8Wmh+DA=vs6nmOCU-F88Ceizh7acOf=SNw@mail.gmail.com>
 <CADbEYbncQyFLg7Jq3pGBc2JfOh+2H6FYZ+XPRjnZEcEm7uVVtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33408 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdBMBb6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 20:31:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so8291328pgd.0
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2017 17:31:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADbEYbncQyFLg7Jq3pGBc2JfOh+2H6FYZ+XPRjnZEcEm7uVVtQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paulo Costa <me@paulo.costa.nom.br>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Feb 12, 2017 at 11:03:03PM -0200, Paulo Costa wrote:
> 2017-02-10 22:54 GMT-02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > Hi Paulo,
> >
> > On Tue, Feb 7, 2017 at 4:41 PM, Paulo Costa <me@paulo.costa.nom.br> wrote:
> >> Some input devices have many controllable leds that don't fit any standard function (e.g., the Wiimote has 4 controllable LEDs)
> >>
> >> Just as we have BTN_0..BTN_9 for generic buttons, LED_0...LED_15 can now be used to control generic leds.
> >
> > Generic LEDs should use LED subsystem; we are not going to be adding
> > more LED definitions to input.
> >
> > Thanks.
> >
> > --
> > Dmitry
> 
> Hello, Dmitry,
> 
> IMHO, whenever those leds are part of a bigger input device,
> using EV_LED makes more sense.
> 
> But it's your call, thanks for looking into it.

Yes, we even re-exported the "original" input LEDs as "standard" LEDs.
Other drovers are also using "standard" LEDs - xpad.c, etc.

Thanks.

-- 
Dmitry
