From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 10/32] input/tps6507x-ts: use system_wq instead of
 dedicated workqueue
Date: Tue, 25 Jan 2011 15:19:42 +0100
Message-ID: <20110125141942.GA27510@htj.dyndns.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
 <1294062595-30097-11-git-send-email-tj@kernel.org>
 <20110103143926.GX1886@bicker>
 <4D21FAA3.8030505@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63522 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab1AYOTr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 09:19:47 -0500
Content-Disposition: inline
In-Reply-To: <4D21FAA3.8030505@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Fischer <todd.fischer@ridgerun.com>
Cc: Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Jan 03, 2011 at 09:34:43AM -0700, Todd Fischer wrote:
> Hi Dan,
> 
> Polling is only necessary because I was given brain dead hardware.
> I was expecting updated hardware with the interrupt signal connected
> properly, but haven't received it yet.
> 
> Any reasonable hardware will not need tps6507x-ts polling.  I was
> under the impression I could only push patches that I have tested.
> Since I haven't tested an interrupt version of the driver, I didn't
> include a patch that removes the polling and replaces it with
> interrupts.
> 
> I have another customer planning on using the TPS6507x chip for
> touch screen.  I expect their hardware in around 3 weeks.

Shall I apply the patch?

Thanks.

-- 
tejun
