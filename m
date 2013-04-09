From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/2] ARM: shmobile: Armadillo800EVA: Move st1232 reset
 pin handling
Date: Tue, 9 Apr 2013 18:11:30 +0900
Message-ID: <20130409091130.GA3401@verge.net.au>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
 <1365425547-10391-2-git-send-email-hechtb+renesas@gmail.com>
 <1534841.hHClRQAXMk@avalon>
 <20130409082644.GD18478@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:57054 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935153Ab3DIJLd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Apr 2013 05:11:33 -0400
Content-Disposition: inline
In-Reply-To: <20130409082644.GD18478@verge.net.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Tue, Apr 09, 2013 at 05:26:44PM +0900, Simon Horman wrote:
> On Mon, Apr 08, 2013 at 04:17:22PM +0200, Laurent Pinchart wrote:
> > Hi Bastian,
> > 
> > Thanks for the patch.
> > 
> > On Monday 08 April 2013 14:52:27 Bastian Hecht wrote:
> > > We no longer need to set up the reset pin for the st1232 in the board
> > > code, but can pass the GPIO number via the platform data to the driver.
> > > This results in a cleaner grouping of the device setup.
> > > 
> > > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks.
> 
> I have queued this up in the boards-armadillo800eva branch.
> 
> There were some conflicts when I applied the code which
> I fixed manually. Bastian, can you please check that the
> following is correct? If it is not please send an incremental patch.

I was trying to apply your patch to an old branch.
It applies cleanly to the correct new branch :)
