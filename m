From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Date: Wed, 13 May 2015 12:31:36 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
 <20150510095838.GF3338@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150510095838.GF3338@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

On 10 May 2015 10:59 Alexandre Belloni wrote:

> Hi,
> 
> On 17/04/2015 at 15:23:33 +0100, S Twiss wrote :
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add RTC driver support for DA9062

[...]

> This is an almost exact copy of drivers/rtc/rtc-da9063.c, apart from the
> retry mechanism in read_time. Can you simply add support for the da9062
> in that driver?


Hi Alexandre,

Something similar is being discussed for the OnKey component of the DA9062.
https://lkml.org/lkml/2015/4/24/304

It is only the OnKey and RTC components that are similar to the DA9063 chip
and I was hoping to keep the 62 RTC separate in this case ... however it should
definitely be possible to re-use the DA9063 RTC driver if this is your requirement.
If this will block my submission of the DA9062 then I will drop the RTC from my
next patch set and try to re-work the existing 63 RTC driver accordingly.

I think this sort of thing has been done before:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-pm8xxx.c
 ... at first glance -- it seems to support that sort of thing.

I guess it would be possible to rename the da9063-rtc to something more sensible like
da9xxx-rtc.c if this goes ahead?

Regards,
Steve
