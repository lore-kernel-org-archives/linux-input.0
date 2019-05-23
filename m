From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 00/10] Fix Elan I2C touchpads in latest generation from Lenovo
Date: Thu, 23 May 2019 15:25:19 +0200
Message-ID: <CAO-hwJ+BzfWKKMKtM0Q3+qMfCm99kQeUfEdA97oz5bg_Jp_SyA@mail.gmail.com>
References: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Tue, May 21, 2019 at 3:27 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi,
>
> This is the v2 from https://lkml.org/lkml/2018/10/12/633
>
> So I initially thought it would be easy to integrate the suggested changes
> in the v1, but it turns our that the changes to have the touchscreen-width
> and height parameters were quite hard to do.
>
> I finally postponed the issue by blacklisting the 2 laptops we knew were
> not working and tried to devote more time to understand both drivers more.
>
> But it s the time where Lenovo is preparing the new models, and guess what,
> they suffer from the same symptoms.

I just received the confirmation from Lenovo that this series makes
the new laptops working.

Cheers,
Benjamin

>
> So I took a few time to work on this and finally got my head around the
> width and height problem. Once I got it, it was simple clear, but this also
> means we can not really rely on a device tree property for that.
>
> So in the elan* drivers, the "traces" are simply how many antennas there
> are on each axis. Which means that if a trace of 4 is reported in the
> events, it means it is simply seen by 4 antennas. So the computation of the
> width/height is the following: we take how many antennas there are, we
> subtract one to have the number of holes between the antennas, and we
> divide the number of unit we have in the axis by the value we just
> computed.
> This gives a rough 4mm on the P52, in both directions.
>
> And once you get that, you can just realize that the unit of the width and
> height are just the same than the X and Y coordinates, so we can apply the
> same resolution.
>
> So, in the end, that means that elan_i2c needs the information, or it will
> not be able to convert the number of crossed antennas into a size, but this
> is something specific to this touchpad.
>
> So here come, 7 months later the v2 on the subject.
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (10):
>   Input: elantech - query the min/max information beforehand too
>   Input: elantech - add helper function elantech_is_buttonpad()
>   Input: elantech - detect middle button based on firmware version
>   dt-bindings: add more optional properties for elan_i2c touchpads
>   Input: elan_i2c - do not query the info if they are provided
>   Input: elantech/SMBus - export all capabilities from the PS/2 node
>   Input: elan_i2c - handle physical middle button
>   Input: elan_i2c - export true width/height
>   Input: elan_i2c - correct the width/size base value
>   Input: elantech: remove P52 from SMBus blacklist
>
>  .../devicetree/bindings/input/elan_i2c.txt    |  11 +
>  drivers/input/mouse/elan_i2c_core.c           |  85 +++--
>  drivers/input/mouse/elantech.c                | 318 ++++++++++--------
>  drivers/input/mouse/elantech.h                |   8 +
>  4 files changed, 251 insertions(+), 171 deletions(-)
>
> --
> 2.21.0
>
