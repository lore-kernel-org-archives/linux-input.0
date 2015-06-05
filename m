From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/9] input: goodix: fix alignment issues
Date: Fri, 5 Jun 2015 10:31:40 -0700
Message-ID: <20150605173140.GG26708@dtor-ws>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-2-git-send-email-irina.tirdea@intel.com>
 <20150605164901.GE26708@dtor-ws>
 <1433524678.2658.70.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33792 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933022AbbFERbp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 13:31:45 -0400
Content-Disposition: inline
In-Reply-To: <1433524678.2658.70.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 05, 2015 at 10:17:58AM -0700, Joe Perches wrote:
> On Fri, 2015-06-05 at 09:49 -0700, Dmitry Torokhov wrote:
> > Hi Irina,
> > 
> > On Thu, May 28, 2015 at 03:47:37PM +0300, Irina Tirdea wrote:
> > > Fix alignment to match open parenthesis detected by
> > > running checkpatch.pl --strict.
> > 
> > Mixed bag of changes here, but that's checkpatch for you.
> 
> Yup,
> 
> checkpatch output is definitely a mix of automated
> semi-competence and brain-deadness.
> 
> > > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> []
> > > @@ -112,7 +112,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
> > >  		data += 1 + GOODIX_CONTACT_SIZE;
> > >  		error = goodix_i2c_read(ts->client,
> > >  					GOODIX_READ_COOR_ADDR +
> > > -						1 + GOODIX_CONTACT_SIZE,
> > > +					1 + GOODIX_CONTACT_SIZE,
> > 
> > Bad - makes 1 + GOODIX_CONTACT_SIZE look like extra argument, not
> > continuation of expression.
> 
> <shrug>  There's no great way to do this.
> 
> Parentheses around the longer expression work.
> 
> 		error = goodix_i2c_read(ts->client,
> 					(GOODIX_READ_COOR_ADDR +
> 					 1 + GOODIX_CONTACT_SIZE),
> 
> Exceeding 80 columns may be better.
> Leaving it alone would be OK too.
> 
> Maybe starting with 1 to be more similar
> to the below would be better.
> 
> > > @@ -157,7 +157,8 @@ static void goodix_process_events(struct goodix_ts_data *ts)
> > >  
> > >  	for (i = 0; i < touch_num; i++)
> > >  		goodix_ts_report_touch(ts,
> > > -				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
> > > +				       &point_data[1 +
> > > +				       GOODIX_CONTACT_SIZE * i]);
> > 
> > No, this is plain ugly.
> 
> Sometimes it's better to exceed 80 columns or
> maybe use temporaries.  Something like:

Or not aligning the arguments (when it makes sense).

Thankfully we are not using FORTRAN, COBOL or even Python here.

Thanks.

-- 
Dmitry
