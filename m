From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RESEND PATCH v5] Input: sysrq - DT binding for key sequence
Date: Sat, 27 Jul 2013 22:52:35 -0600
Message-ID: <20130728045235.EE6863E0A24@localhost>
References: <1374705316-8520-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48123 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3G1Ewi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 00:52:38 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so4421184pab.27
        for <linux-input@vger.kernel.org>; Sat, 27 Jul 2013 21:52:38 -0700 (PDT)
In-Reply-To: <1374705316-8520-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robherring2@gmail.com, dmitry.torokhov@gmail.com
Cc: devicetree@vger.kernel.org, john.stultz@linaro.org, linux-input@vger.kernel.org, kernel-team@android.com, mathieu.poirier@linaro.org

On Wed, 24 Jul 2013 16:35:16 -0600, mathieu.poirier@linaro.org wrote:
> Sorry about the noise - device tree mailing has changed.
> 
> I haven't heard back from anyone after making the last modifications
> a week ago.  If it's all good with you Rob, please ack it so that 
> Dmitry can pick it up on his side.
> 
> Thanks,
> Mathieu.
> 
> From 37318cb3c6339747f4e96e09f07f732a395a5ae1 Mon Sep 17 00:00:00 2001
> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> Date: Wed, 10 Jul 2013 09:53:35 -0600
> Subject: [RESEND PATCH v5] Input: sysrq - DT binding for key sequence
> 
> Adding a simple device tree binding for the specification of key sequences.
> Definition of the keys found in the sequence are located in
> 'include/uapi/linux/input.h'.
> 
> For the sysrq driver, holding the sequence of keys down for a specific amount of time
> will reset the system.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> changes for v5:
>   - Corrected error in binding definition.
>   - Using helper macro to fetch the key sequence.
>   - Removing white space.
> ---
>  .../devicetree/bindings/input/input-reset.txt      | 34 ++++++++++++++++++++
>  drivers/tty/sysrq.c                                | 37 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/input-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/input-reset.txt b/Documentation/devicetree/bindings/input/input-reset.txt
> new file mode 100644
> index 0000000..c69390c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/input-reset.txt
> @@ -0,0 +1,34 @@
> +Input: sysrq reset sequence
> +
> +A simple binding to represent a set of keys as described in
> +include/uapi/linux/input.h.  This is to communicate a
> +sequence of keys to the sysrq driver.  Upon holding the keys
> +for a specified amount of time (if specified) the system is
> +sync'ed and reset.
> +
> +Key sequences are global to the system but all the keys in a
> +set must be coming from the same input device.
> +
> +The /chosen node should contain a 'linux,sysrq-reset-seq' child
> +node to define a set of keys.
> +
> +Required property:
> +sysrq-reset-seq: array of keycodes

Please be more specific: "array of Linux keycodes, one keycode per cell"

> +
> +Optional property:
> +timeout-ms: duration keys must be pressed together in milliseconds
> +before generating a sysrq

What is the default behaviour if timeout-ms isn't present?

Otherwise, Acked-by: Grant Likely <grant.likely@linaro.org>

> +
> +Example:
> +
> + chosen {
> +                linux,sysrq-reset-seq {
> +                        keyset = <0x03
> +                                  0x04
> +                                  0x0a>;
> +                        timeout-ms = <3000>;
> +                };
> +         };
> +
> +Would represent KEY_2, KEY_3 and KEY_9.
> +
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index b51c154..ed8f00f 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -44,6 +44,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/moduleparam.h>
>  #include <linux/jiffies.h>
> +#include <linux/of.h>
>  
>  #include <asm/ptrace.h>
>  #include <asm/irq_regs.h>
> @@ -671,6 +672,34 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
>  	}
>  }
>  
> +static void sysrq_of_get_keyreset_config(void)
> +{
> +	u32 key;
> +	struct device_node *np;
> +	struct property *prop;
> +	const __be32 *p;
> +
> +	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +	if (!np) {
> +		pr_debug("No sysrq node found");
> +		return;
> +	}
> +
> +	/* reset in case a __weak definition was present */
> +	sysrq_reset_seq_len = 0;
> +
> +	of_property_for_each_u32(np, "keyset", prop, p, key) {
> +		if ((key == KEY_RESERVED || key > KEY_MAX) ||
> +			(sysrq_reset_seq_len == SYSRQ_KEY_RESET_MAX))
> +			break;
> +
> +		sysrq_reset_seq[sysrq_reset_seq_len++] = (unsigned short)key;
> +	}
> +
> +	/* get reset timeout if any */
> +	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> +}
> +
>  static void sysrq_reinject_alt_sysrq(struct work_struct *work)
>  {
>  	struct sysrq_state *sysrq =
> @@ -903,6 +932,7 @@ static inline void sysrq_register_handler(void)
>  	int error;
>  	int i;
>  
> +	/* first check if a __weak interface was instantiated */
>  	for (i = 0; i < ARRAY_SIZE(sysrq_reset_seq); i++) {
>  		key = platform_sysrq_reset_seq[i];
>  		if (key == KEY_RESERVED || key > KEY_MAX)
> @@ -911,6 +941,13 @@ static inline void sysrq_register_handler(void)
>  		sysrq_reset_seq[sysrq_reset_seq_len++] = key;
>  	}
>  
> +	/*
> +	 * DT configuration takes precedence over anything
> +	 * that would have been defined via the __weak
> +	 * interface
> +	 */
> +	sysrq_of_get_keyreset_config();
> +
>  	error = input_register_handler(&sysrq_handler);
>  	if (error)
>  		pr_err("Failed to register input handler, error %d", error);
> -- 
> 1.8.1.2
> 

