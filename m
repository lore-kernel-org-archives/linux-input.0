From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Sensor event related attribute naming.
Date: Fri, 12 Nov 2010 09:32:28 -0800
Message-ID: <20101112173227.GB1224@core.coreip.homeip.net>
References: <7BC12C510D794F198DFA5A5C104CD7B6@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58907 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0KLRck (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 12:32:40 -0500
Content-Disposition: inline
In-Reply-To: <7BC12C510D794F198DFA5A5C104CD7B6@wipblrx0099946>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, drivers@analog.com, achew@nvidia.com, Donggeun Kim <dg77.kim@samsung.com>

On Fri, Nov 12, 2010 at 03:34:36PM +0530, Hemanth V wrote:
> ----- Original Message ----- From: "Hemanth V" <hemanthv@ti.com>
> To: "Jonathan Cameron" <jic23@cam.ac.uk>; "Dmitry Torokhov" <dtor@mail.ru>
> 
> 
> >----- Original Message ----- From: "Jonathan Cameron"
> ><jic23@cam.ac.uk>
> >To: "Jonathan Cameron" <jic23@cam.ac.uk>
> >Sent: Thursday, September 30, 2010 3:36 PM
> >Subject: Re: Sensor event related attribute naming.
> >
> >
> >>Given the lack of further comment, I went ahead and implemented
> >>the above naming
> >>scheme for IIO. As the above discussion with Hemanth shows,
> >>there are some corner cases
> >>that will need futher thought in the future.
> >>
> >
> >Jonathan, haven't seen many comments on this. Do u think the reason
> >might be that these interfaces are hidden behind a HAL layer like
> >in android and
> >might not be a burning issue for many people.
> >
> 
> Dmitry, could you let us know your thoughts on this too.
> Would using a HAL layer be better compared to creating a standard
> sysfs interface, as it seems to be the popular approach.
> 

Hemanth,

I do not really see the difference between sysfs interface and HAL
interface. They both abstract hardware details and bring them to common
denominator. If you guys can agree on HAL interface I trust sysfs should
be possible too ;)

BTW, the reason I do not comment on sysfs accelerometer infrastructure
is because it is not topic I am vested in, my time budget barely covers
pure input matters. So as long as there is something that is common and
shared between drivers I would be good with it; you guys need to decide
on details, please.

Thanks.

-- 
Dmitry
