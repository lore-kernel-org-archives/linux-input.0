From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] Input: add devicetree binding note for egalax_ts
Date: Wed, 15 Aug 2012 20:53:56 +0800
Message-ID: <20120815125353.GA2258@S2101-09.ap.freescale.net>
References: <1345026708-14139-1-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-2-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-3-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345026708-14139-3-git-send-email-jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jiejing.zhang-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 15, 2012 at 06:31:47PM +0800, Hui Wang wrote:
> The egalax_ts driver needs to get the gpio number of the irq pin,
> and use this gpio to wake up the controller. So add a note
> for this change.
> 
> Signed-off-by: Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/egalax-ts.txt       |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> new file mode 100644
> index 0000000..df70318
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> @@ -0,0 +1,19 @@
> +* EETI eGalax Multiple Touch Controller
> +
> +Required properties:
> +- compatible: must be "eeti,egalax_ts"

Since we define this in the binding anyway, can we have an corresponding
.of_match_table in the driver?

Regards,
Shawn

> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +- wakeup-gpios: the gpio pin to be used for waking up the controller
> +  as well as uased as irq pin
> +
> +Example:
> +
> +	egalax_ts@04 {
> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 2>;
> +		wakeup-gpios = <&gpio1 9 0>;
> +	};
> -- 
> 1.7.6
> 
