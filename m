From: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>
Subject: Re: [PATCH] Input: goodix: Add support for capacitive home button found on some x86 tablets
Date: Tue, 20 Jun 2017 20:47:35 +1000
Message-ID: <1789788.SfhPHfiICa@z12>
References: <1725443.Vzhj3lzWjD@z12> <3319693.GoGvQJigqa@z12> <1497954003.2559.16.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward19p.cmail.yandex.net ([77.88.31.22]:41247 "EHLO
        forward19p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751040AbdFTKwN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 06:52:13 -0400
In-Reply-To: <1497954003.2559.16.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru, linux-input@vger.kernel.org, "Sergei A. Trusov" <sergei.a.trusov@ya.ru>

On Tuesday, 20 June 2017 20:20:03 +10 Bastien Nocera wrote:
> On Tue, 2017-06-20 at 20:11 +1000, Sergei A. Trusov wrote:
> > On Tuesday, 20 June 2017 19:29:01 +10 Bastien Nocera wrote:
> > > On Tue, 2017-06-20 at 19:26 +1000, Sergei A. Trusov wrote:
> > > > 
> > > 
> > > <snip>
> > > > Thank you for this point. Now I see all the changes above are
> > > > redundant:
> > > > we can use a value returned in the *data buffer. It is enough to add 
> > > > only two lines of code to achieve the behaviour of this entire patch.
> > > 
> > > A bit more with a comment explaining the reason behind those 2 lines,
> > > but shorter patches get my vote ;)
> > 
> > Current goodix_ts_read_input_report() function puts data from hardware
> > into point_data buffer. Then in masks high niblle of the first byte and 
> > returns it as touch_num. We need this masked nibble to check, so I was 
> > trying to remove mask operation. After your comment I just realized that
> > proposed patch should be much shorter. I have included more context lines
> > to make cleaner my attempts to explain (as I am affraid my English is not
> > so good):
> 
> Do you want to re-send with the comments added as below?

Yes, thank you, I'll add those and send v2.
> 
> > ---
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index 240b16f3ee97..0c3825c39288 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -262,16 +262,18 @@ static void goodix_process_events(struct goodix_ts_data *ts)
> >  	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> >  	int touch_num;
> >  	int i;
> >  
> >  	touch_num = goodix_ts_read_input_report(ts, point_data);
> >  	if (touch_num < 0)
> >  		return;
> >  
> > +	input_report_key(ts->input_dev, KEY_LEFTMETA, !!(point_data[0] & 0x10));
> 
> You can add a comment above:
> Bit 4 of the first byte reports the status of the capacitive
> Windows/Home button.
> 
> >  	for (i = 0; i < touch_num; i++)
> >  		goodix_ts_report_touch(ts,
> >  				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
> >  
> >  	input_mt_sync_frame(ts->input_dev);
> >  	input_sync(ts->input_dev);
> >  }
> >  
> > @@ -607,16 +609,18 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
> >  
> >  	ts->input_dev->name = "Goodix Capacitive TouchScreen";
> >  	ts->input_dev->phys = "input/ts";
> >  	ts->input_dev->id.bustype = BUS_I2C;
> >  	ts->input_dev->id.vendor = 0x0416;
> >  	ts->input_dev->id.product = ts->id;
> >  	ts->input_dev->id.version = ts->version;
> >  
> > +	input_set_capability(ts->input_dev, EV_KEY, KEY_LEFTMETA);
> 
> Add a comment above:
> Capacitive Windows/Home button on some devices
> 
> >  	error = input_register_device(ts->input_dev);
> >  	if (error) {
> >  		dev_err(&ts->client->dev,
> >  			"Failed to register input device: %d", error);
> >  		return error;
> >  	}
> >  
> >  	return 0;
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


