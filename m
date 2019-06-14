From: Enrico Granata <egranata@google.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date: Fri, 14 Jun 2019 11:27:03 -0700
Message-ID: <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614065438.142867-1-phoenixshen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ting Shen <phoenixshen@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>, Enrico Granata <egranata@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 13, 2019 at 11:54 PM Ting Shen <phoenixshen@chromium.org> wrote:
>
> http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> the event_type field, the receiver side should mask out this extra bit when
> processing the event.
>
> Signed-off-by: Ting Shen <phoenixshen@chromium.org>

Reviewed-by: Enrico Granata <egranata@google.com>

>
> ---
>
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index d5600118159835..38cb6d82d8fe67 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>         if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>                 return NOTIFY_OK;
>
> -       switch (ckdev->ec->event_data.event_type) {
> +       switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
>         case EC_MKBP_EVENT_KEY_MATRIX:
>                 pm_wakeup_event(ckdev->dev, 0);
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
