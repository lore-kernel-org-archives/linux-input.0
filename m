From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: goodix: Add support for capacitive home button
 found on some x86 tablets
Date: Mon, 19 Jun 2017 19:51:46 -0700
Message-ID: <20170620025146.GD21379@dtor-ws>
References: <1725443.Vzhj3lzWjD@z12>
 <1497911523.2559.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36529 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdFTCvu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 22:51:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id e187so10324144pgc.3
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 19:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1497911523.2559.4.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru, linux-input@vger.kernel.org

On Tue, Jun 20, 2017 at 12:32:03AM +0200, Bastien Nocera wrote:
> On Sat, 2017-06-17 at 19:42 +1000, Sergei A. Trusov wrote:
> > On some x86 tablets with a goodix touchscreen the windows logo on the
> > front is a capacitive home button. Touching this button results in a
> > touch
> > with bit 4 of the 0th byte set, while normally only the lower 4 bits
> > are used to indicate the number of touches.
> > 
> > Detect this and report a KEY_LEFTMETA press when this happens. Note
> > the
> > hardware might support more than one button, the number of a button
> > is
> > reported by the 'id' byte of coor_data. Now we ignore button id.
> > 
> > Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>
> > ---
> >  drivers/input/touchscreen/goodix.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/goodix.c
> > b/drivers/input/touchscreen/goodix.c
> > index 240b16f3ee97..a4c17c461792 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -76,6 +76,10 @@ struct goodix_ts_data {
> >  #define MAX_CONTACTS_LOC	5
> >  #define TRIGGER_LOC		6
> >  
> > +#define GOODIX_TOUCH_NUM_MASK		0x0f
> > +#define GOODIX_SOFTBUTTON_MASK		0x10
> > +#define GOODIX_SOFTBUTTON1		KEY_LEFTMETA
> > +
> >  static const unsigned long goodix_irq_flags[] = {
> >  	IRQ_TYPE_EDGE_RISING,
> >  	IRQ_TYPE_EDGE_FALLING,
> > @@ -208,7 +212,7 @@ static int goodix_ts_read_input_report(struct
> > goodix_ts_data *ts, u8 *data)
> >  	if (!(data[0] & 0x80))
> >  		return -EAGAIN;
> >  
> > -	touch_num = data[0] & 0x0f;
> > +	touch_num = data[0] & GOODIX_TOUCH_NUM_MASK;
> 
> This should be a separate patch.
> 
> >  	if (touch_num > ts->max_touch_num)
> >  		return -EPROTO;
> >  
> > @@ -223,7 +227,7 @@ static int goodix_ts_read_input_report(struct
> > goodix_ts_data *ts, u8 *data)
> >  			return error;
> >  	}
> >  
> > -	return touch_num;
> > +	return data[0];
> 
> I really don't like it when we change the meaning of a function's
> return value without changing the function's name, or explaining that
> we're doing that. This should be a separate patch please.
> 
> >  }
> >  
> >  static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8
> > *coor_data)
> > @@ -260,13 +264,17 @@ static void goodix_ts_report_touch(struct
> > goodix_ts_data *ts, u8 *coor_data)
> >  static void goodix_process_events(struct goodix_ts_data *ts)
> >  {
> >  	u8  point_data[1 + GOODIX_CONTACT_SIZE *
> > GOODIX_MAX_CONTACTS];
> > -	int touch_num;
> > +	int touch_num, status;
> >  	int i;
> >  
> > -	touch_num = goodix_ts_read_input_report(ts, point_data);
> > -	if (touch_num < 0)
> > +	status = goodix_ts_read_input_report(ts, point_data);
> > +	if (status < 0)
> >  		return;
> >  
> > +	input_report_key(ts->input_dev, GOODIX_SOFTBUTTON1,
> > +			!!(status & GOODIX_SOFTBUTTON_MASK));
> > +
> > +	touch_num = status & GOODIX_TOUCH_NUM_MASK;
> >  	for (i = 0; i < touch_num; i++)
> >  		goodix_ts_report_touch(ts,
> >  				&point_data[1 + GOODIX_CONTACT_SIZE
> > * i]);
> > @@ -612,6 +620,8 @@ static int goodix_request_input_dev(struct
> > goodix_ts_data *ts)
> >  	ts->input_dev->id.product = ts->id;
> >  	ts->input_dev->id.version = ts->version;
> >  
> > +	input_set_capability(ts->input_dev, EV_KEY,
> > GOODIX_SOFTBUTTON1);
> 
> I don't like this define though, please use KEY_LEFTMETA directly. We
> can change it to a constant when we have more than one softbutton.
> 
> General question though, should we not only export and advertise the
> button if it exists on the device?

Yes, this is preferred behavior.

> 
> > +
> >  	error = input_register_device(ts->input_dev);
> >  	if (error) {
> >  		dev_err(&ts->client->dev,
> > 

-- 
Dmitry
