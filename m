From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 00/10] Add binding from PS/2 to SMBus for Synaptics and Elan
Date: Mon, 30 Jan 2017 14:05:39 +0100
Message-ID: <CAN+gG=E=wBWNhw7hPDVZPAUUKWP8-CxU0-sKZwXHghW2ODNeyA@mail.gmail.com>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>, Adrian Alves <aalves@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitri,

On Tue, Jan 10, 2017 at 5:11 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> Well, this is the last series which enables RMI4 over SMBus for the Thinkpad
> t*40, t*50, t*60 series. Few comments on the patches:
>
> patches 1 to 3 allows the re-routing of the trackstick buttons from the touchpad
>   to the trackstick
> patch 4 to 7 allow rmi_smbus to actually control the PS/2 node to not resume and
>   mess up the configuration after a resume
> patch 8 was originally sent as a RMI4 specific driver, but I came to realise
>   that Elan could also benefit from the same driver

Any comments on the first 8 patches?

Cheers,
Benjamin

> patch 9 has already been sent once, but there was no clear way of enabling the
>   trackstick, so it was not merged
> patch 10 allows the elantech driver to create an instance of elan_i2c and
>   forwards the trackstick information from PS/2
>
> Note that patch 10 has only been tested on a machine without a functional
> elan_i2c touchpad, so only the binding has been tested.
>
> This series requires the Host Notify flag patch from Dmitry:
> http://patchwork.ozlabs.org/patch/711229/
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (10):
>   Input: serio - store the pt_buttons in the struct serio directly
>   Input: synaptics-rmi4 - Add rmi_find_function()
>   Input: synaptics-rmi4 - f30/f03: Forward mechanical buttons on
>     buttonpads to PS/2 guest
>   Input: psmouse - allow to deactivate a driver from the serio handle
>   Input: synaptics - allocate a Synaptics Intertouch device
>   Input: synaptics-rmi4 - smbus: call psmouse_deactivate before
>     binding/resume
>   Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails
>   Input: add a PS/2 to SMBus platform module
>   Input: elan_i2c - add trackstick report
>   Input: elantech - automatically bind an SMBus device when acceptable
>
>  drivers/input/misc/Kconfig          |  11 ++
>  drivers/input/misc/Makefile         |   1 +
>  drivers/input/misc/ps2_smbus.c      | 276 ++++++++++++++++++++++++++++++++++++
>  drivers/input/mouse/elan_i2c.h      |  12 ++
>  drivers/input/mouse/elan_i2c_core.c |  99 ++++++++++++-
>  drivers/input/mouse/elantech.c      |  54 +++++++
>  drivers/input/mouse/elantech.h      |   3 +
>  drivers/input/mouse/psmouse-base.c  |  34 +++++
>  drivers/input/mouse/psmouse.h       |   3 +
>  drivers/input/mouse/synaptics.c     | 134 +++++++++++++++--
>  drivers/input/mouse/synaptics.h     |   5 +-
>  drivers/input/rmi4/Kconfig          |   1 +
>  drivers/input/rmi4/rmi_driver.c     |  13 ++
>  drivers/input/rmi4/rmi_driver.h     |  15 ++
>  drivers/input/rmi4/rmi_f03.c        |  30 ++++
>  drivers/input/rmi4/rmi_f30.c        |  72 ++++++++--
>  drivers/input/rmi4/rmi_smbus.c      |  47 ++++--
>  include/linux/rmi.h                 |   2 +
>  include/linux/serio.h               |  22 +++
>  19 files changed, 795 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/input/misc/ps2_smbus.c
>
> --
> 2.9.3
>
