From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 1/9] Documentation: devicetree: input: additions for
 da9061 onkey driver
Date: Wed, 9 Nov 2016 12:24:41 -0600
Message-ID: <20161109182441.jlk5clp5sviocv2q@rob-hp-laptop>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <48abf6ce51f8ef02421ea2dd4f4e309b440efc85.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <48abf6ce51f8ef02421ea2dd4f4e309b440efc85.1477929725.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 31, 2016 at 04:02:02PM +0000, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Add binding information for DA9061 onkey.
> 
> This patch updates the compatible string "dlg,da9061-onkey" to support
> DA9061, removes the reference to KEY_SLEEP (which the driver no longer
> supports) and fixes a typo in the example for DA9063.
> 
> Supporting KEY_SLEEP was not the general convention and the typical
> solution should have been for KEY_POWER to support both cases of suspend
> and S/W power off. This change was sent to the DA9063 ONKEY device
> driver in a separate patch, but the documentation was not updated at
> that time.
> - f889bea Report KEY_POWER instead of KEY_SLEEP during power key-press
> 
> This patch also adds two new examples, one for DA9062 and one for DA9061.
> The DA9061 examples uses a fall-back compatible string for the DA9062
> onkey driver.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> v2 -> v3
>  - Patch renamed from [PATCH V2 01/10] to [PATCH V3 1/9]
>  - Each compatible line should be a valid combination of compatible
>    strings, alter DA9061 line to include the fall back compatible string
>  - Update the commit message to include KEY_SLEEP removal explanation and
>    a link back to the original device driver commit. This will allow full
>    traceability back to the original patch change
>  - Link in information about associated patches from this set without
>    describing them as being explicitly dependent on this binding
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 06/10] to [PATCH V2 01/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Typo s/ther/the/ in commit message
>  - Explanation about why KEY_SLEEP was removed (see below)
>  - Addition of DA9062 example
>  - Addition of a DA9061 example to follow the driver fall-back compatible
>    convention being applied for this device driver
> 
> Hi,
> 
> There is also new binding examples for DA9062 and DA9061. Importantly,
> the Linux device driver changes for DA9061 were rejected because the
> DA9062 device driver can be reused. For this reason, the DA9061 example
> uses a fall-back compatible string.
> 
> Other information:
> The device driver from this patch set (associated with this binding) was
> applied by Dmitry Torokhov on 26-Oct-2016. See:
>  - [PATCH V2 07/10] Input: da9061: onkey driver.
>  - https://lkml.org/lkml/2016/10/26/1169
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  .../devicetree/bindings/input/da9062-onkey.txt     | 45 ++++++++++++++--------
>  1 file changed, 30 insertions(+), 15 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
