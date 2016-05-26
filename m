From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pwm-beeper - fix: scheduling while atomic
Date: Wed, 25 May 2016 17:36:15 -0700
Message-ID: <20160526003615.GE22369@dtor-ws>
References: <56C4735E.6020300@gmx.at>
 <20160222194639.GD26177@dtor-ws>
 <20160512121852.GB26824@ulmo.ba.sec>
 <5735F4E3.20008@gmx.at>
 <573C8761.9070601@gmx.at>
 <20160520165918.GE14951@dtor-ws>
 <574411B5.2010407@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36002 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbcEZAgT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 20:36:19 -0400
Content-Disposition: inline
In-Reply-To: <574411B5.2010407@gmx.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Cc: Thierry Reding <thierry.reding@gmail.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, May 24, 2016 at 10:32:53AM +0200, Manfred Schlaegl wrote:
> On 2016-05-20 18:59, Dmitry Torokhov wrote:
> > Hi Manfred,
> > 
> > On Wed, May 18, 2016 at 05:16:49PM +0200, Manfred Schlaegl wrote:
> >> @@ -133,6 +149,8 @@ static int pwm_beeper_remove(struct platform_device *pdev)
> >>  {
> >>  	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
> >>  
> >> +	cancel_work_sync(&beeper->work);
> >> +
> >>  	input_unregister_device(beeper->input);
> > 
> > This is racy, request to play may come in after cancel_work_sync()
> > returns but before we unregistered input device. I think you want the
> > version below.
> > 
> 
> Hi Dmitry,
> 
> yes you are right. Thank you for your feedback.
> I also see that point, but I think it would be a simpler change just
> to cancel the worker after unregistering the device (to reorder 
> cancel_work_sync and input_unregister_device).

That is an option, but I wanter to have close() because I also want to
convert the driver to used devm for allocating resources, and then we'd
need close() anyway so that we can get rid of remove() method.

Thanks.

-- 
Dmitry
