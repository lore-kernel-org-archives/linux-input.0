From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] add ad714x platform_data
	definition
Date: Tue, 1 Sep 2009 18:57:37 -0700
Message-ID: <200909011857.37755.david-b@pacbell.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<1251777330-16994-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1251777330-16994-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Monday 31 August 2009, Barry Song wrote:
> --- /dev/null
> +++ b/include/linux/spi/ad714x.h

Doesn't belong under SPI since this is also used by the
I2C version of the chip.  Likely include/linux/input/*h
is best.


> @@ -0,0 +1,60 @@
> +/*
> + * include/linux/ad714x.h

Never include the directories.  And the coding style says
this should have a twitter-sized description of the driver
in that line, like

   * ad714x.h -- platform data for capacitance sensor driver

It's good policy to include a brief GPL statement at the top
of every source file too, including a Copyright (C) you.


> + *
> + * AD714x is very flexible, it can be used as buttons, scrollwheel,
> + * slider, touchpad at the same time. That depends on the boards.
> + * The platform_data for the device's "struct device" holds this
> + * information.
> + */
> +
> +
> +#ifndef AD714X_HW_H
> +#define AD714X_HW_H

As noted:  __LINUX_INPUT_AD714X_H is the style to use here.


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
