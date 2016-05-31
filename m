From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid-elo: kill not flush the work
Date: Tue, 31 May 2016 17:39:17 +0200
Message-ID: <CAN+gG=GUn3hbd8BCHTN2tSKFrvemo__L+AmHMzmMKWrXsRok8w@mail.gmail.com>
References: <1464698895-6788-1-git-send-email-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34519 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcEaPjT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 11:39:19 -0400
In-Reply-To: <1464698895-6788-1-git-send-email-oneukum@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Jiri Slaby <jslaby@suse.com>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, stable@vger.kernel.org

On Tue, May 31, 2016 at 2:48 PM, Oliver Neukum <oneukum@suse.com> wrote:
> Flushing a work that reschedules itself is not a sensible
> operation. It needs to be killed. Failure to do so leads
> to a kernel panic in the timer code.
>
> Signed-off-by: Oliver Neukum <ONeukum@suse.com>
> CC: stable@vger.kernel.org

Good catch.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!
Benjamin

> ---
>  drivers/hid/hid-elo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
> index aad8c16..0cd4f72 100644
> --- a/drivers/hid/hid-elo.c
> +++ b/drivers/hid/hid-elo.c
> @@ -261,7 +261,7 @@ static void elo_remove(struct hid_device *hdev)
>         struct elo_priv *priv = hid_get_drvdata(hdev);
>
>         hid_hw_stop(hdev);
> -       flush_workqueue(wq);
> +       cancel_delayed_work_sync(&priv->work);
>         kfree(priv);
>  }
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
