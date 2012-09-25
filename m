From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Subject: Re: [Patch v1 2/7] DA9055 Regulator driver
Date: Tue, 25 Sep 2012 14:15:53 +0530
Message-ID: <1348562753.6795.19.camel@dhruva>
References: <C3AE124F08223B42BC95AEB82F0F6CED3353338A@KCHJEXMB03.kpit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:14536
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750921Ab2IYIf6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 04:35:58 -0400
In-Reply-To: <C3AE124F08223B42BC95AEB82F0F6CED3353338A@KCHJEXMB03.kpit.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, David Dajun Chen <dchen@diasemi.com>

On Mon, 2012-09-24 at 18:04 +0530, Ashish Jangam wrote:
> 
> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> Sent: Monday, September 24, 2012 3:40 PM
> To: Ashish Jangam
> Cc: Liam Girdwood; Samuel Ortiz; linux-kernel@vger.kernel.org; David Dajun Chen
> Subject: Re: [Patch v1 2/7] DA9055 Regulator driver
> 
> On Mon, Sep 24, 2012 at 02:36:25PM +0530, Ashish Jangam wrote:
> > Any update on this patch?
> 
> Don't top post or send contentless pings.
> 
> The general quality problems with your submissions don't encourage fast
> review both technically and in terms of reviewer enthusiasm; for example
> in this case the fact that you've not used a subject line appropriate
> for the subsystem means that your patch doesn't flag as such.
> 
The motive behind the ping was to close on MFD earlier as other patches depends upon it.

Regulator framework takes care of most of the stuff therefore this patch is somewhat 
simplified except the GPIO part which I will try to simplify it further and will post all the
non-ACK patches again with the correct subject line.


