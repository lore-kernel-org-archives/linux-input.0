From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [rtc-linux] RE: [PATCH V2 3/4] watchdog: da9062: DA9062
 watchdog driver
Date: Tue, 19 May 2015 10:16:46 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B994@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
 <20150515202005.GA23133@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8C8@SW-EX-MBX02.diasemi.com>
 <20150518152737.GA14403@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8FE@SW-EX-MBX02.diasemi.com>
 <20150518173927.GV3338@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150518173927.GV3338@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Guenter Roeck <linux@roeck-us.net>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 18 May 2015 18:39 Alexandre Belloni wrote:

> Sure, what I understand is that the base functionality is the same and
> even the registers are compatible. Are you sure the new features can't
> be added to the da9063 and called conditionally? Plenty of drivers are
> doing that.

Hi Alexandre/Guenter,

I didn't say it couldn't be added to DA9063. Of course it's all possible, but I think
it would become unmaintainable in future without separate drivers. There is some
extra freeze functionality and a watchdog warn interrupt: both do not exist in the
DA9063.

What I did say **one month ago** was the DA9062 watchdog driver does have some
similarities with the DA9063 watchdog (https://lkml.org/lkml/2015/5/6/505).

But I would prefer two drivers for watchdog in this case. When compared to the RTC and
OnKey the watchdog is very different on the hardware side. Despite the appearance of
some similarity, the watchdog is not a functional clone like the RTC and OnKey components.

I would not like a combined watchdog driver because I think that the extra functions
that the DA9062 contains would bloat out the DA9063 watchdog, and would make it difficult
to test and to maintain for the future..

Regards,
Steve
