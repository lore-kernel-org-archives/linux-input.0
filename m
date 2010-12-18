From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/4] Input: synaptics - ignore bogus mt packet
Date: Sat, 18 Dec 2010 11:05:08 -0600
Message-ID: <AANLkTinso7BZB4GxgsQshaGeka+CcjUtjB9Agdj3qFnz@mail.gmail.com>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
	<1292683981-6908-3-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45633 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597Ab0LRRFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 12:05:09 -0500
In-Reply-To: <1292683981-6908-3-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 18, 2010 at 8:52 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> In multitouch mode, at least one device (fw: 7.4 id: 0x1c0b1) sometim=
es
> sends a final main packet with x =3D=3D 1. Since the normal values ar=
e above
> 1472, this is clearly bogus. At the same time, a two-finger touch is
> signaled, even though only one finger was on the pad to begin with. T=
his
> patch ignores the packet altogether, removing the problem.

I've seen this behavior as well although I thought it always came when
hw.z =3D=3D 0 so was masked.  I guess its not to surprising its sneakin=
g
threw with low pressures.

>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/input/mouse/synaptics.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index 8a769e9..4744064 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -526,7 +526,7 @@ static void synaptics_process_packet(struct psmou=
se *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (hw.z > 0) {
> + =A0 =A0 =A0 if (hw.z > 0 && hw.x > 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0num_fingers =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0finger_width =3D 5;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (SYN_CAP_EXTENDED(priv->capabilitie=
s)) {
> @@ -558,7 +558,7 @@ static void synaptics_process_packet(struct psmou=
se *psmouse)
> =A0 =A0 =A0 =A0if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
> =A0 =A0 =A0 =A0if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
>
> - =A0 =A0 =A0 if (hw.z > 0) {
> + =A0 =A0 =A0 if (hw.z > 0 && hw.x > 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, ABS_X, hw.x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, ABS_Y, YMAX_NOMI=
NAL + YMIN_NOMINAL - hw.y);
> =A0 =A0 =A0 =A0}

This might read better if we change to "if (num_fingers) {" and then
we do not need to repeat the hw work around logic twice.

Also, this snippet shows I may be seeing it as well but the
BTN_TOUCH=3D0 when < 25 is probably masking it for most cases.

Either way:

Acked-by: Chris Bagwell <chris@cnpbagwell.com>

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
