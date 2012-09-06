From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH RESEND #4] dj: memory scribble in logi_dj
Date: Thu, 6 Sep 2012 13:39:42 +0200
Message-ID: <CAN+gG=F-KGrfBecqwRa_7LYHvzzRLZebN6hYuAv8NRAD3U6nEw@mail.gmail.com>
References: <20120904140924.26323.88903.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50133 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab2IFLjm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 07:39:42 -0400
Received: by iahk25 with SMTP id k25so1931980iah.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 04:39:42 -0700 (PDT)
In-Reply-To: <20120904140924.26323.88903.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

Hi Alan,

Sorry for not seeing this earlier.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Jiri, can this fall into upstream-fixes?

Thanks,
Benjamin

On Tue, Sep 4, 2012 at 4:10 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> I've been sending this to the input list and maintainer for a month now with
> no response, so this time it goes directly to Linus.
>
> From: Alan Cox <alan@linux.intel.com>
>
> Allocate a structure not a pointer to it !
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>
>  drivers/hid/hid-logitech-dj.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 0f9c146..4d524b5 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -439,7 +439,7 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
>         struct dj_report *dj_report;
>         int retval;
>
> -       dj_report = kzalloc(sizeof(dj_report), GFP_KERNEL);
> +       dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
>         if (!dj_report)
>                 return -ENOMEM;
>         dj_report->report_id = REPORT_ID_DJ_SHORT;
> @@ -456,7 +456,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
>         struct dj_report *dj_report;
>         int retval;
>
> -       dj_report = kzalloc(sizeof(dj_report), GFP_KERNEL);
> +       dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
>         if (!dj_report)
>                 return -ENOMEM;
>         dj_report->report_id = REPORT_ID_DJ_SHORT;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
