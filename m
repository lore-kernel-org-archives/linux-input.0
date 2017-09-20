From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] HID: hidraw: fix power sequence when closing device
Date: Tue, 19 Sep 2017 18:45:46 -0700
Message-ID: <CABXOdTewO038WH89vG+Kw9UT+xBu9hgPViLVveWkr6SrnekjNw@mail.gmail.com>
References: <20170920013746.GA33367@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:47791 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdITBpr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 21:45:47 -0400
Received: by mail-yw0-f178.google.com with SMTP id t127so960255ywg.4
        for <linux-input@vger.kernel.org>; Tue, 19 Sep 2017 18:45:47 -0700 (PDT)
In-Reply-To: <20170920013746.GA33367@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Oliver Neukum <oneukum@suse.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Sep 19, 2017 at 6:37 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> We should not try to bring HID device out of full power state before
> calling hid_hw_close(), so that transport driver operates on powered up
> device (making this inverse of the opening sequence).
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/hid/hidraw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index ec530454e6f6..5fbe0f81ab2e 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -337,8 +337,8 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
>                         kfree(hidraw);
>                 } else {
>                         /* close device for last reader */
> -                       hid_hw_power(hidraw->hid, PM_HINT_NORMAL);
>                         hid_hw_close(hidraw->hid);
> +                       hid_hw_power(hidraw->hid, PM_HINT_NORMAL);
>                 }
>         }
>  }
> --
> 2.14.1.821.g8fa685d3b7-goog
>
>
> --
> Dmitry
