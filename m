From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support using the
 existing DA9063 RTC driver
Date: Thu, 9 Jul 2015 10:01:31 +0200
Message-ID: <CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1436427954.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

Hi Steve,

On Thu, Jul 9, 2015 at 9:45 AM, S Twiss <stwiss.opensource@diasemi.com> wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
>
> This patch set adds RTC support for the Dialog DA9062 Power Management IC.
> Changes are made to the existing DA9063 RTC component so that functionality
> in this device driver can be re-used to support the DA9062 RTC.

[...]

> S Twiss (3):
>   mfd: da9062: Support for the DA9063 RTC in the DA9062 core

"DA9062 RTC"?

>   rtc: da9063: Add DA9062 RTC capability to DA9063 RTC driver
>   devicetree: da9062: Add device tree bindings for DA9062 RTC

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
