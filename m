From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 1/7] mfd: cros_ec: Delay for 50ms when we see
 EC_CMD_REBOOT_EC
Date: Thu, 21 Aug 2014 14:37:47 +0100
Message-ID: <20140821133747.GJ4266@lee--X1>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408536812-7836-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408536812-7836-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:
> From: Doug Anderson <dianders@chromium.org>
>=20
> If someone sends a EC_CMD_REBOOT_EC to the EC, the EC will likely be
> unresponsive for quite a while.  Add a delay to the end of the comman=
d
> to prevent random failures of future commands.
>=20
> NOTES:
> * This could be optimized a bit by simply delaying the next command
>   sent, but EC_CMD_REBOOT_EC is such a rare command that the extra
>   complexity doesn't seem worth it.
> * This is a bit of an "ugly hack" since the SPI driver is effectively
>   snooping on the communication and making a lot of assumptions.  It
>   would be nice to architect in some better solution long term.

Are you planning on doing that?

> * This same logic probably needs to be applied to the i2c driver.
>=20
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Randall Spangler <rspangler@chromium.org>
> Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>
> ---
>  drivers/mfd/cros_ec_spi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I'm willing to accept this as a stand-in.

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
