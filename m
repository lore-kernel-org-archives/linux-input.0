From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] Input: Elan HID-I2C device driver
Date: Fri, 13 Apr 2012 18:21:53 +0200
Message-ID: <20120413162153.GA8602@polaris.bitmath.org>
References: <1334061766-20577-1-git-send-email-tom_lin@emc.com.tw>
 <20120411071212.GB6894@core.coreip.homeip.net>
 <4F85583F.6050008@emc.com.tw>
 <20120411162519.GA27562@core.coreip.homeip.net>
 <4F8631C8.1090705@emc.com.tw>
 <alpine.LNX.2.00.1204131442520.16373@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1204131442520.16373@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?utf-8?B?5p6X77+94pSv77+9?= <tom_lin@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djkurtz@chromium.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 13, 2012 at 02:43:14PM +0200, Jiri Kosina wrote:
> On Thu, 12 Apr 2012, Benjamin Tissoires wrote:
> 
> > I read Microsoft's things about HID over I2C few days ago. And from
> > what I understood, the report descriptors and the enumeration of the
> > devices are stored in the ACPI table and not in the device itself. Can
> > you confirm this?
> > 
> > I was thinking about making hid-multitouch independent from the usb
> > stack and was thinking about doing the i2c-hid bridge. However, I did
> > not start writing a line yet ;-)
> 
> I guess you were planning to write that as a HID transport (ll) driver, 
> right?

Sounds great. The recent investigations into the properties of the hid
device identity for multitouch suggests that the ll driver could be
seen as the owner of the hid device itself, and should take on the
responsibility of both report fixups and determining the device
identify (read modalias). Using generic code (hid-owner?) of course. I
am experimenting with a couple of patches for it. Would you all agree
with this assessment?

Henrik
