From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/4] liss331d1: accelerometer driver
Date: Thu, 15 Apr 2010 11:02:32 +0100
Message-ID: <20100415110232.7fc80ac1@linux.intel.com>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
	<20100414125155.23181.56610.stgit@localhost.localdomain>
	<4BC63DC5.8040501@tudelft.nl>
	<4BC6EA64.4070308@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BC6EA64.4070308-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: =?UTF-8?B?w4lyaWM=?= Piel <E.A.B.Piel-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> Err. Anyone get a feeling of deja vu here?
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-September/026706.html
> 
> When Kalhan originally posted this driver it was pointed out that it
> was compatible with the existing one.  A complete lack of
> communications lead to Kalhan (and someone else, might have been Eric
> or Samu, can't recall) both implementing i2c support in the driver.
> Can't find it right now but I'm fairly sure Kahlan reported that
> worked fine for this chip as well?
> 
> So looks like a lack of communications here and that Alan has picked
> up an unnecessary driver.

Thanks it does indeed - except for the retry logic which has come from
another platform source and can be submitted in turn. Only other thing I
see odd is that the existing driver prints a scary error message when
there is no IRQ rather than just an info message.

Alan
