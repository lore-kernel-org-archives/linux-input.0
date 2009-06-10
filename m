From: Dmitriy Geels <dmitriy.geels-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Wed, 10 Jun 2009 11:14:57 +0400
Message-ID: <78f5d6bf0906100014r5b7f5c14p4544ef13442c8f0b@mail.gmail.com>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	<alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz> <1244589738.5973.1954.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244589738.5973.1954.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi!

Kernel rebuilding is pretty easy, for ubuntu/debian it would be:
- sudo apt-get install linux-source build-essential
- tar xf /usr/src/linux-source*
- cd linux-source-`uname -r`
- cp /boot/config-`uname -r` .config
- make menuconfig (find and enable HID_DEBUG)
- make bzImage modules deb-pkg
Then after some time you will get deb package, which you need to
install and then run:
- sudo update-initramfs -c -k 'new kernel version'
- sudo update-grub

Then you can reboot into new kernel and use "echo 2 >
/sys/modules/hid/parameters/debug" instead of debug module parameter.

2009/6/10 Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>:
> I found that for pretty much all the input problems, I'd need to do
> something like that. Problem is:
> - enabling CONFIG_HID_DEBUG requires rebuilding the kernel
> - most distributions build hid into the kernel
>
> Wouldn't there be a way to enable the debug at run-time without
> impacting too much on performance or binary size?
