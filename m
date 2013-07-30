From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v6] Input: sysrq - DT binding for key sequence
Date: Mon, 29 Jul 2013 22:09:54 -0600
Message-ID: <CACxGe6u9-sEzxdDzc8T2HFNMqh-LHbTepUHqDF_tLLjxSxSG4Q@mail.gmail.com>
References: <1375115638-21236-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44642 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3G3EKQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 00:10:16 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so7797246obb.5
        for <linux-input@vger.kernel.org>; Mon, 29 Jul 2013 21:10:15 -0700 (PDT)
In-Reply-To: <1375115638-21236-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, kernel-team@android.com

On Mon, Jul 29, 2013 at 10:33 AM,  <mathieu.poirier@linaro.org> wrote:
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

Acked-by: Grant Likely <grant.likely@linaro.org>

g.

> ---
> changes for v6:
>   - Made binding description more specific.  'sysrq-reset-seq's definition
>     was enhanced and the case where 'timeout-ms' is omitted clearly
>     explained.
> ---
>  .../devicetree/bindings/input/input-reset.txt      | 34 ++++++++++++++++++++
>  drivers/tty/sysrq.c                                | 37 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/input-reset.txt
>
> diff --git a/Documentation/devicetree/bindings/input/input-reset.txt b/Documentation/devicetree/bindings/input/input-reset.txt
> new file mode 100644
> index 0000000..13421a9
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
> +sysrq-reset-seq: array of Linux keycodes, one keycode per cell.
> +
> +Optional property:
> +timeout-ms: duration keys must be pressed together in milliseconds
> +before generating a sysrq.  If omitted the system is rebooted
> +immediately when a valid sequence has beend recognized.
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
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index d5cc3ac..b04a24d 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -45,6 +45,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/jiffies.h>
>  #include <linux/syscalls.h>
> +#include <linux/of.h>
>
>  #include <asm/ptrace.h>
>  #include <asm/irq_regs.h>
> @@ -681,6 +682,34 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
>         }
>  }
>
> +static void sysrq_of_get_keyreset_config(void)
> +{
> +       u32 key;
> +       struct device_node *np;
> +       struct property *prop;
> +       const __be32 *p;
> +
> +       np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +       if (!np) {
> +               pr_debug("No sysrq node found");
> +               return;
> +       }
> +
> +       /* reset in case a __weak definition was present */
> +       sysrq_reset_seq_len = 0;
> +
> +       of_property_for_each_u32(np, "keyset", prop, p, key) {
> +       if ((key == KEY_RESERVED || key > KEY_MAX) ||
> +               (sysrq_reset_seq_len == SYSRQ_KEY_RESET_MAX))
> +               break;
> +
> +               sysrq_reset_seq[sysrq_reset_seq_len++] = (unsigned short)key;
> +       }
> +
> +       /* get reset timeout if any */
> +       of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> +}
> +
>  static void sysrq_reinject_alt_sysrq(struct work_struct *work)
>  {
>         struct sysrq_state *sysrq =
> @@ -914,6 +943,7 @@ static inline void sysrq_register_handler(void)
>         int error;
>         int i;
>
> +       /* first check if a __weak interface was instantiated */
>         for (i = 0; i < ARRAY_SIZE(sysrq_reset_seq); i++) {
>                 key = platform_sysrq_reset_seq[i];
>                 if (key == KEY_RESERVED || key > KEY_MAX)
> @@ -922,6 +952,13 @@ static inline void sysrq_register_handler(void)
>                 sysrq_reset_seq[sysrq_reset_seq_len++] = key;
>         }
>
> +       /*
> +        * DT configuration takes precedence over anything
> +        * that would have been defined via the __weak
> +        * interface
> +        */
> +       sysrq_of_get_keyreset_config();
> +
>         error = input_register_handler(&sysrq_handler);
>         if (error)
>                 pr_err("Failed to register input handler, error %d", error);
> --
> 1.8.1.2
>
