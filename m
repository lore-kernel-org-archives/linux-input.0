From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RESEND PATCH 4/7] mfd: cros_ec: move locking into cros_ec_cmd_xfer
Date: Wed, 20 Aug 2014 15:36:01 -0700
Message-ID: <CAD=FV=WAMKrmDTQbDrjR2XtFcNVUuzJfWspN5a7nE7kLWS9=4A@mail.gmail.com>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
	<1408536812-7836-5-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1408536812-7836-5-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Javier,

On Wed, Aug 20, 2014 at 5:13 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>
> Now that there's a central cros_ec_cmd_xfer(), move the locking
> out of the SPI and LPC drivers.

Slight nit that the LPC driver doesn't exist upstream.  This is in
prep for adding the LPC driver, though.


> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/mfd/cros_ec.c     | 10 +++++++++-
>  drivers/mfd/cros_ec_spi.c | 11 -----------
>  2 files changed, 9 insertions(+), 12 deletions(-)

After comment nitfix:

Reviewed-by: Doug Anderson <dianders@chromium.org>
