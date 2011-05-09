From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 9 May 2011 17:40:06 +0100
Message-ID: <20110509164006.GA6570@srcf.ucam.org>
References: <20110407181800.27b441b1@destiny.ordissimo>
 <20110509143828.GA2632@srcf.ucam.org>
 <4DC80A53.7050609@windriver.com>
 <20110509154729.GA5043@srcf.ucam.org>
 <4DC80F45.2040508@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DC80F45.2040508@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Anisse Astier <anisse@astier.eu>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, May 09, 2011 at 08:59:01AM -0700, Andy Ross wrote:
> On 05/09/2011 08:47 AM, Matthew Garrett wrote:
> > Yes, so the accelerometer driver should (in-kernel) know that a coarse 
> > orientation event has occured and then send an appropriate uevent to 
> > userspace indiciating that it has new data.
> 
> OK, so substituting udev for acpid, but otherwise leaving the
> input-polldev device alone.  That certainly sounds nice to me, though
> I'm not sure where the "dreadful / don't do that" advice is directed
> as the handling in userspace will be virtual identical (moving the
> dbus-send from the acpid event file into a udev rule).

It shouldn't even be a dbus send - something in userspace should just be 
listening for event notifications on the accelerometer. Use udev 
directly.

> > I'm going to NAK anything that reports "Coarse orientation change"
> > to userspace without providing any context.
> 
> Just to be clear: there's no kernel code to NAK here.  The acpid hook
> is raw, and in userspace.  It's not clean, but it's also a single-device
> fixup: seems to me to be pretty much exactly what apcid is for, no?

acpid is for dealing with cases where the kernel doesn't provide 
functionality that the kernel should provide. Arbitrary APCI events 
shouldn't be being delivered to userspace - they should be handled 
in-kernel and delivered through a meaningful mechanism in order to avoid 
cases where userspace needs to know about a platform implementation. In 
this case the right way for the event to hit userspace is as a generic 
message from the accelerometer, not as a device-specific ACPI event 
through a deprecated interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
