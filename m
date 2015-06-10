From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - do not explicitly set evbits in input
 device
Date: Wed, 10 Jun 2015 17:08:39 +0200
Message-ID: <1433948919.5707.19.camel@hadess.net>
References: <20150609185219.GA33366@dtor-ws>
	 <1433931490.5707.18.camel@hadess.net>
	 <20150610143910.GB27326@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40970 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbFJPIn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2015 11:08:43 -0400
In-Reply-To: <20150610143910.GB27326@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2015-06-10 at 10:39 -0400, Benjamin Tissoires wrote:
> On Jun 10 2015 or thereabouts, Bastien Nocera wrote:
> > On Tue, 2015-06-09 at 11:52 -0700, Dmitry Torokhov wrote:
> > > input_mt_init_slots() will do that for us.
> > 
> > I'm guessing you know what you're doing here, but I couldn't find 
> > where
> > the EV_SYN bit would have been set in the input_mt_init_slots() 
> > call
> > chain.
> 
> input_register_device() sets EV_SYN bit for us (it is a mandatory 
> field
> for input).
<snip>
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

OK, thanks for the explanation.

Acked-by: Bastien Nocera <hadess@hadess.net>
