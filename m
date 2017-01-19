From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 13/33] Input: bfin_rotary - Use 'dev' instead of
 dereferencing it and other changes
Date: Wed, 18 Jan 2017 20:58:52 -0800
Message-ID: <1484801932.18392.1.camel@perches.com>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
         <1484761614-12225-14-git-send-email-linux@roeck-us.net>
         <20170118193952.GG33920@dtor-ws> <20170118203517.GB6807@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:58497 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750926AbdASFA0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 00:00:26 -0500
In-Reply-To: <20170118203517.GB6807@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2017-01-18 at 12:35 -0800, Guenter Roeck wrote:
> On Wed, Jan 18, 2017 at 11:39:52AM -0800, Dmitry Torokhov wrote:
> > On Wed, Jan 18, 2017 at 09:46:34AM -0800, Guenter Roeck wrote:
[]
> > > diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
[]
> > > @@ -141,25 +141,23 @@ static int bfin_rotary_probe(struct platform_device *pdev)
> > >  
> > >  	/* Basic validation */
> > >  	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
> > > -	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
> > > +	    (!pdata->rotary_up_key && pdata->rotary_down_key))

maybe just use ^ 

	if (!pdata->rotary_up_key ^ !pdata->rotary_down_key)
