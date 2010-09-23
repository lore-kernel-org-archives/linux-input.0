From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/2] serio: support multiple child devices per single
 parent
Date: Thu, 23 Sep 2010 20:36:34 +0400
Message-ID: <20100923163634.GA9407@doriath.ww600.siemens.net>
References: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
 <1281957997-12959-2-git-send-email-dbaryshkov@gmail.com>
 <20100915050316.GB21672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45953 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab0IWQgw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Sep 2010 12:36:52 -0400
Received: by fxm3 with SMTP id 3so178577fxm.19
        for <linux-input@vger.kernel.org>; Thu, 23 Sep 2010 09:36:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100915050316.GB21672@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Sep 14, 2010 at 10:03:16PM -0700, Dmitry Torokhov wrote:
> Hi Dmitry,
> 
> On Mon, Aug 16, 2010 at 03:26:36PM +0400, Dmitry Eremin-Solenikov wrote:
> > @@ -50,6 +52,7 @@ struct serio {
> >  	struct device dev;
> >  
> >  	struct list_head node;
> > +	struct list_head internal;	/* Used internally to avoid recursion */
> 
> I think we can do without this one, how about the patch below? (Depends
> on synaptics changes in attached patch).

Yes, it works for me. Sorry for the (long) delay in testing - I was on
vacation. I'll resubmit updated ps2mult driver in a few minutes.

-- 
With best wishes
Dmitry

