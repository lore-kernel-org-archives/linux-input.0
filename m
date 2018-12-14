From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for  optional regulators
Date: Fri, 14 Dec 2018 16:11:49 +0100
Message-ID: <2132818.BxtBPRaDeS@acerlaptop>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com> <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com> <20181209042612.GD211094@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181209042612.GD211094@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dnia niedziela, 9 grudnia 2018 05:26:12 CET Dmitry Torokhov pisze:
> On Fri, Dec 07, 2018 at 03:28:55PM +0100, Pawe=C5=82 Chmiel wrote:
> > This patch adds optional regulators, which can be used to power
> > up touchscreen. After enabling regulators, we need to wait 150msec.
> > This value is taken from official driver.
> >=20
> > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v3:
> >   - Fix checkpatch issues
> >   - Drop sentence punctuation from subject of one of patches
> >=20
> > Changes from v2:
> >   - Move code enabling regulators into separate method,
> >     to make code more readable.
> >=20
> > Changes from v1:
> >   - Enable regulators only if reset_gpio is present.
> >   - Switch from devm_regulator_get_optional to devm_regulator_get
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
> > index d3aacd534e9c..1dc8ad0da5af 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/of.h>
> >  #include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <asm/unaligned.h>
> > @@ -194,10 +195,10 @@ enum t100_type {
> > =20
> >  /* Delay times */
> >  #define MXT_BACKUP_TIME		50	/* msec */
> > -#define MXT_RESET_GPIO_TIME	20	/* msec */
> >  #define MXT_RESET_INVALID_CHG	100	/* msec */
> >  #define MXT_RESET_TIME		200	/* msec */
> >  #define MXT_RESET_TIMEOUT	3000	/* msec */
> > +#define MXT_REGULATOR_DELAY	150	/* msec */
> >  #define MXT_CRC_TIMEOUT		1000	/* msec */
> >  #define MXT_FW_RESET_TIME	3000	/* msec */
> >  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> > @@ -323,6 +324,8 @@ struct mxt_data {
> >  	struct t7_config t7_cfg;
> >  	struct mxt_dbg dbg;
> >  	struct gpio_desc *reset_gpio;
> > +	struct regulator *vdd_reg;
> > +	struct regulator *avdd_reg;
> > =20
> >  	/* Cached parameters from object table */
> >  	u16 T5_address;
> > @@ -3038,6 +3041,38 @@ static const struct dmi_system_id chromebook_T9_=
suspend_dmi[] =3D {
> >  	{ }
> >  };
> > =20
> > +static int mxt_regulator_enable(struct mxt_data *data)
> > +{
> > +	int error;
> > +
> > +	if (data->reset_gpio) {
> > +		error =3D regulator_enable(data->vdd_reg);
> > +		if (error) {
> > +			dev_err(&data->client->dev,
> > +				"Failed to enable vdd regulator: %d\n", error);
> > +			return error;
> > +		}
> > +
> > +		error =3D regulator_enable(data->avdd_reg);
> > +		if (error) {
> > +			dev_err(&data->client->dev,
> > +				"Failed to enable avdd regulator: %d\n", error);
>=20
> This leaves vdd regulator enabled.
Will be fixed in v5 version (will be today)
Thanks for review.
>=20
> Thanks.
>=20
>=20
