From: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.29rc1 breakes usb: hiddev device no longer available
Date: Mon, 26 Jan 2009 20:05:07 +0100
Message-ID: <200901262005.08168.oliver@neukum.org>
References: <20090126170130.GG6158@vanheusden.com> <20090126182707.GI6158@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754271AbZAZTF1@vger.kernel.org>
In-Reply-To: <20090126182707.GI6158@vanheusden.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Folkert van Heusden <folkert@vanheusden.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Monday 26 January 2009 19:27:07 schrieb Folkert van Heusden:
> > Since version 2.6.29rc1 querying cleware USb devices no longer works.
> > 2.6.28 works fine. 2.6.29-rc2 also no longer works.
> 

> the is the FAILURE situation (2.6.29-rc*):
> open("/dev/usb/hiddev0", O_RDWR)        = 3
> ioctl(3, HIDIOCGDEVINFO, 0xbf90c0d8)    = 0
> ioctl(3, HIDIOCAPPLICATION, 0)          = -6291455
> ioctl(3, HIDIOCGSTRING, 0x804e2c0)      = -1 ENODEV (No such device)

Please try this patch.

	Regards
		Oliver

--

--- linux-2.6/drivers/hid/usbhid/hiddev.c.alt	2009-01-26 20:03:10.000000000 +0100
+++ linux-2.6/drivers/hid/usbhid/hiddev.c	2009-01-26 20:03:17.000000000 +0100
@@ -656,7 +656,7 @@ static long hiddev_ioctl(struct file *fi
 
 	case HIDIOCGSTRING:
 		mutex_lock(&hiddev->existancelock);
-		if (!hiddev->exist)
+		if (hiddev->exist)
 			r = hiddev_ioctl_string(hiddev, cmd, user_arg);
 		else
 			r = -ENODEV;
