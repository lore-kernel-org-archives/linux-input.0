From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH 2/9] input: goodix: fix variable length array warning
Date: Wed, 3 Jun 2015 10:26:47 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A78DD0@irsmsx105.ger.corp.intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
	<1432817265-23891-3-git-send-email-irina.tirdea@intel.com>
 <20150528175753.1f85723b5b880ecf02fd4a79@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7085 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbbFCK0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2015 06:26:53 -0400
In-Reply-To: <20150528175753.1f85723b5b880ecf02fd4a79@ao2.it>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Antonio Ospite [mailto:ao2@ao2.it]
> Sent: 28 May, 2015 18:58
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/9] input: goodix: fix variable length array warning
> 
> On Thu, 28 May 2015 15:47:38 +0300
> Irina Tirdea <irina.tirdea@intel.com> wrote:
> 
> > Fix sparse warning:
> > drivers/input/touchscreen/goodix.c:182:26: warning:
> > Variable length array is used.
> >
> > Replace the variable length array with fixed length.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  drivers/input/touchscreen/goodix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index c2e785c..dac1b3c 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -147,7 +147,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
> >   */
> >  static void goodix_process_events(struct goodix_ts_data *ts)
> >  {
> > -	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
> > +	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> 
> Hi,
> 

Hi Antonio,

> this fixes the warning from sparse, but also changes the semantics of
> the code: ts->max_touch_num is less that GOODIX_MAX_CONTACTS for 5
> touches devices and in this case we'll end up using more memory than is
> necessary.
> 

I wasn't sure if it is better to save the 5 bytes or fix the warning, so I sent this to get some more input.
Thanks for the feedback, I will  drop this patch.

Thanks,
Irina

> Thanks,
>    Antonio
> 
> >  	int touch_num;
> >  	int i;
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> Antonio Ospite
> http://ao2.it
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
