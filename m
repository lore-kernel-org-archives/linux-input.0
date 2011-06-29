From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 03/12] Input: synaptics - fix minimum reported ABS_TOOL_WIDTH
Date: Wed, 29 Jun 2011 08:28:26 -0500
Message-ID: <BANLkTinX-mkjQ=qMXra5GLeMK+cb9w+9_Q@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
	<1309324042-22943-4-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34178 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1F2N21 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 09:28:27 -0400
In-Reply-To: <1309324042-22943-4-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jun 29, 2011 at 12:07 AM,  <djkurtz@chromium.org> wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
>
> Synaptics touchpads report a 'w' value in each data report.
> For touchpads that support palm detection, when there is a single fin=
ger
> on the pad, the 'w' value reports its width in the range 4 to 15.
> Thus, the minimum valid width is 4.

=46YI: I had debated on this as well.  When driver was first modified t=
o
report min/max width, the min width of zero was chosen because when
not touching the pad a value of zero is forced by driver to user.  So
the range is 0, 4-15.

>
> Note: Other values of 'w' are used to report special conditions:
> =A0w=3D0: 2 fingers are on the pad
> =A0w=3D1: 3 or more fingers are on the pad
> =A0w=3D2: the packet contains "Advanced Gesture Mode" data.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> =A0drivers/input/mouse/synaptics.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index f6d0c04..a4b7801 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -706,7 +706,7 @@ static void set_input_params(struct input_dev *de=
v, struct synaptics_data *priv)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (SYN_CAP_PALMDETECT(priv->capabilities))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_TOOL_WIDT=
H, 0, 15, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_TOOL_WIDT=
H, 4, 15, 0, 0);
>
> =A0 =A0 =A0 =A0__set_bit(EV_KEY, dev->evbit);
> =A0 =A0 =A0 =A0__set_bit(BTN_TOUCH, dev->keybit);
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
