From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Kernel] Mainlining of Pyra nub joystick driver
Date: Fri, 17 Jun 2016 13:20:17 +0200
Message-ID: <D6A5D219-9571-43CE-A969-8683951184D2@goldelico.com>
References: <20160614114523.GC4820@zver> <20160614170206.GE4820@zver>
 <DAA6B14A-062E-45E9-97DD-18D55480F0A8@goldelico.com>
 <20160616195106.GG4820@zver>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20160616195106.GG4820@zver>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Andrey Utkin <andrey_utkin@fastmail.com>, Grazvydas Ignotas <notasas@gmail.com>
Cc: devel@driverdev.osuosl.org, kernel-mentors@selenic.com, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Grant Grundler <grundler@chromium.org>, linux-input@vger.kernel.org, Daniel Hung-yu Wu <hywu@google.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, kernel@pyra-handheld.com, S Twiss <stwiss.opensource@diasemi.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Andrey,

> Am 16.06.2016 um 21:51 schrieb Andrey Utkin <andrey_utkin@fastmail.com>:
> 
> On Tue, Jun 14, 2016 at 07:09:50PM +0200, H. Nikolaus Schaller wrote:
>> 
>>> Am 14.06.2016 um 19:02 schrieb Andrey Utkin <andrey_utkin@fastmail.com>:
>>> Update: found drivers/input/joystick/as5011.c in mainline kernel,
>>> will look how it works with as5013 hardware.
>> 
>> Before you spend too much time on it, they have not much in
>> common except the manufacturer and the as501x designation.
>> 
>> Register models (data sheet) are very different.
> 
> Thanks for this hint, Nikolaus!
> 
> But still, apart from register models I guess as5011 driver is a good
> starting point for a fork. I am considering this because
> - as5011 driver has support for button push event, and as5013 doesn't;

> - as5011 driver conforms to mainline standards much better than
>   existing out-of-tree as5013 driver. It also conforms to what
>   reviewers expect to see: anyway as5013 won't pass review unless all
>   tricky modes are dropped. This is according to Arnd reply; Pyra dev
>   team member aTc also votes for userspace input management daemon.

Yes, that are strong arguments. We should also look for notaz' comments
since he wrote the as5013 driver and might have some ideas what is
important from user side to have reliable operation.

> 
> I am considering forking instead of adding conditional logic to as5011
> because I don't have a chance to test as5011 hardware, so I could break
> it unintentionally and never know about that. This is serious because
> I'm going to add support of all power modes and other parameters
> eventually.

One thing which makes me wonder is that the as5011 driver appears to
be used nowhere and did only have 2 patches since introduced in 2011:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?id=refs%2Ftags%2Fv4.7-rc3&qt=grep&q=as5011

I.e. it might be unused and untested for a long time while our as5013
driver works.

This could also mean the as5011 driver can potentially be removed
from kernel and a new as5013 driver can start from scratch.

Anyways, you will be able to test a new driver on real hardware soon.
So mix&merge is probably the best strategy.

> 
> There is one thing which both as5011 and as5013 existing drivers do:
> expose a header file in include/linux/input/, with some "struct
> blah_blah_platform_data" declaration. This header file is not included
> anywhere except for corresponding driver's .c file. So I think this
> header file is not needed, and all its contents should be inlined into
> single driver's source file. From asking on #kernelnewbies IRC chat, I
> gained some confidence that there's no subtleties regarding this.
> 
> I guess "struct drivername_platform_data" is something deprecated by
> now, as long as there are devicetree files and of_...() API, so I should
> port vsense_dt_init() logic from existing as5013 driver?

I recently got similar feedback when submitting another driver, that
new drivers should be DT only and no longer need platform_data at all.
So there is no need for an include file to expose pdata to board files.

> 
> Also info about GPIO pin for button push interrupt should be added to
> devicetree files. Or please indicate that it's not going to have its
> GPIO pin for button interrupt - then driver should check button status
> at once with periodic position check.

The gpio can also interrupt but we might also want to do some debouncing.

This is already solved by the gpio-button driver. I.e. we would more
or less duplicate all code from there.

Logically it looks better to have the push button integrated in the driver and
grouped with it in DT. From DT perspective it could suffice to make the
gpio-button node a subnode of the as5013 node and keep separate
drivers? Just an idea.

BR,
Nikolaus
