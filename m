From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: Sensor event related attribute naming.
Date: Fri, 12 Nov 2010 15:34:36 +0530
Message-ID: <7BC12C510D794F198DFA5A5C104CD7B6@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35891 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab0KLKG2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 05:06:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, drivers@analog.com, achew@nvidia.com, Donggeun Kim <dg77.kim@samsung.com>, Dmitry Torokhov <dtor@mail.ru>

----- Original Message ----- 
From: "Hemanth V" <hemanthv@ti.com>
To: "Jonathan Cameron" <jic23@cam.ac.uk>; "Dmitry Torokhov" <dtor@mail.ru>


> ----- Original Message ----- 
> From: "Jonathan Cameron" <jic23@cam.ac.uk>
> To: "Jonathan Cameron" <jic23@cam.ac.uk>
> Sent: Thursday, September 30, 2010 3:36 PM
> Subject: Re: Sensor event related attribute naming.
>
>
>> Given the lack of further comment, I went ahead and implemented the above 
>> naming
>> scheme for IIO. As the above discussion with Hemanth shows, there are 
>> some corner cases
>> that will need futher thought in the future.
>>
>
> Jonathan, haven't seen many comments on this. Do u think the reason
> might be that these interfaces are hidden behind a HAL layer like in 
> android and
> might not be a burning issue for many people.
>

Dmitry, could you let us know your thoughts on this too.
Would using a HAL layer be better compared to creating a standard
sysfs interface, as it seems to be the popular approach.

Thanks
Hemanth 

