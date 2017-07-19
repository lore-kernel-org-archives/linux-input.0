From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v3 4/4] i2c: rcar: check for DMA-capable
	buffers
Date: Wed, 19 Jul 2017 11:42:24 +0200
Message-ID: <20170719094224.GO28538@bigcity.dyn.berto.se>
References: <20170718102339.28726-1-wsa+renesas@sang-engineering.com>
 <20170718102339.28726-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170718102339.28726-5-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Wolfram,

On 2017-07-18 12:23:39 +0200, Wolfram Sang wrote:
> Handling this is special for this driver. Because the hardware needs to
> initialize the next message in interrupt context, we cannot use the
> i2c_check_msg_for_dma() directly. This helper only works reliably in
> process context. So, we need to check during initial preparation of the
> whole transfer and need to disable DMA completely for the whole transfer
> once a message with a not-DMA-capable buffer is found.
> =

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 93c1a54981df08..5d0e820d708853 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -111,8 +111,11 @@
>  #define ID_ARBLOST	(1 << 3)
>  #define ID_NACK		(1 << 4)
>  /* persistent flags */
> +#define ID_P_NODMA	(1 << 30)
>  #define ID_P_PM_BLOCKED	(1 << 31)
> -#define ID_P_MASK	ID_P_PM_BLOCKED
> +#define ID_P_MASK	(ID_P_PM_BLOCKED | ID_P_NODMA)
> +
> +#define RCAR_DMA_THRESHOLD 8
>  =

>  enum rcar_i2c_type {
>  	I2C_RCAR_GEN1,
> @@ -358,8 +361,7 @@ static void rcar_i2c_dma(struct rcar_i2c_priv *priv)
>  	unsigned char *buf;
>  	int len;
>  =

> -	/* Do not use DMA if it's not available or for messages < 8 bytes */
> -	if (IS_ERR(chan) || msg->len < 8)
> +	if (IS_ERR(chan) || msg->len < RCAR_DMA_THRESHOLD || priv->flags & ID_P=
_NODMA)
>  		return;
>  =

>  	if (read) {
> @@ -657,11 +659,15 @@ static void rcar_i2c_request_dma(struct rcar_i2c_pr=
iv *priv,
>  				 struct i2c_msg *msg)
>  {
>  	struct device *dev =3D rcar_i2c_priv_to_dev(priv);
> -	bool read;
> +	bool read =3D msg->flags & I2C_M_RD;
>  	struct dma_chan *chan;
>  	enum dma_transfer_direction dir;
>  =

> -	read =3D msg->flags & I2C_M_RD;
> +	/* we need to check here because we need the 'current' context */

Maybe extend the comment here explaining that the check is primary here =

to make sure the msg->buf is valid for DMA and that the bounce buffer =

can't be used due to the special hardware feature? Else someone might be =

tempted to try and enable the bounce buffer feature in the future?

Nitpicking aside:

Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>

> +	if (i2c_check_msg_for_dma(msg, RCAR_DMA_THRESHOLD, NULL) =3D=3D -EFAULT=
) {
> +		dev_dbg(dev, "skipping DMA for this whole transfer\n");
> +		priv->flags |=3D ID_P_NODMA;
> +	}
>  =

>  	chan =3D read ? priv->dma_rx : priv->dma_tx;
>  	if (PTR_ERR(chan) !=3D -EPROBE_DEFER)
> @@ -740,6 +746,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *a=
dap,
>  	if (ret < 0 && ret !=3D -ENXIO)
>  		dev_err(dev, "error %d : %x\n", ret, priv->flags);
>  =

> +	priv->flags &=3D ~ID_P_NODMA;
> +
>  	return ret;
>  }
>  =

> -- =

> 2.11.0
> =


-- =

Regards,
Niklas S=F6derlund
