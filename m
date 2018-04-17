From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads (series 80)
Date: Tue, 17 Apr 2018 10:34:11 +0200
Message-ID: <CAO-hwJJnHPEQ+R+8qWb1Dn+otqgmbcKgiNDOyNkVBD+xdzY_zw@mail.gmail.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Ma <aaron.ma@canonical.com>
List-Id: linux-input@vger.kernel.org

Hi KT,

gentle ping :)

Could you ACK/NACK this series?

Dmitry, the first patch could go without KT's approval. Also I
realized that Aaron submitted a similar patch for the X1 Carbon last
October: https://patchwork.kernel.org/patch/10008513/
So I think the first one should go ASAP now that the laptops are
shipping from Lenovo.

Cheers,
Benjamin

On Mon, Apr 9, 2018 at 11:10 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Dmitry,
>
> Here is the v2 of the Lenovo 80 series.
> Changes from v1:
> - included patch to convert a function to static from build bot
> - use of device property instead of platform data (thus the new device tree
>   binding)
>
> BTW, KT, if you want to add your Signed-off-by on the patches, feel free to
> do so. You were of tremendous help :)
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (9):
>   Input: synaptics - add Lenovo 80 series ids to SMBus
>   input: elan_i2c_smbus - fix corrupted stack
>   Input: elan_i2c - add trackstick report
>   Input: elantech - split device info into a separate structure
>   Input: elantech_query_info() can be static
>   Input: elantech - query the resolution in query_info
>   Input: elantech - add support for SMBus devices
>   Input: elantech - detect new ICs and setup Host Notify for them
>   input: psmouse-smbus: allow to control psmouse_deactivate
>
>  .../devicetree/bindings/input/elan_i2c.txt         |   1 +
>  drivers/input/mouse/Kconfig                        |  12 +
>  drivers/input/mouse/elan_i2c_core.c                |  90 +++-
>  drivers/input/mouse/elan_i2c_smbus.c               |  22 +-
>  drivers/input/mouse/elantech.c                     | 479 +++++++++++++++------
>  drivers/input/mouse/elantech.h                     |  69 ++-
>  drivers/input/mouse/psmouse-base.c                 |  21 +-
>  drivers/input/mouse/psmouse-smbus.c                |  24 +-
>  drivers/input/mouse/psmouse.h                      |   2 +
>  drivers/input/mouse/synaptics.c                    |   5 +-
>  10 files changed, 565 insertions(+), 160 deletions(-)
>
> --
> 2.14.3
>
