From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/5] Input: synaptics - Query min dimensions for fw v8.1
Date: Fri, 6 Feb 2015 09:32:57 -0500
Message-ID: <CAN+gG=GddThbP6zDuhnzsWXecyvFSZDLYVRWsr=9WhdqGJ5sfg@mail.gmail.com>
References: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
	<1423229108-29268-4-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:48618 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbbBFOc5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 09:32:57 -0500
Received: by mail-qc0-f180.google.com with SMTP id r5so11938813qcx.11
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2015 06:32:57 -0800 (PST)
In-Reply-To: <1423229108-29268-4-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <consume.noise@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Thanks Daniel for the respin.

On Fri, Feb 6, 2015 at 8:25 AM, Daniel Martin <daniel.martin@secunet.com> wrote:
> From: Daniel Martin <consume.noise@gmail.com>
>
> Query the min dimensions even if the check
>     SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
> fails, but we know that the firmware version 8.1 is safe.
>
> With that we don't need quirks for post-2013 models anymore as they
> expose correct min and max dimensions.
>
> v2: Don't use a list for safe firmwares.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 7a78d75..0b7805c 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -368,8 +368,13 @@ static int synaptics_resolution(struct psmouse *psmouse)
>                 }
>         }
>
> -       if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
> -           SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
> +       if ((SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
> +            SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) ||
> +           /* Firmware v8.1 doesn't stand the previous checks, though has
> +            * been proven to report correct min coordinates.
> +            *     https://bugzilla.kernel.org/show_bug.cgi?id=91541 */
> +           (SYN_ID_MAJOR(priv->identity) == 8 &&
> +            SYN_ID_MINOR(priv->identity) == 1)) {

I have one minor comment here. I think it will be safer to ask for:

if (SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c) &&
   (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
    /* Firmware v8.1 doesn't stand the previous checks, though has
     * been proven to report correct min coordinates.
     *     https://bugzilla.kernel.org/show_bug.cgi?id=91541 */
     (SYN_ID_MAJOR(priv->identity) == 8 &&
      SYN_ID_MINOR(priv->identity) == 1)))

IIRC, the min_dimension bit was properly set, but not the capability >= 7.

I am not sure if all the boards with the 8.1 FW are able to be queried
on the min coordinate.

Cheers,
Benjamin

>                 if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
>                         psmouse_warn(psmouse,
>                                      "device claims to have min coordinates query, but I'm not able to read it.\n");
> --
> 2.2.2
>
