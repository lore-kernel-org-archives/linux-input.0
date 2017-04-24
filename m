From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Silead DMI driver
Date: Mon, 24 Apr 2017 14:48:16 +0300
Message-ID: <1493034496.24567.163.camel@linux.intel.com>
References: <20170424132356.044ae04f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170424132356.044ae04f@endymion>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Darren Hart <dvhart@infradead.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2017-04-24 at 13:23 +0200, Jean Delvare wrote:
> Hi all,
> 
> I'm looking at drivers/platform/x86/silead_dmi.c which is being added
> to kernel v4.11 and I do not like what I see.

I don't like it either by some other reasons.

> I have to say I don't understand the whole complexity of the design.
> As
> I understand it, the properties which are being added are only
> consumed
> by the "silead" touchscreen driver. I see no necessity to add the
> missing properties before that driver is even loaded. Can't you just
> look for the ACPI companion device at the time the silead driver tries
> to bind to the i2c device, and add the missing properties before
> performing the actual probe? This would be so much simpler. What am I
> missing?

As far as I understand it would be as simple as adding a quirk in actual
driver (touchscreen), but there is strong objection of adding quirks to
the drivers/input/* from Dmitry as I noticed during discussion [1] about
GPIO ACPI library fixes I'm working on.

[1] https://lkml.org/lkml/2017/4/4/593

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
