From: Anisse Astier <anisse@astier.eu>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Thu, 7 Apr 2011 18:44:11 +0200
Message-ID: <20110407184411.7aec55b2@destiny.ordissimo>
References: <20110407181800.27b441b1@destiny.ordissimo>
	<1302194258.12215.10.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1302194258.12215.10.camel@novo.hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Matthew Garrett <mjg@redhat.com>, Andy Ross <andy.ross@windriver.com>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 07 Apr 2011 17:37:35 +0100, Bastien Nocera <hadess@hadess.net> wrote :

> On Thu, 2011-04-07 at 18:18 +0200, Anisse Astier wrote:
> > Pegatron Lucid tablet sends an ACPI hotkey event(0xEA) when the
> > accelerometer detects coarse orientation change. My initial thought was
> > to just translate this event into KEY_DIRECTION, which seems to be the
> > norm from what we can see in hp-wmi driver. (See patch below for an
> > implementation.)
> > 
> > But this isn't just a key per se like on the HP touchsmart tablet, this
> > is an event that is triggered when the device is rotated.
> > 
> > This could be defined as a new Misc (EV_MSC) event:
> > MSC_ORIENTATION_CHANGED ?
> > 
> > Or we could use the upcoming IIO subsystem which is supposed to be for
> > sensors, but then we'd have a mismatch between the device based on ACPI
> > with firmware in the middle (driver submitted by Andy Ross) and the
> > purpose of IIO ("SPI or I2C device").
> 
> How would one know which orientation the device is now in, either from
> the event, or when the orientation already changed? How would this be
> "key" to user-space in general, and X in particular?
> 

There's an accelerometer driver (the one I referenced as submitted by
Andy Ross), but it only works in polling mode (input-polled). With this
event, userspace doesn't have to use this polled device until orientation
changes, hence saving CPU, power, etc.

See http://www.spinics.net/lists/platform-driver-x86/msg01682.html for
the patches.

Regards,

Anisse
