From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HowTo write a driver for 2 multiplexed PS/2 ports over 1 UART?
Date: Sun, 19 Apr 2009 17:48:31 -0700
Message-ID: <200904191748.32287.dmitry.torokhov@gmail.com>
References: <1239861274.29831.118.camel@linux-51e8.site> <20090418234559.GD32346@dtor-d630.eng.vmware.com> <49EAF729.2010603@denx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:54796 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZDTAsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Apr 2009 20:48:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1640775rvb.1
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2009 17:48:39 -0700 (PDT)
In-Reply-To: <49EAF729.2010603@denx.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hs@denx.de
Cc: linux-input@vger.kernel.org

Hi Heiko,

On Sunday 19 April 2009 03:04:25 Heiko Schocher wrote:
> Hello Dmitry,
>
> Dmitry Torokhov wrote:
> >
> > You need to create 2 serio ports in your driver and have it send data
> > into appropriate port, depending on what device it came from. If you
> > take a look at i8042 driver it does exactly that. We have 1 serio port
> > for keyboard and eithe 1 or 4 AUX serio ports. In i8042_interrupt we
> > check the status bit to figure to which serio port incoming byte should
> > be routed and act accordingly.
>
> Ah, thanks for this hint :-)
>
> OK, so I have to write a serial driver for the uart on my hardware,
> and add this in drivers/serio, right?
>
> Hmm.. spontaneous I think (maybe it is a bad thought), what do you
> think to the following approach:
>
> I didn;t want to write a new serio driver for my uart (mpc5200 internal
> PSC Uart), because there is a working tty driver for this, and the multi-
> plexing functionality is just a protocoll ... so I think of using
> the drivers/serio/serport.c and add this "multiplexing" functionality
> to the serport.c driver ... is this worth about to think?
>
> this should be a more general approach then writting a special serial
> driver for "my" UART ... what do you think?
>

Yes, this is definitely better solution. I did not realize that there
was a working driver for your UART. It would be best if your solution
extended (and was compatible with) current N_MOUSE line discipline.

-- 
Dmitry
