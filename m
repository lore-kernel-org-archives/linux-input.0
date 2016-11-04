From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 00/18] Synaptics RMI4 and SMBus implementation
Date: Fri, 4 Nov 2016 09:23:48 +0100
Message-ID: <CAN+gG=EG-6g52gBSwF60FNTaeXfg90F9BJzJNfFxHVC6YV3PEQ@mail.gmail.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Thu, Oct 13, 2016 at 5:50 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi guys,
>
> This is the third submission of this series, with some addition of RMI4 patches
> currently waiting on the list.
>
> I integrated Bjorn's patch because in the end, it seems to be the right thing
> to do. We can create an irqchip in hid-rmi and also provide an IRQ there.
> Worse case, if this doesn't work, we can always add a special case to
> disable the handling of the IRQs in core.
>
> I took Nick's patch as it's a nice cleanup and it solves an issue where
> the mutex irq_mutex might not be initialized (in the case we are not handling
> IRQ directly in core).
>
> I also took some patches from Andrew that were submitted back in July, and that
> were left over. They are required to allow hid-rmi to use rmi4-core without
> losing functionality. The DT binding seemed to be problematic, so I just lefted
> it out of the series. We can add it later when required (if required).
> Andrew, regarding hid-rmi, I'll try to give you a draft of the irqchip
> implementation based on what I did for SMBus Host Notify.
>
> The rest is an update of the SMBus work. The main differences is that now
> rmi4-smbus doesn't handle anymore the IRQ and I hope that the SMBus Host Notify
> patches I posted on linux-i2c will be approved by Wolfram.

I understand you are busy with many other projects, but it would be
great if we could have this series (or a subset of this series)
landing ASAP.

We already have at least 2 machines (the Lenovo X1 Tablet and the HP
Pavilion x2) that need to be using the function 12 in Synaptics RMI4,
and so this series is a requirement to enable those touchpads.

If you really want to postpone the review of the new files in this
series, I think merging only the following patches would be
acceptable:
[v3,01/18] Input: synaptics-rmi4 - Move IRQ handling to rmi_driver
[v3,02/18] Input: synaptics-rmi4 - factor out functions from probe
[v3,03/18] Input: synaptics-rmi4 - Handle incomplete input data
[v3,04/18] Input: synaptics-rmi4 - Add parameters for dribble packets
and palm detect gesture
[v3,05/18] Input: synaptics-rmi4 - Add support for controlling dribble
packets in F12
[v3,06/18] Input: synaptics-rmi4 - Set the ABS_MT_TOOL_TYPE bit to
report tool type
[v3,09/18] Input: synaptics-rmi4 - have only one struct platform data
[v3,18/18] Input: synaptics-rmi4 - fix documentation of
rmi_2d_sensor_platform_data

This is the bare minimum I think to enable the F12 in hid-rmi. It
should apply gracefully (crossing finger for 9/18), and would allow us
to switch hid-rmi to rmi4-core.

I guess Jiri will probably want a stable branch with those commits so
we can also merge the switch from hid-rmi to use rmi4-core in v4.10.

Cheers,
Benjamin

>
> Cheers,
> Benjamin
>
> Andrew Duggan (4):
>   Input: synaptics-rmi4 - Handle incomplete input data
>   Input: synaptics-rmi4 - Add parameters for dribble packets and palm
>     detect gesture
>   Input: synaptics-rmi4 - Add support for controlling dribble packets in
>     F12
>   Input: synaptics-rmi4 - Set the ABS_MT_TOOL_TYPE bit to report tool
>     type
>
> Benjamin Tissoires (10):
>   Input: synaptics-rmi4 - add SMBus support
>   Input: serio - store the pt_buttons in the struct serio directly
>   Input: synaptics-rmi4 - have only one struct platform data
>   Input: synaptics-rmi4 - Add rmi_find_function()
>   Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on
>     buttonpads to PS/2 guest
>   Input: synaptics - allocate a Synaptics Intertouch device
>   Input: synaptics-rmi4 - add rmi_platform
>   Input: synaptics-rmi4 - smbus: call psmouse_deactivate before
>     binding/resume
>   Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails
>   Input: synaptics-rmi4 - fix documentation of
>     rmi_2d_sensor_platform_data
>
> Bjorn Andersson (1):
>   Input: synaptics-rmi4 - Move IRQ handling to rmi_driver
>
> Dennis Wassenberg (1):
>   Input: synaptics-rmi4 - f03: grab data passed by transport device
>
> Lyude Paul (1):
>   Input: synaptics-rmi4 - add support for F03
>
> Nick Dyer (1):
>   Input: synaptics-rmi4 - factor out functions from probe
>
>  drivers/input/mouse/psmouse-base.c |  12 +
>  drivers/input/mouse/psmouse.h      |   1 +
>  drivers/input/mouse/synaptics.c    | 153 +++++++++++-
>  drivers/input/mouse/synaptics.h    |   5 +-
>  drivers/input/rmi4/Kconfig         |  33 +++
>  drivers/input/rmi4/Makefile        |   3 +
>  drivers/input/rmi4/rmi_2d_sensor.c |   2 +
>  drivers/input/rmi4/rmi_2d_sensor.h |   2 +
>  drivers/input/rmi4/rmi_bus.c       |   3 +
>  drivers/input/rmi4/rmi_bus.h       |  12 +
>  drivers/input/rmi4/rmi_driver.c    | 225 ++++++++++++-----
>  drivers/input/rmi4/rmi_driver.h    |  15 ++
>  drivers/input/rmi4/rmi_f01.c       |   6 +-
>  drivers/input/rmi4/rmi_f03.c       | 272 +++++++++++++++++++++
>  drivers/input/rmi4/rmi_f11.c       |  90 +++++--
>  drivers/input/rmi4/rmi_f12.c       | 100 +++++++-
>  drivers/input/rmi4/rmi_f30.c       |  83 +++++--
>  drivers/input/rmi4/rmi_i2c.c       |  74 +-----
>  drivers/input/rmi4/rmi_platform.c  | 235 ++++++++++++++++++
>  drivers/input/rmi4/rmi_smbus.c     | 477 +++++++++++++++++++++++++++++++++++++
>  drivers/input/rmi4/rmi_spi.c       |  72 +-----
>  include/linux/rmi.h                |  47 ++--
>  include/linux/serio.h              |   8 +
>  include/uapi/linux/serio.h         |   1 +
>  24 files changed, 1663 insertions(+), 268 deletions(-)
>  create mode 100644 drivers/input/rmi4/rmi_f03.c
>  create mode 100644 drivers/input/rmi4/rmi_platform.c
>  create mode 100644 drivers/input/rmi4/rmi_smbus.c
>
> --
> 2.7.4
>
