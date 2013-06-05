From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 10/53] Input: atmel_mxt_ts - Add memory access interface
 via sysfs
Date: Wed, 05 Jun 2013 19:45:04 +0100
Message-ID: <51AF8730.4010507@itdev.co.uk>
References: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk> <1370453866-16534-11-git-send-email-nick.dyer@itdev.co.uk> <7380889.l4hHqCT0mm@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7380889.l4hHqCT0mm@dtor-d630.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wednesday, June 05, 2013 06:37:03 PM Nick Dyer wrote:
>> Atmel maXTouch chips can be addressed via an "Object Based Protocol" which
>> defines how i2c registers are mapped to different functions within the
>> chips. This interface exposes the register map and allows user-space
>> utilities to inspect and alter object configuration, and to view diagnostic
>> data, while the device is running.
> 
> I think if the driver was to use regmap then this fucntionality will already 
> be there as regmap exports registers via debugfs.

Yes, this was suggested in the past and I spent some time looking into it.

We have made a deliberate choice to implement this via sysfs rather than
debugfs since it needs to work on devices that don't have debugfs enabled.

In addition, there are some quirks about the way in which we have to
read/write registers which means regmap isn't a good fit.
