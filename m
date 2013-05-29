From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Dependencies in the HID subsystem
Date: Thu, 30 May 2013 00:23:38 +0200
Message-ID: <CANq1E4SPsF1SXC1Buh+VgK1MJ+LPKwQOqVk+xfA0oYqw7ptdqw@mail.gmail.com>
References: <1369855174.4306.198.camel@chaos.site>
	<alpine.LNX.2.00.1305292245090.30576@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1305292245090.30576@pobox.suse.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jean Delvare <jdelvare@suse.de>, Michal Marek <mmarek@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Wed, May 29, 2013 at 10:52 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 29 May 2013, Jean Delvare wrote:
>
>> I am worried and confused by some Kconfig dependencies in the HID
>> subsystem.
>>
>> There are 11 HID device drivers which are defined in drivers/hid/Kconfig
>> with:
>>
>>       tristate "..." if EXPERT
>>       default !EXPERT
>>
>> Unless EXPERT is enabled (and that's not the default), these driver
>> entries are hidden and automatically selected. If CONFIG_HID=m, they are
>> selected as modules. If CONFIG_HID=y, they are built into the kernel. So
>> it is impossible to have CONFIG_HID=y and build these device drivers as
>> modules - as device drivers typically are.
>>
>> I would like to understand the reasoning behind this complexity. What is
>> so special about these 11 drivers, that we can't just let the (kernel
>> configuring) user chose if he/she wants them and in what form?

For several reason I recommend CONFIG_EXPERT for all users, anyway.
But apart from that, what's wrong with "default y" and dropping any
CONFIG_EXPERT dependency? We can still keep the "tristate '..' if
EXPERT".

The CONFIG_EXPERT descriptions says "this option allows certain base
kernel options and settings to be disabled or tweaked". This really
doesn't say anything about "disable any non-standard options if this
is selected". So why do we default to "n" if CONFIG_EXPERT is
selected? This always bothered me because I don't expect the config to
change if I select it.

Cheers
David
