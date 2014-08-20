From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RESEND PATCH 3/7] mfd: cros_ec: stop calling ->cmd_xfer() directly
Date: Wed, 20 Aug 2014 15:33:47 -0700
Message-ID: <CAD=FV=XHK_=kxuVmgpDBYWGCFfiVEAuy_BV+YdKi_a2p-rfKrQ@mail.gmail.com>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
	<1408536812-7836-4-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:58754 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbaHTWds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2014 18:33:48 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so9744443vcb.7
        for <linux-input@vger.kernel.org>; Wed, 20 Aug 2014 15:33:48 -0700 (PDT)
In-Reply-To: <1408536812-7836-4-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Javier,

On Wed, Aug 20, 2014 at 5:13 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>
> Instead of having users of the ChromeOS EC call the interface-specific
> cmd_xfer() callback directly, introduce a central cros_ec_cmd_xfer()
> to use instead.  This will allow us to put all the locking and retry
> logic in one place instead of duplicating it across the different
> drivers.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c |  2 +-
>  drivers/input/keyboard/cros_ec_keyb.c   |  2 +-
>  drivers/mfd/cros_ec.c                   |  7 +++++++
>  include/linux/mfd/cros_ec.h             | 24 ++++++++++++++++++------
>  4 files changed, 27 insertions(+), 8 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
