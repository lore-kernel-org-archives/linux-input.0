From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RESEND PATCH V7 1/5] Documentation: devicetree: watchdog:
 da9062/61 watchdog timer binding
Date: Thu, 6 Apr 2017 04:32:18 -0700
Message-ID: <d258bf91-06cd-dd96-c1e1-ef310c89565e@roeck-us.net>
References: <cover.1491467308.git.stwiss.opensource@diasemi.com>
 <1d280a35fc522f7b271c730988ab0f186fef25ba.1491467308.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1d280a35fc522f7b271c730988ab0f186fef25ba.1491467308.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>, DEVICETREE <devicetree@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On 04/06/2017 01:28 AM, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
>
> Add binding information for DA9062 and DA9061 watchdog.
>
> Example bindings for both DA9062 and DA9061 devices are added. For
> the DA9061 device, a fallback compatible line is added as a valid
> combination of compatible strings.
>
> The original binding for DA9062 (only) used to reside inside the
> Documentation/devicetree/bindings/mfd/da9062.txt MFD document.
> The da9062-watchdog section was deleted in that file and replaced
> with a link to the new DA9061/62 binding information stored in this
> patch.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>
> ---
>
> Hi,
>
> I have just noticed.
>
> The driver code changes for the da9062/61 watchdog have been applied to
> the linux kernel. The da9062/61 alterations for
> drivers/watchdog/da9062_wdt.c appear in linux-stable/v4.10-rc1. Those
> changes are linked to this binding patch, but this patch seems to have
> been missed out.
>
> The source code dependency for this patch is given in the commit:
> 72106c1 v4.10-rc1 watchdog: da9062/61: watchdog driver
>
> I don't see anything blocking for merge of this patch now.
>
> Regards,
> Steve
>
> This patch applies against linux-next and v4.11-rc3
>
> v6 -> v7
>  - NO CODE CHANGE
>
> v5 -> v6
>  - NO CODE CHANGE
>  - Rebased from v4.9 to v4.11-rc3
>
> v4 -> v5
>  - NO CODE CHANGE
>  - Rebased from v4.8 to v4.9
>
> v3 -> v4
>  - NO CODE CHANGE
>  - Patch renamed from [PATCH V3 2/9] to [PATCH V4 1/8]
>  - Added Acked-by Rob Herring
>
> v2 -> v3
>  - Patch renamed from [PATCH V1 02/10] to [PATCH V3 2/9]
>  - Each compatible line should be a valid combination of compatible
>    strings, alter DA9061 line to include the fall back compatible string
>  - Update the commit message to describe this change
>  - Add information about associated patches from this set without
>    describing them as being explicitly dependent on this binding
>
> v1 -> v2
>  - Patch renamed from [PATCH V1 07/10] to [PATCH V2 02/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Updated the patch description to be explicit about where parts of
>    this binding had originally been stored
>  - A second example for DA9061 is provided to highlight the use of a
>    fall-back compatible option for the DA9062 watchdog driver
>
> As previously:
>
> For the watchdog case: the DA9062 device driver is compatible with the
> DA9061 and for this reason there is minimal change required to the DA9062
> watchdog device driver. The example for the DA9061 watchdog shows the
> use of a fall-back compatible string.
>
> Other information:
> The device driver from this patch set (associated with this binding) is
>   [PATCH V5 6/8] watchdog: da9061: watchdog driver
>
> Regards,
> Steve Twiss, Dialog Semiconductor
>
>
>  .../devicetree/bindings/watchdog/da9062-wdt.txt    | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> new file mode 100644
> index 0000000..b935b52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> @@ -0,0 +1,23 @@
> +* Dialog Semiconductor DA9062/61 Watchdog Timer
> +
> +Required properties:
> +
> +- compatible: should be one of the following valid compatible string lines:
> +	"dlg,da9061-watchdog", "dlg,da9062-watchdog"
> +	"dlg,da9062-watchdog"
> +
> +Example: DA9062
> +
> +	pmic0: da9062@58 {
> +		watchdog {
> +			compatible = "dlg,da9062-watchdog";
> +		};
> +	};
> +
> +Example: DA9061 using a fall-back compatible for the DA9062 watchdog driver
> +
> +	pmic0: da9061@58 {
> +		watchdog {
> +			compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
> +		};
> +	};
>
