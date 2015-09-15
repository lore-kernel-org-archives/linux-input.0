From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/4] devicetree: bindings:Allwinner sun4i keypad
Date: Tue, 15 Sep 2015 17:30:53 +0200
Message-ID: <20150915153053.GO4684@lukather>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
 <1442325957-10102-5-git-send-email-yassinjaffer@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="de1H0RjRxOSdb4we"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLXT4CXQKGQEGCBVYLA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442325957-10102-5-git-send-email-yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--de1H0RjRxOSdb4we
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Sep 16, 2015 at 12:05:57AM +1000, yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Signed-off-by: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/input/sun4i-keypad.txt     | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sun4i-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/sun4i-keypad.txt b/Documentation/devicetree/bindings/input/sun4i-keypad.txt
> new file mode 100644
> index 0000000..60ed0f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/sun4i-keypad.txt
> @@ -0,0 +1,56 @@
> +Allwinner sun4i keypad
> +------------------------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-a10-keypad"
> + - reg: mmio address range of the chip
> + - interrupts: interrupt to which the chip is connected
> + - clocks : shall reference keypad controller clocks.
> + - clock-names : keypad controller internal clock names. Shall contain :
> +    * "apb" : APB gating clock
> +    * "keypad" : keypad controller clock
> +
> +Required Board Specific Properties:
> +- pinctrl-names: The definition can be found at
> +pinctrl/pinctrl-bindings.txt.
> +
> +- pinctrl-0: The definition can be found at
> +pinctrl/pinctrl-bindings.txt.
> +
> +- linux,keymap: The definition can be found at
> +bindings/input/matrix-keymap.txt.
> +
> +Optional properties:
> + - scan-cycle: device specific scan cycle
> + - debounce-cycle: device specific debounce cycle
> + - autorepeat: If specified device will autorepeat

Are those properties generic? I couldn't find them defined anywhere.

In which units are those properties?

> +
> +Example:
> +
> +#include <dt-bindings/input/input.h>
> +
> +	kp: kp@01c23000 {
> +		compatible = "allwinner,sun4i-a10-keypad";
> +		reg = <0x01c23000 0x400>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&apb0_gates 10>, <&keypad_clk>;
> +		clock-names = "apb", "keypad";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&keypad_rows>, <&keypad_cols>;
> +		linux,keymap = <0x00000067	/* KEY_UP */
> +				0x0001006c	/* KEY_DOWN */
> +				0x00020072	/* KEY_VOLUMEDOWN */
> +				0x00030066	/* KEY_HOME */
> +				0x0100006a	/* KEY_RIGHT */
> +				0x01010069	/* KEY_LEFT */
> +				0x0102001c	/* KEY_ENTER */
> +				0x01030073	/* KEY_VOLUMEUP */
> +				0x02000040	/* KEY_F6 */
> +				0x02010042	/* KEY_F8 */
> +				0x02020043	/* KEY_F9 */
> +				0x02030044	/* KEY_F10 */
> +				0x0300003b	/* KEY_F1 */
> +				0x0301003c	/* KEY_F2 */
> +				0x0302003d	/* KEY_F3 */
> +				0x03030074>;	/* KEY_POWER */

You don't seem to use the header you just told us to include.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--de1H0RjRxOSdb4we--
