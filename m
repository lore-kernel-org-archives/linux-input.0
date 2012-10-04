From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] USB: input: wacom_sys.c: format OLED image in kernel
Date: Thu, 4 Oct 2012 00:25:28 -0700
Message-ID: <20121004072528.GD14217@core.coreip.homeip.net>
References: <1347219438-2598-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1347219438-2598-1-git-send-email-przemo@firszt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: rob@landley.net, pinglinux@gmail.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Przemo,

On Sun, Sep 09, 2012 at 03:37:18PM -0400, Przemo Firszt wrote:
> This patch adds a new way of handling Wacom Intuos4 family OLEDs.
> Previously the images had to be 'scrambled' by userland application. Now
> the 'scrambling' is done in the kernel module, so user space can send
> simple 64x32 pixels 4-bit grayscale (2 pixels per byte) 0,0 in top left corner
> images straight to a wacom OLED sysfs entry. An example:
> 
> dd bs=1024 if=image_file \
> of=/sys/bus/usb/drivers/wacom/[DevNo]/wacom_led/button[No]_formattedimg \
> count=1
> 
> This patch greatly simplifies user space preparation of the image.
> The raw image sysfs enties are still present to avoid breaking API.

I do not not believe that we should add code to the kernel for tasks that
can be just as easily performed in userspace.

Thanks!

-- 
Dmitry
