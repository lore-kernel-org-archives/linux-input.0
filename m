From: Chris Chiu <chiu@endlessm.com>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up
 system after s2idle
Date: Mon, 6 Aug 2018 19:07:25 +0800
Message-ID: <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
 <73029405.6ZXyByzer1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <73029405.6ZXyByzer1@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 6, 2018 at 5:37 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, August 3, 2018 10:04:09 AM CEST Chris Chiu wrote:
>> Hi guys,
>>     We have some new laptops with Intel new Intel WiskyLake CPU come
>> in and they all have the same problem. They all have the so-called
>> "Modern Standby" feature which is s2idle in Linux.
>>
>>     The problem is the built-in keyboard no longer wake up the system
>> after it goes to s2idle. Only the power button can wake up. It's
>> different from the other laptops with old Intel CPUs (CoffeeLake,
>> KaybeLake...etc). We found the difference is that the EC (embedded
>> controller) no longer signals SCI event when in s2idle.
>>
>>     Confirmed with ASUS EC engineer, he also admits that the EC code
>> for signaling SCI event in modern standby has been removed on
>> WiskyLake models. Because the built-in PS2 keyboard can still wake up
>> the system on WisksyLake+Windows10 RS4 combination without EC
>> intervention.
>>
>>     Based on this information, we suspect that maybe the built-in
>> keyboard wakeup on Windows 10 RS4 in enabled by default (although we
>> don't know how to prove that). It's easy to simply do
>> 'device_set_wakeup_enable' and 'enable_irq_wake' for the i8042
>> keyboard port to wake up the system without EC, but it's nasty.
>>
>>     Any suggestion about how to achieve the keyboard wake up function
>> on these new laptops in a generic way? Thanks
>
> What about echoing "enabled" to the keyboard's power/wakeup file in sysfs?
>

'echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup' can get the
keyboard wake up the system as expected. We considered to work out a DMI
based quirk for this. But based on the information that EC would not signal SCI
event for WiskyLake models, we'd like to know if there's any generic solution?
Maybe a 'udev' rule to identify WiskyLake NoteBook then enable the keyboard
wake up?

Chris
