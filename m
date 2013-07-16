From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v4] Input: sysrq - DT binding for key sequence
Date: Mon, 15 Jul 2013 21:43:41 -0500
Message-ID: <51E4B35D.8020000@gmail.com>
References: <1373902598-10062-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:38515 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458Ab3GPCoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 22:44:00 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so180028obb.11
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 19:43:59 -0700 (PDT)
In-Reply-To: <1373902598-10062-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: grant.likely@linaro.org, dmitry.torokhov@gmail.com, kernel-team@android.com, devicetree-discuss@lists.ozlabs.org, john.stultz@linaro.org, linux-input@vger.kernel.org

On 07/15/2013 10:36 AM, mathieu.poirier@linaro.org wrote:
> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
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
> changes for v4:
>   - Moved seach of reset sequence nodes to a single call.
> ---
>  .../devicetree/bindings/input/input-reset.txt      | 34 ++++++++++++++
>  drivers/tty/sysrq.c                                | 54 ++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/input-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/input-reset.txt b/Documentation/devicetree/bindings/input/input-reset.txt
> new file mode 100644
> index 0000000..79504af
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
> +
> +Optional property:
> +timeout-ms: duration keys must be pressed together in microseconds

milliseconds (ms) or microseconds (us)?

> +before generating a sysrq
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
> index b51c154..01a8729 100644
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
> @@ -671,6 +672,50 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
>  	}
>  }
>  
> +static void sysrq_of_get_keyreset_config(void)
> +{
> +	unsigned short key;
> +	struct device_node *np;
> +	const struct property *prop;
> +	const __be32 *val;
> +	int count, i;
> +
> +	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +	if (!np) {
> +		pr_debug("No sysrq node found");
> +		goto out;
> +	}
> +
> +	prop = of_find_property(np, "keyset", NULL);
> +	if (!prop || !prop->value) {
> +		pr_err("Invalid input keyset");
> +		goto out;
> +	}
> +
> +	count = prop->length / sizeof(u32);
> +	val = prop->value;

None of the existing helpers to retrieve property arrays doesn't work here?

> +
> +	if (count > SYSRQ_KEY_RESET_MAX)
> +		count = SYSRQ_KEY_RESET_MAX;
> +
> +	/* reset in case a __weak definition was present */
> +	sysrq_reset_seq_len = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		key = (unsigned short)be32_to_cpup(val++);
> +		if (key == KEY_RESERVED || key > KEY_MAX)
> +			break;
> +
> +		sysrq_reset_seq[sysrq_reset_seq_len++] = key;
> +	}
> +
> +	/* get reset timeout if any */
> +	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> +
> + out:
> +	;
> +}
> +
>  static void sysrq_reinject_alt_sysrq(struct work_struct *work)
>  {
>  	struct sysrq_state *sysrq =
> @@ -688,6 +733,7 @@ static void sysrq_reinject_alt_sysrq(struct work_struct *work)
>  		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 1);
>  		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
>  
> +

spurious ws change

>  		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 0);
>  		input_inject_event(handle, EV_KEY, alt_code, 0);
>  		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
> @@ -903,6 +949,7 @@ static inline void sysrq_register_handler(void)
>  	int error;
>  	int i;
>  
> +	/* first check if a __weak interface was instantiated */
>  	for (i = 0; i < ARRAY_SIZE(sysrq_reset_seq); i++) {
>  		key = platform_sysrq_reset_seq[i];
>  		if (key == KEY_RESERVED || key > KEY_MAX)
> @@ -911,6 +958,13 @@ static inline void sysrq_register_handler(void)
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
> 

