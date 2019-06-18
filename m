From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date: Tue, 18 Jun 2019 10:43:21 +0200
Message-ID: <6a5c8385-6875-d999-a274-bbc592057934@collabora.com>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614065438.142867-1-phoenixshen@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ting Shen <phoenixshen@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>, Enrico Granata <egranata@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
List-Id: linux-input@vger.kernel.org



On 14/6/19 8:54, Ting Shen wrote:
> http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> the event_type field, the receiver side should mask out this extra bit when
> processing the event.
> 
> Signed-off-by: Ting Shen <phoenixshen@chromium.org>
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
>  	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>  		return NOTIFY_OK;
>  
> -	switch (ckdev->ec->event_data.event_type) {
> +	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
>  		pm_wakeup_event(ckdev->dev, 0);
>  
> 

Applied for chrome-platform-5.3

Thanks,
~ Enric
