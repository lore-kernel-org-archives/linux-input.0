From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: appletouch - driver refactoring
Date: Mon, 13 Oct 2008 22:57:48 -0400
Message-ID: <20081014025748.GB8594@anvil.corenet.prv>
References: <1223542147.6130.14.camel@galileo> <20081011032120.GB22499@anvil.corenet.prv> <1223822468.9733.1.camel@galileo> <1223822674.9733.5.camel@galileo> <1223823289.10176.9.camel@johannes.berg> <1223827257.11389.1.camel@galileo> <1223827421.11389.5.camel@galileo> <1223891135.24954.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:46934 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627AbYJNC5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2008 22:57:53 -0400
Received: by an-out-0708.google.com with SMTP id d40so153099and.103
        for <linux-input@vger.kernel.org>; Mon, 13 Oct 2008 19:57:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1223891135.24954.1.camel@johannes.berg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stelian Pop <stelian@popies.net>, linux-input@vger.kernel.org

On Mon, Oct 13, 2008 at 11:45:35AM +0200, Johannes Berg wrote:
> On Sun, 2008-10-12 at 18:03 +0200, Stelian Pop wrote:
> > The appletouch driver has grown up from supporting only a couple of
> > touchpads into supporting many touchpads, which can have different
> > number of sensors, different aspect ratios etc.
> > 
> > This patch cleans up the current driver code and makes it easy to
> > support the features of each different touchpad.
> > 
> > As a side effect, this patch also modifies the 'Y' multiplication factor
> > of the 'geyser3' and 'geyser4' touchpads (found on Core Duo and Core2
> > Duo MacBook and MacBook Pro laptops) in order to make the touchpad
> > output match the aspect ratio of the touchpad (Y factor changed from 43
> > to 64).
> 
> Looks good, the only thing I can find to complain about is that you
> modify
> 
> 
> > +static struct atp_info geyser1_info = {
> > +	.xsensors	= 16,		/* will be set to 26 on 17" */
> 
> those static variables ;)
> 
> Considering these devices aren't available outside of apple laptops and
> those always come with exactly one, I don't think it's much of a
> problem.
> 

I consider it an "Acked-by" then?

-- 
Dmitry
