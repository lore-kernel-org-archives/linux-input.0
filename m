From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 02/15] Input: synaptics-rmi4 - don't kfree devm_ alloced
 memory
Date: Tue, 4 Feb 2014 18:27:34 -0800
Message-ID: <20140205022733.GB1706@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <52F172E3.7050601@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:13058 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751879AbaBECZu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 21:25:50 -0500
Content-Disposition: inline
In-Reply-To: <52F172E3.7050601@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linus.walleij@linaro.org

On Wed, Feb 05, 2014 at 12:08:19AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> > Cc: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> 
> This is redundant with patch code submitted 2013/01/22.  See here:
>      http://www.spinics.net/lists/linux-input/msg29280.html
> 
> and in any case, Dmitry has submitted a more thorough tidy up here:
>      http://www.spinics.net/lists/linux-input/msg29323.html
> 

Neither of these two patches resolve the issue here, which is that you
should not directly free the memory allocated by devm_kzalloc() in
rmi_f01_alloc_memory().

> > ---
> >   drivers/input/rmi4/rmi_f01.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> > index cf1081f..98bc65a9 100644
> > --- a/drivers/input/rmi4/rmi_f01.c
> > +++ b/drivers/input/rmi4/rmi_f01.c
> > @@ -390,7 +390,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
> >   	return 0;
> >
> >    error_exit:
> > -	kfree(data);
> > +	devm_kfree(&fn->dev, data);
> >   	return error;
> >   }
> >
> >
