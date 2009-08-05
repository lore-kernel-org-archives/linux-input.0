From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 4/5] input: gpio-keys: switch to new dev_pm_ops
Date: Wed, 5 Aug 2009 22:15:52 +0200
Message-ID: <74d0deb30908051315l43b00731yb79f7937707068ec@mail.gmail.com>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	 <1249496971-9019-2-git-send-email-daniel@caiaq.de>
	 <1249496971-9019-3-git-send-email-daniel@caiaq.de>
	 <1249496971-9019-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57156 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZHEUPx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2009 16:15:53 -0400
In-Reply-To: <1249496971-9019-4-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Phil Blundell <pb@handhelds.org>, linux-input@vger.kernel.org

On Wed, Aug 5, 2009 at 8:29 PM, Daniel Mack<daniel@caiaq.de> wrote:
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Phil Blundell <pb@handhelds.org>
> Cc: linux-input@vger.kernel.org
> ---
> =A0drivers/input/keyboard/gpio_keys.c | =A0 28 ++++++++++++++++++----=
------
> =A01 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index efed0c9..bfb6fc3 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -216,12 +216,12 @@ static int __devexit gpio_keys_remove(struct pl=
atform_device *pdev)
>
>
> =A0#ifdef CONFIG_PM
> -static int gpio_keys_suspend(struct platform_device *pdev, pm_messag=
e_t state)
> +static int gpio_keys_suspend(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++=
) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_keys_butto=
n *button =3D &pdata->buttons[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (button->wakeup) {
> @@ -234,12 +234,12 @@ static int gpio_keys_suspend(struct platform_de=
vice *pdev, pm_message_t state)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int gpio_keys_resume(struct platform_device *pdev)
> +static int gpio_keys_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++=
) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_keys_butto=
n *button =3D &pdata->buttons[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (button->wakeup) {
> @@ -251,19 +251,27 @@ static int gpio_keys_resume(struct platform_dev=
ice *pdev)
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +static struct dev_pm_ops gpio_keys_pm_ops =3D {
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D gpio_keys_suspend,
> + =A0 =A0 =A0 .freeze =A0 =A0 =A0 =A0 =3D gpio_keys_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D gpio_keys_resume,
> + =A0 =A0 =A0 .thaw =A0 =A0 =A0 =A0 =A0 =3D gpio_keys_resume,

I'm not sure I understand hibernation correctly, but isn't
=2Efreeze/.thaw about saving state and halting/resuming the device
operation only?
It seems to me that enabling system wakeup functionality should go
into .poweroff. (See <linux/pm.h>)

regards
Philipp
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
