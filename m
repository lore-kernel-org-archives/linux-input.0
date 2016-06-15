From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] hid: migrate Riso Kagaku LED driver from USB misc to
 HID
Date: Wed, 15 Jun 2016 09:31:53 +0200
Message-ID: <20160615073153.GP24234@mail.corp.redhat.com>
References: <2e8c1dbe-1433-a347-75d6-1cbd59c74212@gmail.com>
 <20160614214849.GO24234@mail.corp.redhat.com>
 <222a795a-b478-3dae-13a2-a805784eb8da@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <222a795a-b478-3dae-13a2-a805784eb8da@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Jun 15 2016 or thereabouts, Heiner Kallweit wrote:
> Am 14.06.2016 um 23:49 schrieb Benjamin Tissoires:
> > On Jun 12 2016 or thereabouts, Heiner Kallweit wrote:
> >> The Riso Kagaku Webmail Notifier (and its clones) is supported as part of
> >> usb/misc/usbled driver currently. This patch migrates the driver for this
> >> device to the HID subsystem.
> >>
> >> Benefits:
> >> - Avoid using USB low-level calls and use the HID subsystem instead
> >>   (as this device provides a USB HID interface)
> >> - Use standard LED subsystem instead of proprietary sysfs entries,
> >>   this allows e.g. to use the device with features like triggers
> >>
> >> I know at least one cheap clone coming with green and blue LED switched.
> >> There's a module paramater to deal with this.
> >>
> >> There might be users of the current module, therefore so far allow
> >> compilation of the new driver only if the old one is disabled.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >> v2:
> >> - change config symbol from HID_RIKA to HID_RISO_KAGAKU
> >> - use full name Riso Kagaku instead of rika in several places
> >> - don't remove device from ignore list if CONFIG_USB_LED is defined
> >> - fix module parameter permissions
> > 
> > Thanks for the respin. This version (and the other for hid-rika) looks
> > fine. Though I wonder if you should not call hid_hw_open() at the end of
> > probe (and hid_hw_close() during remove) to keep the device opened.
> > Otherwise I am unsure whether your usb commands will get treated (I
> > might be wrong).
> > 
> When looking at other hid device drivers hid_hw_open seems to be needed
> only if the device needs special treatment.

Not exactly. hid_hw_open is called whenever someone opens the hidraw or
input node (or any other resource attached to the HID device). This
starts the input reading, but also calls usb_autopm_get_interface()
which will prevent the device to be autosuspended. The drivers that call
hid_hw_open() in their probe are the ones where we know no one will open
the hidraw or input node but we need to poll for events.

> My Riso Kagaku and Dream Cheeky devices work fine with the new drivers
> w/o calling hid_hw_open.

Let's keep it that way then.

> 
> > There is also one high level comment I would like to do:
> > even if your driver is better than usbled.c, people won't use it because
> > distributions won't enable it as there is 2 issues:
> > - one is you are breaking kernel ABI (we already discussed it)
> > - the other one is that if people want to use your new hid drivers, they
> >   have to disable CONFIG_USB_LED, which removes support of the
> >   DELCOM_VISUAL_SIGNAL_INDICATOR
> > 
> Yes, I think you're right.
> With regard to the Delcom Visual Signal Indicator:
> The old USB LED driver supports only generation 1 of these devices which
> have a not fully HID compliant interface.
> In 2008 they were replace with generation 2 which has fully a HID
> compliant interface. Generation 2 is not yet supported by the kernel.
> (Currently I'm trying to get hold of such a device.)
> 
> Therefore it might be better to leave support for the Gen 1 Delcom device
> at USB misc. However this would mean that we have to change the config
> symbol for this driver so that it doesn't conflict with the other part
> we're moving to hid.
> Would changing the config symbol be an issue? For now we could select
> the new config symbol automatically if CONFIG_USB_LED is set.

Why would you change the old config symbol for the existing devices. If
(and I don't think that's the best option) you were to add a new symbol,
you could use this to select between HID and USB for the new drivers:
CONFIG_USB_LED_LEGACY_SUPPORT would depend on CONFIG_USB_LED, and you
choose to enable the HID driver based on CONFIG_USB_LED_LEGACY_SUPPORT.

> 
> > I really think it would not cost too much to do the whole change in 2
> > passes:
> > - move the entire usbled to hid, keeping the old sysfs API in place, and
> >   eventually add a symlink from the old place (under the usb device) to
> >   the HID device to keep path stable
> 
> I guess you don't mean symlink literally but adding a comment in Kconfig
> that the driver was moved?

No. I'd rather not having the files moved around when they are KABI. So
either you add the old sysfs files directly at the same level, or you
symlink to them. Some HID driver already take a pointer to the
underlying USB device, so you can do the same.

> 
> > - then add support for the classdev for the whole 3 types of devices
> > 
> > Plus that would means only one driver to maintain instead of 3 that are
> > close enough.
> > 
> > Cheers,
> > Benjamin
> > 
> Regards, Heiner
> 

Cheers,
Benjamin
