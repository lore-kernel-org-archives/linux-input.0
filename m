From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
Date: Fri, 19 Dec 2014 14:26:55 -0800
Message-ID: <1419028015.25129.14.camel@perches.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
	 <1419027470-7969-1-git-send-email-jonathar@broadcom.com>
	 <1419027470-7969-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1419027470-7969-2-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 2014-12-19 at 14:17 -0800, Jonathan Richardson wrote:
> Add initial version of the Broadcom touchscreen driver.

more trivia:

> diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
[]
> +static int get_tsc_config(struct device_node *np, struct iproc_ts_priv *priv)
> +{
> +	u32 val;
[]
> +	if (of_property_read_u32(np, "debounce_timeout", &val) >= 0) {
> +		if (val < 0 || val > 255) {
> +			dev_err(dev, "debounce_timeout must be [0-255]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.debounce_timeout = val;

Doesn't the compiler generate a warning message
about an impossible "unsigned < 0" test for all
of these "val < 0" uses?

> +	}
> +
> +	if (of_property_read_u32(np, "settling_timeout", &val) >= 0) {
> +		if (val < 0 || val > 11) {
[]
> +	if (of_property_read_u32(np, "touch_timeout", &val) >= 0) {
> +		if (val < 0 || val > 255) {
[]
> +	if (of_property_read_u32(np, "average_data", &val) >= 0) {
> +		if (val < 0 || val > 8) {
[]
> +	if (of_property_read_u32(np, "fifo_threshold", &val) >= 0) {
> +		if (val < 0 || val > 31) {


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
