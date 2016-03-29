From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: multitouch: Synchronize MT frame on reset_resume
Date: Tue, 29 Mar 2016 13:36:11 -0700
Message-ID: <CANLzEkv1gLe2Ay2OQLbgSOoYU9Ar1VN_xT7fAkzD=1QNYXjm7Q@mail.gmail.com>
References: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33650 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbcC2UgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 16:36:12 -0400
Received: by mail-vk0-f44.google.com with SMTP id k1so35067667vkb.0
        for <linux-input@vger.kernel.org>; Tue, 29 Mar 2016 13:36:12 -0700 (PDT)
In-Reply-To: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>

Hi Gabriele,

Thanks for the fix!

On Tue, Mar 29, 2016 at 1:10 PM, Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
> input_mt_get_slot_by_key() requires input_mt_sync_frame() to be called
> at each frame. Do it when releasing the touches, or else we won't get
> a proper slot number after mt_reset_resume().
>
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/hid/hid-multitouch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 25d3c43..c741f5e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1169,6 +1169,7 @@ static void mt_release_contacts(struct hid_device *hid)
>                                                            MT_TOOL_FINGER,
>                                                            false);
>                         }
> +                       input_mt_sync_frame(input_dev);
>                         input_sync(input_dev);
>                 }
>         }
> --
> 2.8.0.rc3
>



-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
