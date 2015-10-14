From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: rotary-encoder: Support 'steps-per-period' DT
 property
Date: Tue, 13 Oct 2015 23:55:18 -0700
Message-ID: <20151014065518.GG20406@dtor-ws>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1444398416-3073-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35975 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbbJNGzW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2015 02:55:22 -0400
Content-Disposition: inline
In-Reply-To: <1444398416-3073-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ariel@vanguardiasur.com.ar, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>

On Fri, Oct 09, 2015 at 10:46:56AM -0300, Ezequiel Garcia wrote:
> As per the recent devicetree binding changes, this commit adds the
> support for the new 'steps-per-period' property.
>=20
> Legacy properties to specify the rotary behavior, are now deprecated
> and instead the new 'steps-per-period' is supported. The default beha=
vior
> is retained.
>=20
> This allows to support rotary-encoder devices with detents wich are c=
apable
> of producing a stable event on each step.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/input/misc/rotary_encoder.c | 87 +++++++++++++++++++++++++++=
++++++++--
>  include/linux/rotary_encoder.h      |  2 +-
>  2 files changed, 84 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc=
/rotary_encoder.c
> index 15a4cc670a3f..e021615dd3c0 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -142,6 +142,55 @@ static irqreturn_t rotary_encoder_half_period_ir=
q(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *=
dev_id)
> +{
> +	struct rotary_encoder *encoder =3D dev_id;
> +	unsigned char sum;
> +	int state;
> +
> +	state =3D rotary_encoder_get_state(encoder->pdata);
> +
> +	/*
> +	 * We encode the previous and the current state using a byte.
> +	 * The previous state in the MSB nibble, the current state in the L=
SB
> +	 * nibble. Then use a table to decide the direction of the turn.
> +	 */
> +	sum =3D (encoder->last_stable << 4) + state;
> +	switch (sum) {
> +	case 0x31:
> +	case 0x10:
> +	case 0x02:
> +	case 0x23:
> +		encoder->dir =3D 0; /* clockwise */
> +		break;
> +
> +	case 0x13:
> +	case 0x01:
> +	case 0x20:
> +	case 0x32:
> +		encoder->dir =3D 1; /* counter-clockwise */
> +		break;
> +
> +	default:
> +		/*
> +		 * Ignore all other values. This covers the case when the
> +		 * state didn't change (a spurious interrupt) and the
> +		 * cases where the state changed by two steps, making it
> +		 * impossible to tell the direction.
> +		 *
> +		 * In either case, don't report any event and save the
> +		 * state for later.
> +		 */
> +		goto out;
> +	}
> +
> +	rotary_encoder_report_event(encoder);
> +
> +out:
> +	encoder->last_stable =3D state;
> +	return IRQ_HANDLED;
> +}
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id rotary_encoder_of_match[] =3D {
>  	{ .compatible =3D "rotary-encoder", },
> @@ -176,7 +225,26 @@ static struct rotary_encoder_platform_data *rota=
ry_encoder_parse_dt(struct devic
> =20
>  	pdata->relative_axis =3D of_property_read_bool(np, "rotary-encoder,=
relative-axis");
>  	pdata->rollover =3D of_property_read_bool(np, "rotary-encoder,rollo=
ver");
> -	pdata->half_period =3D of_property_read_bool(np, "rotary-encoder,ha=
lf-period");
> +
> +	if (!of_get_property(np, "rotary-encoder,steps-per-period", NULL)) =
{
> +		/*
> +		 * Fallback to a one step per period behavior if the
> +		 * 'steps-per-period' is not set.
> +		 */
> +		pdata->steps_per_period =3D 1;
> +	} else {
> +		of_property_read_u32(np, "rotary-encoder,steps-per-period",
> +				     &pdata->steps_per_period);
> +	}
> +
> +	/*
> +	 * The 'half-period' property has been deprecated, you must use
> +	 * 'steps-per-period' and set an appropriate value.
> +	 */
> +	if (of_get_property(np, "rotary-encoder,half-period", NULL)) {
> +		pr_warn(FW_WARN "\"rotary-encoder,half-period\" is deprecated\n");
> +		pdata->steps_per_period =3D 2;
> +	}

Hmm, I do not think we need to warn about old DTSes if we consider them
ABI. How about if we parse like this:

	error =3D of_property_read_u32(np, "rotary-encoder,steps-per-period",
				     &pdata->steps_per_period);
	if (error) {
		/*
		 * The 'half-period' property has been deprecated, you must use
		 * 'steps-per-period' and set an appropriate value, but we still
		 * need to parse it to maintain compatibility.
		 */
		if (of_property_read_bool(np, "rotary-encoder,half-period")) {
			pdata->steps_per_period =3D 2;
		} else {
			/* Fallback to a one step per period behavior */
			pdata->steps_per_period =3D 1;
		}
	}


(no need to resubmit if you are OK with this).

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
