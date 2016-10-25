From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: tca8418_keypad: hide gcc-4.9 -Wmaybe-uninitialized warning
Date: Tue, 25 Oct 2016 11:59:22 +0200
Message-ID: <3580924.2eqYJQ5Dgh@wuerfel>
References: <20161024153222.2738294-1-arnd@arndb.de> <20161024234513.GA15034@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:61328 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933920AbcJYJ70 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Oct 2016 05:59:26 -0400
In-Reply-To: <20161024234513.GA15034@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, October 24, 2016 4:45:13 PM CEST Dmitry Torokhov wrote:
> > diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> > index 9002298698fc..3048ef3e3e16 100644
> > --- a/drivers/input/keyboard/tca8418_keypad.c
> > +++ b/drivers/input/keyboard/tca8418_keypad.c
> > @@ -164,11 +164,18 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
> >       int error, col, row;
> >       u8 reg, state, code;
> >  
> > -     /* Initial read of the key event FIFO */
> > -     error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
> > +     do {
> > +             error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
> > +             if (error < 0) {
> > +                     dev_err(&keypad_data->client->dev,
> > +                             "unable to read REG_KEY_EVENT_A\n");
> > +                     break;
> > +             }
> > +
> > +             /* Assume that key code 0 signifies empty FIFO */
> > +             if (reg <= 0)
> > +                     break;
> 
> I am unconvinced that this rearrangement fixes the issue for all older
> GCCs. Can we simply do:
> 
>         u8 uninitialized_var(reg);
> 
> and be done with it?

Yes, that would work. However:

- avoiding the fake intialization tends to produce better object
  code, as gcc actually knows what's going on
- Linus doesn't like uninitialized_var() and would rather see it
  removed from the kernel
- llvm produces warnings for uninitialized_var()

I have checked gcc-4.6/4.7/4.8/4.9/5.x/6.x, and only gcc-4.9
produces the warning. 4.9 changed the detection for uninitialized
variables significantly, which generally caused fewer false
positives but unfortunately introduced a couple of new ones
like this.

	Arnd
