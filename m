From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up system after s2idle
Date: Mon, 06 Aug 2018 11:37:05 +0200
Message-ID: <73029405.6ZXyByzer1@aspire.rjw.lan>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Friday, August 3, 2018 10:04:09 AM CEST Chris Chiu wrote:
> Hi guys,
>     We have some new laptops with Intel new Intel WiskyLake CPU come
> in and they all have the same problem. They all have the so-called
> "Modern Standby" feature which is s2idle in Linux.
> 
>     The problem is the built-in keyboard no longer wake up the system
> after it goes to s2idle. Only the power button can wake up. It's
> different from the other laptops with old Intel CPUs (CoffeeLake,
> KaybeLake...etc). We found the difference is that the EC (embedded
> controller) no longer signals SCI event when in s2idle.
> 
>     Confirmed with ASUS EC engineer, he also admits that the EC code
> for signaling SCI event in modern standby has been removed on
> WiskyLake models. Because the built-in PS2 keyboard can still wake up
> the system on WisksyLake+Windows10 RS4 combination without EC
> intervention.
> 
>     Based on this information, we suspect that maybe the built-in
> keyboard wakeup on Windows 10 RS4 in enabled by default (although we
> don't know how to prove that). It's easy to simply do
> 'device_set_wakeup_enable' and 'enable_irq_wake' for the i8042
> keyboard port to wake up the system without EC, but it's nasty.
> 
>     Any suggestion about how to achieve the keyboard wake up function
> on these new laptops in a generic way? Thanks

What about echoing "enabled" to the keyboard's power/wakeup file in sysfs?
