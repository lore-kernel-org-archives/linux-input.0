From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch 3/3] Input: cyttsp4 - leak on error path in probe()
Date: Wed, 3 Jul 2013 16:50:13 +0300
Message-ID: <20130703135013.GU5714@mwanda>
References: <20130702214455.GC1598@elgon.mountain>
 <51D42350.10504@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24685 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab3GCNuQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jul 2013 09:50:16 -0400
Content-Disposition: inline
In-Reply-To: <51D42350.10504@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Jul 03, 2013 at 04:12:48PM +0300, Ferruh Yigit wrote:
> On 07/03/2013 12:44 AM, Dan Carpenter wrote:
> >We leak "cd" if the cd->xfer_buf allocation fails.  It was weird to
> >"goto error_gpio_irq" so I changed the label name.  (Label names should
> >reflect the label location not the goto location otherwise you get an
> >"all roads lead to Rome problem").
> >
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> xfer_buf still may not be freed, I propose following one instead:
> 

That's a good point.  I missed that leak.  The problem is that my
patch was already applied so this patch would have to be re-written
on top of that.  Also this patch is whitespace dammaged and won't
apply.

regards,
dan carpenter

