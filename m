From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 10/32] input/tps6507x-ts: use system_wq instead of
 dedicated workqueue
Date: Mon, 3 Jan 2011 17:39:26 +0300
Message-ID: <20110103143926.GX1886@bicker>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
 <1294062595-30097-11-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47970 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab1ACOjq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Jan 2011 09:39:46 -0500
Content-Disposition: inline
In-Reply-To: <1294062595-30097-11-git-send-email-tj@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Todd Fischer <todd.fischer@ridgerun.com>

On Mon, Jan 03, 2011 at 02:49:33PM +0100, Tejun Heo wrote:
> With cmwq, there's no reason to use a separate workqueue.  Drop
> tps6507x_ts->wq and use system_wq instead.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: Todd Fischer <todd.fischer@ridgerun.com>
> ---
> Only compile tested.  Please feel free to take it into the subsystem
> tree or simply ack - I'll route it through the wq tree.
> 

This is that driver that polls every 30 ms.  :/  Todd, is there no way
to avoid this?  What was the status on that?

regards,
dan carpenter


