From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: goodix: Use max touch number from device config
Date: Fri, 6 Mar 2015 16:41:07 -0800
Message-ID: <20150307004107.GB26151@dtor-ws>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
 <1425576744-25170-1-git-send-email-mamlinav@gmail.com>
 <20150306144231.e7c7cd0b52fe68356ad27704@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45650 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbCGAlN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 19:41:13 -0500
Content-Disposition: inline
In-Reply-To: <20150306144231.e7c7cd0b52fe68356ad27704@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>

On Fri, Mar 06, 2015 at 02:42:31PM +0100, Antonio Ospite wrote:
> On Thu,  5 Mar 2015 20:32:24 +0300
> Aleksei Mamlin <mamlinav@gmail.com> wrote:
> 
> > Use max number of touches from device config instead of hardcoding.
> > 
> > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> 
> Tested-by: Antonio Ospite <ao2@ao2.it>
> 
> Some minor comments below, but no need to resend IMHO.

Applied, thank you.

> 
> > ---
> >  drivers/input/touchscreen/goodix.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index ca19668..a3e2057 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -48,6 +48,7 @@ struct goodix_ts_data {
> >  #define GOODIX_REG_VERSION		0x8140
> >  
> >  #define RESOLUTION_LOC		1
> > +#define MAX_CONTACTS_LOC	5
> >  #define TRIGGER_LOC		6
> >  
> >  static const unsigned long goodix_irq_flags[] = {
> > @@ -99,7 +100,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
> >  	}
> >  
> >  	touch_num = data[0] & 0x0f;
> > -	if (touch_num > GOODIX_MAX_CONTACTS)
> > +	if (touch_num > ts->max_touch_num)
> >  		return -EPROTO;
> >  
> >  	if (touch_num > 1) {
> > @@ -141,7 +142,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
> >   */
> >  static void goodix_process_events(struct goodix_ts_data *ts)
> >  {
> > -	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> > +	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
> >  	int touch_num;
> >  	int i;
> >  
> > @@ -202,21 +203,23 @@ static void goodix_read_config(struct goodix_ts_data *ts)
> >  		ts->abs_x_max = GOODIX_MAX_WIDTH;
> >  		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> >  		ts->int_trigger_type = GOODIX_INT_TRIGGER;
> > +		ts->max_touch_num = GOODIX_MAX_CONTACTS;
> >  		return;
> >  	}
> >  
> >  	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> >  	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
> >  	ts->int_trigger_type = (config[TRIGGER_LOC]) & 0x03;
> > -	if (!ts->abs_x_max || !ts->abs_y_max) {
> > +	ts->max_touch_num = (config[MAX_CONTACTS_LOC]) & 0x0f;
> 
> Parentheses are not really needed here, but I see that you just followed
> the style from the line above, so it's OK, I'll send a cleanup patch
> to remove them from both lines.
> 
> > +	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
> >  		dev_err(&ts->client->dev,
> >  			"Invalid config, using defaults\n");
> >  		ts->abs_x_max = GOODIX_MAX_WIDTH;
> >  		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> > +		ts->max_touch_num = GOODIX_MAX_CONTACTS;
> >  	}
> >  }
> >  
> > -
> 
> This is an unrelated change, it's not a big deal of course but in
> general it is a good practice to differentiate cosmetic changes from
> functional ones.
> 
> >  /**
> >   * goodix_read_version - Read goodix touchscreen version
> >   *
> > @@ -295,7 +298,7 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
> >  	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
> >  	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> >  
> > -	input_mt_init_slots(ts->input_dev, GOODIX_MAX_CONTACTS,
> > +	input_mt_init_slots(ts->input_dev, ts->max_touch_num,
> >  			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> >  
> >  	ts->input_dev->name = "Goodix Capacitive TouchScreen";
> > -- 
> > 2.0.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Thanks,
>    Antonio
> 
> -- 
> Antonio Ospite
> http://ao2.it
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
