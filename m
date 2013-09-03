From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] hid-wiimote: print small buffers via %*ph
Date: Tue, 3 Sep 2013 15:21:58 +0200
Message-ID: <CANq1E4R-7PSRKFuk=mkcELKw7xYwr4GB9ZJmUcZ6BHnQQK1JTQ@mail.gmail.com>
References: <1378211544-16594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63946 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759923Ab3ICNV7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 09:21:59 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so10636354iea.9
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 06:21:58 -0700 (PDT)
In-Reply-To: <1378211544-16594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Sep 3, 2013 at 2:32 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Instead of passing each byte through stack let's use %*ph specifier to dump
> buffer as a hex string.

I'd actually prefer %*phC to make grep'ing for these things easier.
Apart from that:

Acked-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/hid-wiimote-core.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
> index 6602098..ad3ac57 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -441,8 +441,7 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
>         if (ret != 6)
>                 return WIIMOTE_EXT_NONE;
>
> -       hid_dbg(wdata->hdev, "extension ID: %02x:%02x %02x:%02x %02x:%02x\n",
> -               rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
> +       hid_dbg(wdata->hdev, "extension ID: %6ph\n", rmem);
>
>         if (rmem[0] == 0xff && rmem[1] == 0xff && rmem[2] == 0xff &&
>             rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
> @@ -512,14 +511,12 @@ static bool wiimote_cmd_read_mp(struct wiimote_data *wdata, __u8 *rmem)
>         if (ret != 6)
>                 return false;
>
> -       hid_dbg(wdata->hdev, "motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
> -               rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
> +       hid_dbg(wdata->hdev, "motion plus ID: %6ph\n", rmem);
>
>         if (rmem[5] == 0x05)
>                 return true;
>
> -       hid_info(wdata->hdev, "unknown motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
> -                rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
> +       hid_info(wdata->hdev, "unknown motion plus ID: %6ph\n", rmem);
>
>         return false;
>  }
> @@ -535,8 +532,7 @@ static __u8 wiimote_cmd_read_mp_mapped(struct wiimote_data *wdata)
>         if (ret != 6)
>                 return WIIMOTE_MP_NONE;
>
> -       hid_dbg(wdata->hdev, "mapped motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
> -               rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
> +       hid_dbg(wdata->hdev, "mapped motion plus ID: %6ph\n", rmem);
>
>         if (rmem[0] == 0xff && rmem[1] == 0xff && rmem[2] == 0xff &&
>             rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
> @@ -1128,9 +1124,8 @@ static void wiimote_init_hotplug(struct wiimote_data *wdata)
>                 wiimote_ext_unload(wdata);
>
>                 if (exttype == WIIMOTE_EXT_UNKNOWN) {
> -                       hid_info(wdata->hdev, "cannot detect extension; %02x:%02x %02x:%02x %02x:%02x\n",
> -                                extdata[0], extdata[1], extdata[2],
> -                                extdata[3], extdata[4], extdata[5]);
> +                       hid_info(wdata->hdev, "cannot detect extension; %6ph\n",
> +                                extdata);
>                 } else if (exttype == WIIMOTE_EXT_NONE) {
>                         spin_lock_irq(&wdata->state.lock);
>                         wdata->state.exttype = WIIMOTE_EXT_NONE;
> --
> 1.8.4.rc3
>
