From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [RFC] Add Input IOCTL for accelerometer devices
Date: Sat, 16 May 2009 05:19:33 +0100
Message-ID: <45cc95260905152119l6d4e76d1k6a11af2b177219ef@mail.gmail.com>
References: <20090515131636.GE4443@nokia.com> <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com>
	<45cc95260905151230j5485995dpbbd882dc91b25339@mail.gmail.com>
	<20090515200235.GA11829@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753503AbZEPEUI@vger.kernel.org>
In-Reply-To: <20090515200235.GA11829@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Trilok Soni <soni.trilok@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>
List-Id: linux-input@vger.kernel.org

On Fri, May 15, 2009 at 9:02 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:

> Yeah, let's try to define the best way to expose accelerometers with
> linux kernel and avoid a sysfs hell. Better sooner than later.

isn't the best way to add a thing like the one for battery for any input device
/proc/acpi/battery/CMB0/state
or even in /sys/input/devices/XXXX

and let any userspace application do what she wants with information ?

> The problem is that it doesn't really seem to me that all accelerometers
> will be doing hw monitoring. The ones used in laptops, for sure, trying
> to prevent the hd from drying during a fall. But imagine the
> accelerometers used in, say, wii-mote, or cellphones, or such stuff ?

Many of them are HID devices (99%), so can be treated the same way
according the standard.

> Say we wanna use the accelerometer for both screen rotation and gaming,
> that device isn't doing hw monitoring and still we _do_ want to set
> different thresholds and irq requests/types for different use cases,
> right ?

Another reason for preparing the interface I just cited.

> I'll grep around the Industrial IO patchset if that's supposed to a
> 'sensor fw' sorta thing. Hope it does report the devices as input
> devices. I'm pretty sure we're gonna fall into similar issues when
> dealing with magnetometers, for instance, what's the best way to expose
> those device with current linux frameworks ? It's not really user input
> data...
>
> Well, let's see where this discussion takes us. Willing to hear from
> Jonatha, Dmitry and all of you guys

Yes guys, I also wait for your comments :)


ikbel
