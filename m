From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] input: goodix: Use max touch number from device config
Date: Fri, 06 Mar 2015 13:19:14 +0100
Message-ID: <1425644354.11984.6.camel@hadess.net>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	 <1425576744-25170-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41215 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbbCFMTW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 07:19:22 -0500
In-Reply-To: <1425576744-25170-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Thu, 2015-03-05 at 20:32 +0300, Aleksei Mamlin wrote:
> Use max number of touches from device config instead of hardcoding.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Tested-by: Bastien Nocera <hadess@hadess.net>
Acked-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/input/touchscreen/goodix.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c 
> b/drivers/input/touchscreen/goodix.c
> index ca19668..a3e2057 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -48,6 +48,7 @@ struct goodix_ts_data {
>  #define GOODIX_REG_VERSION             0x8140
>  
>  #define RESOLUTION_LOC         1
> +#define MAX_CONTACTS_LOC       5
>  #define TRIGGER_LOC            6
>  
>  static const unsigned long goodix_irq_flags[] = {
> @@ -99,7 +100,7 @@ static int goodix_ts_read_input_report(struct 
> goodix_ts_data *ts, u8 *data)
>         }
>  
>         touch_num = data[0] & 0x0f;
> -       if (touch_num > GOODIX_MAX_CONTACTS)
> +       if (touch_num > ts->max_touch_num)
>                 return -EPROTO;
>  
>         if (touch_num > 1) {
> @@ -141,7 +142,7 @@ static void goodix_ts_report_touch(struct 
> goodix_ts_data *ts, u8 *coor_data)
>   */
>  static void goodix_process_events(struct goodix_ts_data *ts)
>  {
> -       u8  point_data[1 + GOODIX_CONTACT_SIZE * 
> GOODIX_MAX_CONTACTS];
> +       u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
>         int touch_num;
>         int i;
>  
> @@ -202,21 +203,23 @@ static void goodix_read_config(struct 
> goodix_ts_data *ts)
>                 ts->abs_x_max = GOODIX_MAX_WIDTH;
>                 ts->abs_y_max = GOODIX_MAX_HEIGHT;
>                 ts->int_trigger_type = GOODIX_INT_TRIGGER;
> +               ts->max_touch_num = GOODIX_MAX_CONTACTS;
>                 return;
>         }
>  
>         ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
>         ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 
> 2]);
>         ts->int_trigger_type = (config[TRIGGER_LOC]) & 0x03;
> -       if (!ts->abs_x_max || !ts->abs_y_max) {
> +       ts->max_touch_num = (config[MAX_CONTACTS_LOC]) & 0x0f;
> +       if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
>                 dev_err(&ts->client->dev,
>                         "Invalid config, using defaults\n");
>                 ts->abs_x_max = GOODIX_MAX_WIDTH;
>                 ts->abs_y_max = GOODIX_MAX_HEIGHT;
> +               ts->max_touch_num = GOODIX_MAX_CONTACTS;
>         }
>  }
>  
> -
>  /**
>   * goodix_read_version - Read goodix touchscreen version
>   *
> @@ -295,7 +298,7 @@ static int goodix_request_input_dev(struct 
> goodix_ts_data *ts)
>         input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 
> 255, 0, 0);
>         input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 
> 255, 0, 0);
>  
> -       input_mt_init_slots(ts->input_dev, GOODIX_MAX_CONTACTS,
> +       input_mt_init_slots(ts->input_dev, ts->max_touch_num,
>                                                         
> INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>  
>         ts->input_dev->name = "Goodix Capacitive TouchScreen";
