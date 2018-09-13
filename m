From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech: fix a used uninitialized GCC warning
Date: Thu, 13 Sep 2018 09:01:47 +0200
Message-ID: <CAO-hwJJAGdUokt4rByNFsit1bY8t3ZpV3CFh-ES7-GNukZTBLw@mail.gmail.com>
References: <1536810739-27342-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536810739-27342-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhongjiang@huawei.com
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 13, 2018 at 6:04 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> Fix the following compile warning:
>
> drivers/hid/hid-logitech-hidpp.c: In function ‘hi_res_scroll_enable’:
> drivers/hid/hid-logitech-hidpp.c:2714:54: warning: ‘multiplier’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 5f0c080..83c43dd 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2696,7 +2696,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
>  static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>  {
>         int ret;
> -       u8 multiplier;
> +       u8 uninitialized_var(multiplier);

I think your patch is correct (multiplier will be set given the code
path), but IMO, it feels terribly wrong to explicitly remove this
warning this way. The problem is that if someone else adds a new piece
of code, we might miss the fact that multiplier is not set and we
might show garbage in the hid_info call.

Why don't you initialize the value to 8 as in the 'else' statement and
remove the now duplicated assignement in this else statement?

Cheers,
Benjamin

>
>         if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
>                 ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> --
> 1.7.12.4
>
