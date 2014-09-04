From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 7/7] Input: cros_ec_keyb: Optimize ghosting algorithm.
Date: Wed, 3 Sep 2014 17:06:43 -0700
Message-ID: <20140904000643.GA8034@core.coreip.homeip.net>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408974008-17184-8-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408974008-17184-8-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 25, 2014 at 03:40:08PM +0200, Javier Martinez Canillas wrot=
e:
> From: Todd Broch <tbroch@chromium.org>
>=20
> Previous algorithm was a bit conservative and complicating with
> respect to identifying key ghosting.  This CL uses the bitops hamming
> weight function (hweight8) to count the number of matching rows for
> colM & colN.  If that number is > 1 ghosting is present.
>=20
> Additionally it removes NULL keys and our one virtual keypress
> KEY_BATTERY from consideration as these inputs are never physical
> keypresses.
>=20
> Signed-off-by: Todd Broch <tbroch@chromium.org>
> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
> Reviewed-by: Luigi Semenzato <semenzato@chromium.org>
> Tested-by: Andreas F=E4rber <afaerber@suse.de>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>

Applied, thank you.

--=20
Dmitry
