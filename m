From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 13/15] Input: synaptics-rmi4 - properly set F01 container
 on PDT scan
Date: Tue, 4 Feb 2014 18:39:02 -0800
Message-ID: <20140205023901.GL1706@sonymobile.com>
References: <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
 <52F17371.7030507@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:14611 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932137AbaBEChS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 21:37:18 -0500
Content-Disposition: inline
In-Reply-To: <52F17371.7030507@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linus.walleij@linaro.org

On Wed, Feb 05, 2014 at 12:10:41AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> 
> Although necessary, this is redundant to changes already submitted.
> 

Indeed. Sorry.

> > Cc: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > ---
> >   drivers/input/rmi4/rmi_driver.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index 52345ae..9d8d6ec 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -488,6 +488,8 @@ static int create_function(struct rmi_device *rmi_dev,
> >   		return error;
> >
> >   	list_add_tail(&fn->node, &data->function_list);
> > +	if (pdt->function_number == 0x01)
> > +		data->f01_container = fn;
> >
> >   	return 0;
> >   }
> >
