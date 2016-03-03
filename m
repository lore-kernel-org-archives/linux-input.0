From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch
 driver
Date: Wed, 02 Mar 2016 18:44:10 -0800
Message-ID: <1456973050.4044.81.camel@perches.com>
References: <1456972150-32303-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456972150-32303-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>, dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org, scott.liu@emc.com.tw
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2016-03-03 at 10:29 +0800, jeffrey.lin wrote:
> This patch is porting Raydium I2C touch driver. Developer can enable =
raydium touch driver by modifying define "CONFIG_TOUCHSCREEN_RM_TS".

trivial comments:

> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/inp=
ut/touchscreen/raydium_i2c_ts.c
[]
> +static int raydium_i2c_send(struct i2c_client *client,
> +	u8 addr, u8 *data, size_t len)
> +{
> +	u8 buf[MAX_PACKET_SIZE + 1];
> +	int i, tries =3D 0;
> +
> +	if (len > MAX_PACKET_SIZE)
> +		return -EINVAL;
> +
> +	buf[0] =3D addr & 0xff;

Seems pointless to use & 0xff when both
buf and addr are u8

> +	for (i =3D 0; i < len; i++)
> +		buf[i + 1] =3D *data++;

memcpy. =A0Maybe:

	buf[0] =3D addr;
	memcpy(&buf[1], data, len);

> +static int raydium_i2c_send_message(struct i2c_client *client,
> +	size_t len, void *data)
> +{
> +	int error;
> +	u8 buf[HEADER_SIZE], ii;
> +
> +	for (ii =3D 0; ii < HEADER_SIZE; ii++)
> +		buf[ii] =3D ((u8 *)data)[3 - ii];
> +	/*set data bank*/
> +	error =3D raydium_i2c_send(client, CMD_BANK_SWITCH,
> +		(u8 *)buf, HEADER_SIZE);
> +
> +	/*send messange*/

typo, message

> +	if (!error)
> +		error =3D raydium_i2c_send(client, buf[ADDR_INDEX], buf, len);
> +
> +	return error;
> +}
> +
> +static int raydium_i2c_sw_reset(struct i2c_client *client)
> +{
> +	const u8 soft_rst_cmd[] =3D { 0x01, 0x04, 0x00, 0x00, 0x40};

static

> +	int error;
> +
> +	error =3D raydium_i2c_send_message(client,
> +			1, (void *)soft_rst_cmd);

could be better on a single line

> +static int raydium_i2c_fastboot(struct i2c_client *client)
> +{
> +	const u8 boot_cmd[] =3D { 0x20, 0x06, 0x00, 0x50 };
> +	u8 buf[HEADER_SIZE];
> +	int error;
> +
> +	error =3D raydium_i2c_read_message(client,
> +		get_unaligned_be32(boot_cmd),
> +		sizeof(boot_cmd),
> +		buf);
> +
> +	if (error) {
> +		dev_err(&client->dev, "boot failed: %d\n", error);
> +		return error;
> +	} else if (buf[0] =3D=3D RM_BOOT_BLDR) {

unnecessary else

> +		dev_dbg(&client->dev, "boot in fastboot mode\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&client->dev, "boot success -- 0x%x\n", client->addr);
> +	return 0;
> +}
> +
> +static int raydium_i2c_initialize(struct raydium_data *ts)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int error, retry_cnt;
> +	const u8 recov_packet[] =3D { 0x04, 0x81 };

static and etc...

generally, it'd be nice to align to open parenthesis and
to more maximally fill lines to 80 chars instead of using
relatively short line lengths and multiple line statements.
