From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] staging/iio/adc/MXS/LRADC: fix touchscreen statemachine
Date: Mon, 24 Feb 2014 17:48:17 +0100
Message-ID: <20140224164817.GE4436@piout.net>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de>
 <20140224133316.GI26722@mwanda>
 <201402241539.53707.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <201402241539.53707.jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, jic23@cam.ac.uk
List-Id: linux-input@vger.kernel.org

On 24/02/2014 at 15:39:53 +0100, Juergen Beisert wrote :
> Releasing the touchscreen lets the internal statemachine left in a wrong =
state.
> Due to this the release coordinate will be reported again by accident whe=
n the next
> touchscreen event happens. This change sets up the correct state when wai=
ting
> for the next touchscreen event.
>     =

> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> =


Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/ad=
c/mxs-lradc.c
> index 7fc66a6..514844e 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -757,6 +757,7 @@ static void mxs_lradc_finish_touch_event(struct mxs_l=
radc *lradc, bool valid)
>  	}
>  =

>  	/* if it is released, wait for the next touch via IRQ */
> +	lradc->cur_plate =3D LRADC_TOUCH;
>  	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
>  	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
>  }
> =

> -- =

> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
> Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutro=
nix.de/  |

-- =

Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
