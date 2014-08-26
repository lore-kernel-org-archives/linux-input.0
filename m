From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/3] Don't copy more than 'count' byte
Date: Tue, 26 Aug 2014 17:23:45 -0400
Message-ID: <CAN+gG=FomT2y_TY3=H9gwFhzy-aDKDSZZzcfcem3ey4vhtW=zQ@mail.gmail.com>
References: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
	<1408797629-3474-2-git-send-email-kreijack@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:37868 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbaHZVXq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 17:23:46 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so16067167qcv.26
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2014 14:23:45 -0700 (PDT)
In-Reply-To: <1408797629-3474-2-git-send-email-kreijack@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Goffredo Baroncelli <kreijack@inwind.it>

On Sat, Aug 23, 2014 at 8:40 AM, Goffredo Baroncelli <kreijack@gmail.com> wrote:
> Don't copy more than 'count' byte, because *buf may be
> shorter than DJREPORT_SHORT_LENGTH,and this means an
> access violation. Of course count cannot be greather
> than the result buffer.

That's a really good catch, but one week late :)
See https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=51217e69697fba92a06e07e16f55c9a52d8e8945

Cheers,
Benjamin

>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  drivers/hid/hid-logitech-dj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 486dbde..ca0ab51 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -557,7 +557,7 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
>         if (!out_buf)
>                 return -ENOMEM;
>
> -       if (count < DJREPORT_SHORT_LENGTH - 2)
> +       if (count > DJREPORT_SHORT_LENGTH - 2)
>                 count = DJREPORT_SHORT_LENGTH - 2;
>
>         out_buf[0] = REPORT_ID_DJ_SHORT;
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
