From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 2/2] input - leds: fix input_led_disconnect path
Date: Fri, 15 Dec 2017 01:19:51 +0100
Message-ID: <20171215001951.2gbwks6wmmsl7ssf@var.youpi.perso.aquilenet.fr>
References: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
 <20171214132522.20346-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171214132522.20346-3-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Benjamin Tissoires, on jeu. 14 déc. 2017 14:25:22 +0100, wrote:
> Before unregistering the led classes, we have to be sure there is no
> more events in the input pipeline.
> Closing the input node before removing the led classes flushes the
> pipeline and this prevents segfaults.
> 
> Found with https://github.com/whot/fuzzydevice
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197679
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

input_close_device does run synchronize_rcu() which we seem to have to
process before freeing the rest indeed. Thus,

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

(though AFAIK it doesn't apply on the mainline tree)

> ---
>  drivers/input/input-leds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
> index c86eb3d648bf..8aefcc186a02 100644
> --- a/drivers/input/input-leds.c
> +++ b/drivers/input/input-leds.c
> @@ -211,6 +211,7 @@ static void input_leds_disconnect(struct input_handle *handle)
>  	int i;
>  
>  	cancel_delayed_work_sync(&leds->init_work);
> +	input_close_device(handle);
>  
>  	for (i = 0; i < leds->num_leds; i++) {
>  		struct input_led *led = &leds->leds[i];
> @@ -219,7 +220,6 @@ static void input_leds_disconnect(struct input_handle *handle)
>  		kfree(led->cdev.name);
>  	}
>  
> -	input_close_device(handle);
>  	input_unregister_handle(handle);
>  
>  	kfree(leds);
> -- 
> 2.14.3
> 
