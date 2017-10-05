From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] Input: add support for the Samsung S6SY761 touchscreen
Date: Thu, 5 Oct 2017 15:47:25 -0500
Message-ID: <20171005204725.ya7vg2y4uvesvzzd@rob-hp-laptop>
References: <CGME20170926063153epcas2p2980241d1aa064cd9eb0a335c841ff801@epcas2p2.samsung.com>
 <20170926063135.16480-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170926063135.16480-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 26, 2017 at 03:31:35PM +0900, Andi Shyti wrote:
> The S6SY761 touchscreen is a capicitive multi-touch controller
> for mobile use. It's connected with i2c at the address 0x48.
> 
> This commit provides a basic version of the driver which can
> handle only initialization, touch events and power states.
> 
> The controller is controlled by a firmware which, in the version
> I currently have, doesn't provide all the possible
> functionalities mentioned in the datasheet.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
> Hi,
> 
> sorry for the mix-up of the previous patch. This one should be
> fine. Here's the changelog:
> 
> v3 - v4
>  - fixed a mismatch on the module name
> 
> v2 - v3
>  - added security check on an unsigned value which can (unlikely)
>    get a "negative" value
> 
>  - in the probe function the interrupt is requested after the
>    input device registration in order to avoid checking in the
>    interrupt handler whether the input device has been registered
> 
>  - removed the 'prev_pm_state' variable. Its original meaning
>    was to restore the state of the device when coming back from
>    sleep mode, but because I removed in patch v2 the low power
>    mode, now the device works only in two modes and therefore
>    'prev_pm_state' is not required any longer.
> 
> v1 - v2
>  - remove the low power functionality as it doesn't bring any
>    benefit
>  - use get_unaligned_be16 instead of the form 'a << 8 | b'
>  - use max_t instead of '? :'
>  - use managed 'devm_device_add_group()'
> 
> Thanks,
> Andi
> 
>  .../bindings/input/touchscreen/samsung,s6sy761.txt |  34 ++

In the future, a separate patch for bindings please.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |  11 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/s6sy761.c                | 556 +++++++++++++++++++++
>  4 files changed, 602 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
>  create mode 100644 drivers/input/touchscreen/s6sy761.c
