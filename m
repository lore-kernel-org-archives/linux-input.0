From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] Input: Elan HID-I2C device driver
Date: Wed, 11 Apr 2012 22:53:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204112250370.16373@pobox.suse.cz>
References: <1334061766-20577-1-git-send-email-tom_lin@emc.com.tw> <20120411071212.GB6894@core.coreip.homeip.net> <4F85583F.6050008@emc.com.tw> <20120411162519.GA27562@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120411162519.GA27562@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?GB2312?B?wdaPqdPT?= <tom_lin@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djkurtz@chromium.org
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2012, Dmitry Torokhov wrote:

> > >> This patch adds driver for Elan I2C touchpad. These protocol of 
> > >> HID-I2C was defined by Microsoft. The kernel driver would use the 
> > >> multi-touch protocol format B.
> > > 
> > > If this device truly supports HID protocol shouldn't we define i2c-hid
> > > transport, similar to usbhid?
> > 
> > I merely follow defined by Microsoft.
> > It was called "HID OVER I2C" by Microsoft.
> > (http://msdn.microsoft.com/en-us/library/windows/hardware/hh825917(v=vs.85).
> > aspx) But I agree to change from hid i2c to i2chid.
> > Do you have any better opinions?
> 
> I am not sure we are talking about same thing... I do not really care
> whether it is named "hid i2c" or "i2chid". What I meant if the device
> really speaks HID protocol, except that the transport is not USB or
> bluetooth but I2C, then instead of writing a custom driver for this
> particular part we need to add a new HID transport into
> drivers/hid/i2c-hid that is similar to drivers/hid/usbhid/ and reuse the
> rest of HID framework along with hid- multitouch.c which handles
> HID-compliant multitouch devices.
> 
> I am CCing Jiri (HID maintainer) for additional input.

Yes, please.

In case you'd be looking into a bit less bloated example of how transport 
driver for HID subsystem looks like, see the Bluetooth one in 
net/bluetooth/hidp/ (and we don't currently have any other examples than 
these two :) ).

I'd be happy to merge it once you convert to to proper HID transport 
driver.

Could the event processing part then be integrated into hid-multitouch?

Thanks,

-- 
Jiri Kosina
SUSE Labs
