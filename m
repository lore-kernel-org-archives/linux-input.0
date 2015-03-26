From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] Separate set parameter function for MT device
Date: Thu, 26 Mar 2015 09:25:10 +0100
Message-ID: <5513C266.2030107@redhat.com>
References: <1427409967-4721-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbbCZIZN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 04:25:13 -0400
In-Reply-To: <1427409967-4721-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, masaki.ota@jp.alps.com

Hi,

On 26-03-15 23:46, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - Separate set parameter function for MT device.
>
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

Thanks, looks good:

Acked-by: Hans de Goede <hdegoede@redhat.com>

I somehow did not receive patch 2/2 can you resend or forward that to me
please ?

Regards,

Hans


> ---
>   drivers/input/mouse/alps.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index d28726a..e36d4da 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -157,6 +157,8 @@ static void alps_set_abs_params_st(struct alps_data *priv,
>   				   struct input_dev *dev1);
>   static void alps_set_abs_params_mt(struct alps_data *priv,
>   				   struct input_dev *dev1);
> +static void alps_set_abs_params_v7(struct alps_data *priv,
> +					struct input_dev *dev1);
>
>   /* Packet formats are described in Documentation/input/alps.txt */
>
> @@ -2300,7 +2302,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
>   		priv->hw_init = alps_hw_init_v7;
>   		priv->process_packet = alps_process_packet_v7;
>   		priv->decode_fields = alps_decode_packet_v7;
> -		priv->set_abs_params = alps_set_abs_params_mt;
> +		priv->set_abs_params = alps_set_abs_params_v7;
>   		priv->nibble_commands = alps_v3_nibble_commands;
>   		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
>
> @@ -2429,7 +2431,7 @@ static void alps_set_abs_params_st(struct alps_data *priv,
>   	input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
>   }
>
> -static void alps_set_abs_params_mt(struct alps_data *priv,
> +static void alps_set_abs_params_mt_common(struct alps_data *priv,
>   				   struct input_dev *dev1)
>   {
>   	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
> @@ -2438,15 +2440,26 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
>   	input_abs_set_res(dev1, ABS_MT_POSITION_X, priv->x_res);
>   	input_abs_set_res(dev1, ABS_MT_POSITION_Y, priv->y_res);
>
> +	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
> +	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
> +}
> +
> +static void alps_set_abs_params_mt(struct alps_data *priv,
> +				   struct input_dev *dev1)
> +{
> +	alps_set_abs_params_mt_common(priv, dev1);
> +
>   	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
>   		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
> +}
>
> -	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
> -	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
> +static void alps_set_abs_params_v7(struct alps_data *priv,
> +				   struct input_dev *dev1)
> +{
> +	alps_set_abs_params_mt_common(priv, dev1);
>
> -	/* V7 is real multi-touch */
> -	if (priv->proto_version == ALPS_PROTO_V7)
> -		clear_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
> +	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
> +		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
>   }
>
>   int alps_init(struct psmouse *psmouse)
>
