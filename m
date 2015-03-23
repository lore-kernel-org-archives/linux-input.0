From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 2/5] input: synaptics - change default width value of
 cr48 sensors
Date: Mon, 23 Mar 2015 16:48:15 -0400
Message-ID: <CAN+gG=H7KUsuCgdNDpra8pqS3xcxrXBDHr0FG+tVgqFHWDJV5Q@mail.gmail.com>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
	<1427035436-2168-3-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33600 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbbCWUsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 16:48:19 -0400
In-Reply-To: <1427035436-2168-3-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Maxwell Anselm <silverhammermba@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Hans de Goede <hdegoede@redhat.com>, grafi@grafi.jp, Oliver Neukum <oneukum@suse.de>

On Sun, Mar 22, 2015 at 10:43 AM, Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
> The minimum value these sensors can report is 4, so this should be the
> value used when W is not reporting the width.
>
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 133e488..a7a0e73 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1018,7 +1018,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
>
>         if (hw.z > 0 && hw.x > 1) {
>                 num_fingers = 1;
> -               finger_width = 5;
> +               finger_width = 4;

I am not sure about this change. It looks benign, but I don't get how
changing the local variable finger_width can change anything in the
CR48 processing.

Except for this one (which could be dropped IMO), the *rest* of the series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for pushing this Gabriele.

Cheers,
Benjamin

>                 if (SYN_CAP_EXTENDED(priv->capabilities)) {
>                         switch (hw.w) {
>                         case 0 ... 1:
> --
> 2.1.4
>
