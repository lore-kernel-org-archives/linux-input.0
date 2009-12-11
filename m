From: Steven King <sfking@fdwdc.com>
Subject: Re: [PATCH][input] add Honeywell hmc5843 3-Axis Magnetometer (digital compass)  driver.
Date: Fri, 11 Dec 2009 14:26:53 -0800
Message-ID: <200912111426.54186.sfking@fdwdc.com>
References: <200912102250.12853.sfking@fdwdc.com> <4B223EE4.5010203@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n10.bullet.mail.mud.yahoo.com ([209.191.125.208]:46429 "HELO
	n10.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762885AbZLKW0x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 17:26:53 -0500
In-Reply-To: <4B223EE4.5010203@cam.ac.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for taking at look at it.

On Friday 11 December 2009 04:45:24 Jonathan Cameron wrote:
> Dear Steven,
>
> Mostly looks good to me.  Couple of minor comments inline below.
>
> I'd also like to see some documentation for this chip.  We don't really
> want people to have to read the data sheet in order to find out what the
> various modes and frequency settings are for example. Datasheets have
> a nasty habit of disappearing in the long run.  Probably needs something
> in Documentation directory rather than merely comments in the code.

Yeah, thats on my todo list, but I thought I should post the bare driver to 
get some feedback before I got too far along...

> Only one I'm really fussy about is making sure you use the unsigned
> strict_strtoul where appropriate.  Fix that and you can add
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Doh! I had originally used strict_strtoul, then for some reason I can't 
remember (probably caffeine deprivation) I changed them.  Thanks for catching 
that.

> I'm not entirely convinced this one should be in input as I can't really
> believe it is commonly used as an input device?  Over to Dmitry and others
> for that though.   We can always move it at a later date. The requirements
> of a chip this simple (interface wise) would make that trivial.

I wasn't sure either; currently, the only use I'm familiar with is to combine 
the magnetometer with an accelerometer to create a tilt compensated digital 
compass.  In practice, the raw data needs some massaging to be usefull, so 
the plan is to have a daemon that collects the inputs from the accelerometer 
and the magnetometer and does the processing and apps would talk to it, so 
I'm not fixated on any particular interface.

Anyway, I'll cobble together something for Documentation/input/ (for now) and 
fix those strict_strtol (and the ints) and respin the patch.

Thanks,
-- 
Steven King -- sfking at fdwdc dot com

