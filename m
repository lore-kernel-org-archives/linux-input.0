From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 7/7] Input: cros_ec_keyb: Optimize ghosting algorithm.
Date: Tue, 29 Jul 2014 15:08:16 +0200
Message-ID: <53D79CC0.9050508@suse.de>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk> <1406549967-21291-8-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406549967-21291-8-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 28.07.2014 14:19, schrieb Javier Martinez Canillas:
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

This seems to fix my Ctrl+O problems on Spring reported a while ago,

Tested-by: Andreas F=E4rber <afaerber@suse.de>

Thanks,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
