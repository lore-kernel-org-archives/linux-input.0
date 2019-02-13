From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Mark expected switch fall-through
Date: Thu, 14 Feb 2019 00:07:42 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1902140006510.11598@cbobk.fhfr.pm>
References: <20190211220422.GA22137@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211220422.GA22137@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <ping.cheng@wacom.com>
List-Id: linux-input@vger.kernel.org

On Mon, 11 Feb 2019, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/hid/wacom_wac.c: In function ‘wacom_setup_pen_input_capabilities’:
> drivers/hid/wacom_wac.c:3506:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    __clear_bit(ABS_MISC, input_dev->absbit);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/hid/wacom_wac.c:3508:2: note: here
>   case WACOM_MO:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Let's CC Jason and Ping to make sure it's really intended :)

> ---
>  drivers/hid/wacom_wac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 72477e872324..5ecda99bf431 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3504,6 +3504,7 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
>  	switch (features->type) {
>  	case GRAPHIRE_BT:
>  		__clear_bit(ABS_MISC, input_dev->absbit);
> +		/* fall through */
>  
>  	case WACOM_MO:
>  	case WACOM_G4:
> -- 
> 2.20.1
> 

-- 
Jiri Kosina
SUSE Labs
