From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/9] input: goodix: fix alignment issues
Date: Fri, 05 Jun 2015 10:17:58 -0700
Message-ID: <1433524678.2658.70.camel@perches.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
	 <1432817265-23891-2-git-send-email-irina.tirdea@intel.com>
	 <20150605164901.GE26708@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150605164901.GE26708@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2015-06-05 at 09:49 -0700, Dmitry Torokhov wrote:
> Hi Irina,
> 
> On Thu, May 28, 2015 at 03:47:37PM +0300, Irina Tirdea wrote:
> > Fix alignment to match open parenthesis detected by
> > running checkpatch.pl --strict.
> 
> Mixed bag of changes here, but that's checkpatch for you.

Yup,

checkpatch output is definitely a mix of automated
semi-competence and brain-deadness.

> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
[]
> > @@ -112,7 +112,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
> >  		data += 1 + GOODIX_CONTACT_SIZE;
> >  		error = goodix_i2c_read(ts->client,
> >  					GOODIX_READ_COOR_ADDR +
> > -						1 + GOODIX_CONTACT_SIZE,
> > +					1 + GOODIX_CONTACT_SIZE,
> 
> Bad - makes 1 + GOODIX_CONTACT_SIZE look like extra argument, not
> continuation of expression.

<shrug>  There's no great way to do this.

Parentheses around the longer expression work.

		error = goodix_i2c_read(ts->client,
					(GOODIX_READ_COOR_ADDR +
					 1 + GOODIX_CONTACT_SIZE),

Exceeding 80 columns may be better.
Leaving it alone would be OK too.

Maybe starting with 1 to be more similar
to the below would be better.

> > @@ -157,7 +157,8 @@ static void goodix_process_events(struct goodix_ts_data *ts)
> >  
> >  	for (i = 0; i < touch_num; i++)
> >  		goodix_ts_report_touch(ts,
> > -				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
> > +				       &point_data[1 +
> > +				       GOODIX_CONTACT_SIZE * i]);
> 
> No, this is plain ugly.

Sometimes it's better to exceed 80 columns or
maybe use temporaries.  Something like:

	u8 *tmp = point_data + 1;
	...

	for (i = 0; i < touch_num; i++, tmp += GOODIX_CONTACT_SIZE)
		goodix_ts_report_touch(ts, tmp);
