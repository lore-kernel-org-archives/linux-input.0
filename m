From: Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer
 Blade Stealth
Date: Sun, 07 Apr 2019 18:54:42 -0400
Message-ID: <0ac9aef48f4cf974f4f7046aad1267ab5c8fe525.camel@redhat.com>
References: <20190407213735.10658-1-lyude@redhat.com>
         <20190407221034.GA162359@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190407221034.GA162359@dtor-ws>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 2019-04-07 at 15:10 -0700, Dmitry Torokhov wrote:
> Hi Lyude,
> 
> On Sun, Apr 07, 2019 at 05:37:34PM -0400, Lyude Paul wrote:
> > The late 2016 model of the Razer Blade Stealth has a built-in USB
> > keyboard, but for some reason the BIOS exposes an i8042 controller with
> > a connected KBD port. While this fake AT Keyboard device doesn't appear
> > to report any events, attempting to change the state of the caps lock
> > LED on it from on to off causes the entire system to hang.
> > 
> > So, introduce a quirk table for disabling keyboard probing by default,
> > i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
> > that table.
> 
> What does dmesg show about i8042 for this device? Especially line "PNP:
> PS/2 Controller  ..."?
> 

Apr 07 18:42:46 malachite kernel: i8042: PNP: No PS/2 controller found.
Apr 07 18:42:46 malachite kernel: i8042: Probing ports directly.
Apr 07 18:42:46 malachite kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 07 18:42:46 malachite kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 07 18:42:46 malachite kernel: mousedev: PS/2 mouse device common for all
mice
Apr 07 18:42:46 malachite kernel: rtc_cmos 00:01: RTC can wake from S4
Apr 07 18:42:46 malachite kernel: rtc_cmos 00:01: registered as rtc0
Apr 07 18:42:46 malachite kernel: rtc_cmos 00:01: alarms up to one month, y3k,
242 bytes nvram, hpet irqs
Apr 07 18:42:46 malachite kernel: device-mapper: uevent: version 1.0.3
Apr 07 18:42:46 malachite kernel: device-mapper: ioctl: 4.39.0-ioctl (2018-04-
03) initialised: dm-devel@redhat.com
Apr 07 18:42:46 malachite kernel: intel_pstate: Intel P-state driver
initializing
Apr 07 18:42:46 malachite kernel: intel_pstate: HWP enabled
Apr 07 18:42:46 malachite kernel: hidraw: raw HID events driver (C) Jiri
Kosina
Apr 07 18:42:46 malachite kernel: usbcore: registered new interface driver
usbhid
Apr 07 18:42:46 malachite kernel: usbhid: USB HID core driver
Apr 07 18:42:46 malachite kernel: intel_pmc_core:  initialized
Apr 07 18:42:46 malachite kernel: drop_monitor: Initializing network drop
monitor service
Apr 07 18:42:46 malachite kernel: Initializing XFRM netlink socket
Apr 07 18:42:46 malachite kernel: NET: Registered protocol family 10
Apr 07 18:42:46 malachite kernel: Segment Routing with IPv6
Apr 07 18:42:46 malachite kernel: mip6: Mobile IPv6
Apr 07 18:42:46 malachite kernel: NET: Registered protocol family 17
Apr 07 18:42:46 malachite kernel: RAS: Correctable Errors collector
initialized.
Apr 07 18:42:46 malachite kernel: microcode: sig=0x806e9, pf=0x80,
revision=0x8e
Apr 07 18:42:46 malachite kernel: microcode: Microcode Update Driver: v2.2.
Apr 07 18:42:46 malachite kernel: AVX2 version of gcm_enc/dec engaged.
Apr 07 18:42:46 malachite kernel: AES CTR mode by8 optimization enabled
Apr 07 18:42:46 malachite kernel: battery: ACPI: Battery Slot [BAT0] (battery
present)
Apr 07 18:42:46 malachite kernel: sched_clock: Marking stable (1166896928,
-586991)->(1172494398, -6184461)
Apr 07 18:42:46 malachite kernel: registered taskstats version 1
Apr 07 18:42:46 malachite kernel: Loading compiled-in X.509 certificates
Apr 07 18:42:46 malachite kernel: Loaded X.509 cert 'Fedora kernel signing
key: eb55b2be431426c78789899a96d617d82132041e'
Apr 07 18:42:46 malachite kernel: zswap: loaded using pool lzo/zbud
Apr 07 18:42:46 malachite kernel: Key type big_key registered
Apr 07 18:42:46 malachite kernel: Key type encrypted registered
Apr 07 18:42:46 malachite kernel: integrity: Loading X.509 certificate:
UEFI:db
Apr 07 18:42:46 malachite kernel: integrity: Loaded X.509 cert 'Microsoft
Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
Apr 07 18:42:46 malachite kernel: integrity: Loading X.509 certificate:
UEFI:db
Apr 07 18:42:46 malachite kernel: integrity: Loaded X.509 cert 'Microsoft
Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
Apr 07 18:42:46 malachite kernel: ima: Allocated hash algorithm: sha1
Apr 07 18:42:46 malachite kernel: input: AT Raw Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4

Also: After doing a bit more research on wikipedia I just noticed that
this laptop is actually a late 2017 model, so I'll respond with a respun
patch in just a sec.

> Thanks.
> 
-- 
Cheers,
	Lyude Paul
