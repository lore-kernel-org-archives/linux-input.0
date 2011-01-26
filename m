From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 10/32] input/tps6507x-ts: use system_wq instead of
 dedicated workqueue
Date: Wed, 26 Jan 2011 11:43:02 +0100
Message-ID: <20110126104302.GI12520@htj.dyndns.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
 <1294062595-30097-11-git-send-email-tj@kernel.org>
 <20110103143926.GX1886@bicker>
 <4D21FAA3.8030505@ridgerun.com>
 <20110125141942.GA27510@htj.dyndns.org>
 <4D3EF6B9.6080608@ridgerun.com>
 <20110125165005.GB19701@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44952 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1AZKnH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Jan 2011 05:43:07 -0500
Content-Disposition: inline
In-Reply-To: <20110125165005.GB19701@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jan 25, 2011 at 08:50:06AM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 25, 2011 at 09:13:45AM -0700, Todd Fischer wrote:
> > On 01/25/2011 07:19 AM, Tejun Heo wrote:
> > >Shall I apply the patch?
> > >Thanks
> > Yes, apply the patch.  I am not sure of the syntax for attaching my
> > sign off.  Hope this is okay.
> > 
> > Todd
> > 
> > Signed-off-by: Todd Fischer<todd.fischer@ridgerun.com>
> > 
> 
> That should be Acked-by since you are not passing the patch along.

Added ack-by's of Todd and you.  Thank you.

-- 
tejun
