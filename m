From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] HID: quirks: Disable runtime suspend on Microsoft Corp.
 Basic Optical Mouse v2.0
Date: Thu, 22 Aug 2019 12:38:45 +0200
Message-ID: <1566470325.8347.35.camel@suse.com>
References: <20190822091744.3451-1-kai.heng.feng@canonical.com>
         <1566467151.8347.23.camel@suse.com>
         <AD8A4135-0275-45B3-BEB9-031737A2C756@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AD8A4135-0275-45B3-BEB9-031737A2C756@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag, den 22.08.2019, 18:04 +0800 schrieb Kai-Heng Feng:
> Hi Oliver,
> 
> at 17:45, Oliver Neukum <oneukum@suse.com> wrote:
> 
> > Am Donnerstag, den 22.08.2019, 17:17 +0800 schrieb Kai-Heng Feng:
> > > The optical sensor of the mouse gets turned off when it's runtime
> > > suspended, so moving the mouse can't wake the mouse up, despite that
> > > USB remote wakeup is successfully set.
> > > 
> > > Introduce a new quirk to prevent the mouse from getting runtime
> > > suspended.
> > 
> > Hi,
> > 
> > I am afraid this is a bad approach in principle. The device
> > behaves according to spec.
> 
> Can you please point out which spec it is? Is it USB 2.0 spec?

Well, sort of. The USB spec merely states how to enter and exit
a suspended state and that device state must not be lost.
It does not tell you what a suspended device must be able to do.

> > And it behaves like most hardware.
> 
> So seems like most hardware are broken.
> Maybe a more appropriate solution is to disable RPM for all USB mice.

That is a decision a distro certainly can make. However, the kernel
does not, by default, call usb_enable_autosuspend() for HID devices
for this very reason. It is enabled by default only for hubs,
BT dongles and UVC cameras (and some minor devices)

In other words, if on your system it is on, you need to look
at udev, not the kernel.

> > If you do not want runtime PM for such devices, do not switch
> > it on.
> 
> A device should work regardless of runtime PM status.

Well, no. Runtime PM is a trade off. You lose something if you use
it. If it worked just as well as full power, you would never use
full power, would you?

Whether the loss of functionality or performance is worth the energy
savings is a policy decision. Hence it belongs into udev.
Ideally the kernel would tell user space what will work in a
suspended state. Unfortunately HID does not provide support for that.

This is a deficiency of user space. The kernel has an ioctl()
to let user space tell it, whether a device is fully needed.
X does not use them.

> > The refcounting needs to be done correctly.
> 
> Will do.

Well, I am afraid your patch breaks it and if you do not break
it, the patch is reduced to nothing.

> > 
> > This patch does something that udev should do and in a
> > questionable manner.
> 
> IMO if the device doesn’t support runtime suspend, then it needs to be  
> disabled in kernel but not workaround in userspace.

You switch it on from user space. Of course the kernel default
must be safe, as you said. It already is.

	Regards
		Oliver
