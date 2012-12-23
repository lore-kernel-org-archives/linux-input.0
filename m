From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys_polled - defer probing if GPIO probing
 is deferred
Date: Sun, 23 Dec 2012 02:06:25 -0800
Message-ID: <20121223100625.GB17407@core.coreip.homeip.net>
References: <1356251523-28359-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1356251523-28359-1-git-send-email-juhosg@openwrt.org>
Sender: stable-owner@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Dec 23, 2012 at 09:32:03AM +0100, Gabor Juhos wrote:
> If GPIO probing is deferred, the driver tries to
> claim an invalid GPIO line which leads to an error
> message like this:
> 
>   gpio-keys-polled buttons.2: unable to claim gpio 4294966779, err=-22
>   gpio-keys-polled: probe of buttons.2 failed with error -22
> 
> The patch ensures that 'gpio_keys_polled_get_devtree_pdata'
> returns -EPROBE_DEFER if any of the GPIOs to register are
> deferred.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index f686fd9..cfb54cc 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -120,6 +120,12 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
>  	if (nbuttons == 0)
>  		return NULL;
>  
> +	for_each_child_of_node(node, pp) {
> +		error = of_get_gpio(pp, 0);
> +		if (error == -EPROBE_DEFER)
> +			goto err_out;
> +	}
> +
>  	pdata = kzalloc(sizeof(*pdata) + nbuttons * (sizeof *button),
>  			GFP_KERNEL);
>  	if (!pdata) {
> -- 

Well spotted, thanks. However I think the patch should look like the one
below as we should propagate all errors, not only -EPROBE_DEFER, up the
stack.

Thanks.

-- 
Dmitry


Input: gpio_keys_polled - defer probing if GPIO probing is deferred

From: Gabor Juhos <juhosg@openwrt.org>

If GPIO probing is deferred, the driver tries to claim an invalid GPIO line
which leads to an error message like this:

  gpio-keys-polled buttons.2: unable to claim gpio 4294966779, err=-22
  gpio-keys-polled: probe of buttons.2 failed with error -22

The patch ensures that error code returned by of_get_gpio_flags (including
-EPROBE_DEFER) is propagated up the stack.

Cc: stable@vger.kernel.org
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys_polled.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index f686fd9..e75ca6b 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -135,6 +135,7 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 
 	i = 0;
 	for_each_child_of_node(node, pp) {
+		int gpio;
 		enum of_gpio_flags flags;
 
 		if (!of_find_property(pp, "gpios", NULL)) {
@@ -143,9 +144,19 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 			continue;
 		}
 
+		gpio = of_get_gpio_flags(pp, 0, &flags);
+		if (gpio < 0) {
+			error = gpio;
+			if (error != -EPROBE_DEFER)
+				dev_err(dev,
+					"Failed to get gpio flags, error: %d\n",
+					error);
+			goto err_free_pdata;
+		}
+
 		button = &pdata->buttons[i++];
 
-		button->gpio = of_get_gpio_flags(pp, 0, &flags);
+		button->gpio = gpio;
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
