From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: fix Bamboo ONE oops
Date: Mon, 28 Mar 2016 09:56:27 -0700
Message-ID: <CAF8JNh+tY-4QA1911t5uA9B+_u_VqrGvEAfhNbhuayxmtzQDOQ@mail.gmail.com>
References: <1458916015-27658-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33778 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbcC1Q4s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2016 12:56:48 -0400
In-Reply-To: <1458916015-27658-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Mar 25, 2016 at 7:26 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Looks like recent changes in the Wacom driver made the Bamboo ONE crashes.
> The tablet behaves as if it was a regular Bamboo device with pen, touch
> and pad, but there is no physical pad connected to it.
> The weird part is that the pad is still sending events and given that
> there is no input node connected to it, we get  anull pointer exception.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1317116
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Acked-by: Ping Cheng <pingc@wacom.com>

Thank you Benjamin for the fix.

> ---
> Hi Jiri,

As Benjamin mentioned, both users tested the patch. Since their
testing was on kernel 4.4, we need to backport the patch to 4.4. Do
you need us to make a patch for 4.4 or will you take care of stable as
well?

Thanks,

Ping

>
> This fixes the oopses we saw on the Bamboo ONE.
> The fedora user is fine, and it appears the sourceforge user too, as the
> problems were due to misconfigurations on his end.
>
> Cheers,
> Benjamin
>
>  drivers/hid/wacom_wac.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index bd198bb..02c4efe 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2426,6 +2426,17 @@ void wacom_setup_device_quirks(struct wacom *wacom)
>         }
>
>         /*
> +        * Hack for the Bamboo One:
> +        * the device presents a PAD/Touch interface as most Bamboos and even
> +        * sends ghosts PAD data on it. However, later, we must disable this
> +        * ghost interface, and we can not detect it unless we set it here
> +        * to WACOM_DEVICETYPE_PAD or WACOM_DEVICETYPE_TOUCH.
> +        */
> +       if (features->type == BAMBOO_PEN &&
> +           features->pktlen == WACOM_PKGLEN_BBTOUCH3)
> +               features->device_type |= WACOM_DEVICETYPE_PAD;
> +
> +       /*
>          * Raw Wacom-mode pen and touch events both come from interface
>          * 0, whose HID descriptor has an application usage of 0xFF0D
>          * (i.e., WACOM_VENDORDEFINED_PEN). We route pen packets back
> --
> 2.5.0
>
