From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v3 0/8] Input: synaptics-rmi4: Reimplement functionality
 from hid-rmi
Date: Fri, 12 Aug 2016 10:50:33 -0700
Message-ID: <f4e0cca9-c77b-7b1a-eacd-59ba966c32bc@synaptics.com>
References: <1468476475-7884-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468476475-7884-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I wanted to check on the status of this patch series. It looks like 
patches 2, 3, 4, and 7 remain outstanding. For the most part all of the 
patches have either review or ack signoffs. The version 2 of patch 2 was 
reviewed by Benjamin Tissoires, but not v3. However, the changes between 
v2 and v3 are fairly trivial and noted in the patch under the signoff line.

I think patch three is the most controversial since it generated some 
discussion about whether or not those parameters belong in device tree. 
I attempted to explain why I thought they did in one of my replies. 
However, if you don't think that issues has been resolved I would 
recommend skipping that patch instead of holding up the others. Let me 
know if there is anything else I need to address.

Thanks,
Andrew

On 07/13/2016 11:07 PM, Andrew Duggan wrote:
> The v3 version of this patch series makes changes to patch 1 and patch 3.
> Patch 1 now uses of_get_child_by_name() instead of of_find_node_by_name()
> to avoid having to increment the refcount of the of_node which avoid
> that hack. Patch 3 adds "force" to the device tree parameters to help to
> clarify that these parameters overwrite the default value set in the
> firmware configuration.
>
> Thanks,
> Andrew
>
> Andrew Duggan (8):
>    Input: synaptics-rmi4: Use of_get_child_by_name() instead of
>      of_find_node_by_name()
>    Input: synaptics-rmi4: Add parameters for dribble packets and palm
>      detect gesture
>    Input: synaptics-rmi4: Add dribble and palm gesture parameters to
>      device tree
>    Input: synaptics-rmi4: Add support for controlling dribble packets in
>      F12
>    Input: synaptics-rmi4: Remove pointer to rmi_function in f12_data
>    Input: synaptics-rmi4: Remove unneeded variable
>    Input: synaptics-rmi4: Handle incomplete input data
>    Input: synaptics-rmi4: Use the RMI_F11_REL_BYTES define in
>      rmi_f11_rel_pos_report
>
>   .../bindings/input/rmi4/rmi_2d_sensor.txt          | 10 +++
>   drivers/input/rmi4/rmi_2d_sensor.c                 | 13 +++
>   drivers/input/rmi4/rmi_2d_sensor.h                 |  2 +
>   drivers/input/rmi4/rmi_bus.c                       |  4 +-
>   drivers/input/rmi4/rmi_f01.c                       |  6 +-
>   drivers/input/rmi4/rmi_f11.c                       | 95 +++++++++++++++------
>   drivers/input/rmi4/rmi_f12.c                       | 98 ++++++++++++++++++++--
>   drivers/input/rmi4/rmi_f30.c                       |  4 +
>   include/linux/rmi.h                                | 21 +++--
>   9 files changed, 208 insertions(+), 45 deletions(-)
>
