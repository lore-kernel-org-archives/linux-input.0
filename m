From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v3 3/4] da850-evm: extract defines for SEL{A, B, C} pins
 in UI expander
Date: Fri, 19 Nov 2010 15:41:11 -0600
Message-ID: <AANLkTimOByqsZjCYoz=pjwT7jcgN76Sgi4W6SFJ9+N-d@mail.gmail.com>
References: <cover.1289935504.git.bengardiner@nanometrics.ca>
	<cover.1290201713.git.bengardiner@nanometrics.ca>
	<a367bea7c1bdc198b5540b7fe3c02d10ad59cf16.1290201713.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45045 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab0KSVlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 16:41:12 -0500
In-Reply-To: <a367bea7c1bdc198b5540b7fe3c02d10ad59cf16.1290201713.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, Chris Cordahi <christophercordahi@nanometrics.ca>

On Fri, Nov 19, 2010 at 3:37 PM, Ben Gardiner
<bengardiner@nanometrics.ca> wrote:
> The setup and teardown methods of the UI expander reference the SEL_{=
A,B,C}
> pins by 'magic number' in each function. This uses the common enum fo=
r their offsets
> in the expander setup and teardown functions.
>
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> Reviewed-by: Chris Cordahi <christophercordahi@nanometrics.ca>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>
> ---
>
> Changes since v2:
> =A0* rebased to 083eae3e28643e0eefc5243719f8b1572cf98299 of
> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davin=
ci.git
> =A0* integrated the static array initialization patch provided by Sek=
har Nori
>
> Changes since v1:
> =A0* No changes since v1
>
> ---

I think that ther must be just one   --- , This is extra

Regards

Victor Rodriguez

> =A0arch/arm/mach-davinci/board-da850-evm.c | =A0 24 ++++++++++++-----=
-------
> =A01 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-=
davinci/board-da850-evm.c
> index b0763f7..c689e7e 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -361,23 +361,23 @@ static int da850_evm_ui_expander_setup(struct i=
2c_client *client, unsigned gpio,
> =A0{
> =A0 =A0 =A0 =A0int sel_a, sel_b, sel_c, ret;
>
> - =A0 =A0 =A0 sel_a =3D gpio + 7;
> - =A0 =A0 =A0 sel_b =3D gpio + 6;
> - =A0 =A0 =A0 sel_c =3D gpio + 5;
> + =A0 =A0 =A0 sel_a =3D gpio + DA850_EVM_UI_EXP_SEL_A;
> + =A0 =A0 =A0 sel_b =3D gpio + DA850_EVM_UI_EXP_SEL_B;
> + =A0 =A0 =A0 sel_c =3D gpio + DA850_EVM_UI_EXP_SEL_C;
>
> - =A0 =A0 =A0 ret =3D gpio_request(sel_a, "sel_a");
> + =A0 =A0 =A0 ret =3D gpio_request(sel_a, da850_evm_ui_exp[DA850_EVM_=
UI_EXP_SEL_A]);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("Cannot open UI expander pi=
n %d\n", sel_a);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exp_setup_sela_fail;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D gpio_request(sel_b, "sel_b");
> + =A0 =A0 =A0 ret =3D gpio_request(sel_b, da850_evm_ui_exp[DA850_EVM_=
UI_EXP_SEL_B]);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("Cannot open UI expander pi=
n %d\n", sel_b);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exp_setup_selb_fail;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D gpio_request(sel_c, "sel_c");
> + =A0 =A0 =A0 ret =3D gpio_request(sel_c, da850_evm_ui_exp[DA850_EVM_=
UI_EXP_SEL_C]);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("Cannot open UI expander pi=
n %d\n", sel_c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exp_setup_selc_fail;
> @@ -420,13 +420,13 @@ static int da850_evm_ui_expander_teardown(struc=
t i2c_client *client,
> =A0 =A0 =A0 =A0platform_device_unregister(&da850_evm_ui_keys_device);
>
> =A0 =A0 =A0 =A0/* deselect all functionalities */
> - =A0 =A0 =A0 gpio_set_value_cansleep(gpio + 5, 1);
> - =A0 =A0 =A0 gpio_set_value_cansleep(gpio + 6, 1);
> - =A0 =A0 =A0 gpio_set_value_cansleep(gpio + 7, 1);
> + =A0 =A0 =A0 gpio_set_value_cansleep(gpio + DA850_EVM_UI_EXP_SEL_C, =
1);
> + =A0 =A0 =A0 gpio_set_value_cansleep(gpio + DA850_EVM_UI_EXP_SEL_B, =
1);
> + =A0 =A0 =A0 gpio_set_value_cansleep(gpio + DA850_EVM_UI_EXP_SEL_A, =
1);
>
> - =A0 =A0 =A0 gpio_free(gpio + 5);
> - =A0 =A0 =A0 gpio_free(gpio + 6);
> - =A0 =A0 =A0 gpio_free(gpio + 7);
> + =A0 =A0 =A0 gpio_free(gpio + DA850_EVM_UI_EXP_SEL_C);
> + =A0 =A0 =A0 gpio_free(gpio + DA850_EVM_UI_EXP_SEL_B);
> + =A0 =A0 =A0 gpio_free(gpio + DA850_EVM_UI_EXP_SEL_A);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.0.4
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-sourc=
e
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
