From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] Add Input IOCTL for accelerometer devices
Date: Sat, 16 May 2009 15:50:40 +0300
Message-ID: <20090516125040.GA13146@nokia.com>
References: <20090515131636.GE4443@nokia.com> <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com> <45cc95260905151230j5485995dpbbd882dc91b25339@mail.gmail.com> <20090515200235.GA11829@nokia.com> <45cc95260905152119l6d4e76d1k6a11af2b177219ef@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57810 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbZEPNBl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 May 2009 09:01:41 -0400
Content-Disposition: inline
In-Reply-To: <45cc95260905152119l6d4e76d1k6a11af2b177219ef@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Trilok Soni <soni.trilok@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>

Hi,

On Sat, May 16, 2009 at 06:19:33AM +0200, ext Mohamed Ikbel Boulabiar wrote:
> On Fri, May 15, 2009 at 9:02 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> 
> > Yeah, let's try to define the best way to expose accelerometers with
> > linux kernel and avoid a sysfs hell. Better sooner than later.
> 
> isn't the best way to add a thing like the one for battery for any input device
> /proc/acpi/battery/CMB0/state
> or even in /sys/input/devices/XXXX
> 
> and let any userspace application do what she wants with information ?

This case is the other way around. We are trying to set proper
thresholding and other parameters depending on the user application
(gaming, screen rotation, etc).

> > Say we wanna use the accelerometer for both screen rotation and gaming,
> > that device isn't doing hw monitoring and still we _do_ want to set
> > different thresholds and irq requests/types for different use cases,
> > right ?
> 
> Another reason for preparing the interface I just cited.

Yes, and the interface would be an input ioctl so that userland would
give us the parameters and the driver just sets them to proper
registers.

-- 
balbi
