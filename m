From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] CHROMIUM: Input: synaptics - filter out the events with
 low z values
Date: Wed, 22 Feb 2012 00:35:09 +0800
Message-ID: <CAGS+omAK-dWjJjjDDXtwM90bTx--ngEL6KTtxzdcQGtd-xEPEQ@mail.gmail.com>
References: <1329836858-9369-1-git-send-email-cywang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:35461 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab2BUQfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 11:35:32 -0500
Received: by qafk1 with SMTP id k1so7290058qaf.19
        for <linux-input@vger.kernel.org>; Tue, 21 Feb 2012 08:35:31 -0800 (PST)
In-Reply-To: <1329836858-9369-1-git-send-email-cywang@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chung-yih Wang <cywang@chromium.org>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 21, 2012 at 11:07 PM, Chung-yih Wang <cywang@chromium.org> =
wrote:
> The single touch path imposes a minimum z value (with hysterisis) bef=
ore
> registering BTN_TOUCH. Apply the same (hard coded) threshold when
> deciding how many fingers to report in the semi-mt path.
>
> This patch improves performance of the Google Cr-48 chromebook's
> extremely sensitive Synaptics profile sensor touchpad by filtering ou=
t
> touch events for hovering fingers.
>
> Note: We continue to use the same hard coded threshold value used in =
the
> single touch case as it appears this works just as well on these
> multitouch profile sensor pads as on whatever pads it was originally
> discovered.
>
> Signed-off-by: Chung-Yih Wang <cywang@chromium.org>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
> =A0drivers/input/mouse/synaptics.c | =A0 12 +++++++++---
> =A01 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index 8081a0a..7936a1a 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -568,17 +568,22 @@ static void synaptics_report_semi_mt_slot(struc=
t input_dev *dev, int slot,
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static bool finger_touched(const struct synaptics_hw_state *hw)
> +{
> + =A0 =A0 =A0 return (hw->z > 30);
> +}
> +
> =A0static void synaptics_report_semi_mt_data(struct input_dev *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0const struct synaptics_hw_state *a,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0const struct synaptics_hw_state *b,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0int num_fingers)
> =A0{
> - =A0 =A0 =A0 if (num_fingers >=3D 2) {
> + =A0 =A0 =A0 if ((num_fingers >=3D 2) && finger_touched(a) && finger=
_touched(b)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0synaptics_report_semi_mt_slot(dev, 0, =
true, min(a->x, b->x),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0min(a->y, b->y));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0synaptics_report_semi_mt_slot(dev, 1, =
true, max(a->x, b->x),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0max(a->y, b->y));
> - =A0 =A0 =A0 } else if (num_fingers =3D=3D 1) {
> + =A0 =A0 =A0 } else if ((num_fingers =3D=3D 1) && finger_touched(a))=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0synaptics_report_semi_mt_slot(dev, 0, =
true, a->x, a->y);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0synaptics_report_semi_mt_slot(dev, 1, =
false, 0, 0);
> =A0 =A0 =A0 =A0} else {
> @@ -1040,7 +1045,8 @@ static void synaptics_process_packet(struct psm=
ouse *psmouse)
> =A0 =A0 =A0 =A0 * BTN_TOUCH has to be first as mousedev relies on it =
when doing
> =A0 =A0 =A0 =A0 * absolute -> relative conversion
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
> + =A0 =A0 =A0 if (finger_touched(&hw))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dev, BTN_TOUCH, 1);
> =A0 =A0 =A0 =A0if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
>
> =A0 =A0 =A0 =A0if (num_fingers > 0) {
> --
> 1.7.7.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
