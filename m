From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/4] liss331d1: accelerometer driver
Date: Wed, 14 Apr 2010 23:37:23 +0100
Message-ID: <20100414233723.25da5af0@linux.intel.com>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
	<20100414125155.23181.56610.stgit@localhost.localdomain>
	<4BC63DC5.8040501@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BC63DC5.8040501-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?w4lyaWM=?= Piel <E.A.B.Piel-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> I wouldn't want to be too picky, if this driver works fine with your
> hardware and it's tested, why not, but from looking at the spec of
> this chip (and at the code of this driver), it looks like it could be
> completely compatible with the lis3lv02d driver (with lis3lv02d_i2c).
> Same registers, including the WHO_AM_I register which returns 0x3B
> (which is a supported version).

I will take a look in detail. The IRQ bit is different and as you say
the retries can be added to it anyway.

> 
> Have you tried and there were some specific incompatibilities? 

I am picking this project up rather than being directly responsible for
its history - chances are nobody has.

Alan
