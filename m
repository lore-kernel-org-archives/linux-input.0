From: Anisse Astier <anisse@astier.eu>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 9 May 2011 18:30:34 +0200
Message-ID: <20110509183034.592ad732@destiny.ordissimo>
References: <20110407181800.27b441b1@destiny.ordissimo>
	<20110509143828.GA2632@srcf.ucam.org>
	<4DC80A53.7050609@windriver.com>
	<20110509154729.GA5043@srcf.ucam.org>
	<4DC80F45.2040508@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4DC80F45.2040508@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 09 May 2011 08:59:01 -0700, Andy Ross <andy.ross@windriver.com> wrote :

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
> 
> > I'm going to NAK anything that reports "Coarse orientation change"
> > to userspace without providing any context.
> 
> Just to be clear: there's no kernel code to NAK here.  The acpid hook
> is raw, and in userspace.  It's not clean, but it's also a single-device
> fixup: seems to me to be pretty much exactly what apcid is for, no?

I think this was aimed at my proposal to send an input event
KEY_DIRECTION from within asus_laptop driver, which wouldn't provide
context with regard to which accelerometer device triggered it (although
in our setup there's only one device, and the ACPI event doesn't provide
any context either, but at least we know it's an ACPI accelerometer).

An udev event(e.g "change") works for me, it would provide context, and
wouldn't disturb the handling of the polled-input device which we'd like
to open as little as possible.

Anyway, whatever solution we choose, the priority is to get this driver
included, even if we don't support the "Coarse Orientation Changed" event
in kernel yet.

Anisse
