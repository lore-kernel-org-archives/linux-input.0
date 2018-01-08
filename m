From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Mon, 8 Jan 2018 14:55:02 +0100
Message-ID: <20180108135502.GF11344@localhost>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171211102121.GJ5672@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43621 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757682AbeAHNzD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 Jan 2018 08:55:03 -0500
Content-Disposition: inline
In-Reply-To: <20171211102121.GJ5672@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Marek Belisko <marek@goldelico.com>

On Mon, Dec 11, 2017 at 11:21:21AM +0100, Johan Hovold wrote:
> On Sat, Nov 11, 2017 at 04:43:37PM +0100, Johan Hovold wrote:
> > A helper purported to look up a child node based on its name was using
> > the wrong of-helper and ended up prematurely freeing the parent of-node
> > while searching the whole device tree depth-first starting at the parent
> > node.
> > 
> > Fixes: 64b9e4d803b1 ("input: twl4030-vibra: Support for DT booted kernel")
> > Fixes: e661d0a04462 ("Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning")
> > Cc: stable <stable@vger.kernel.org>     # 3.7
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Marek Belisko <marek@goldelico.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Just wanted to send a reminder about this series. I believe these bugs
> need to be fixes regardless of whether MFD-core eventually provides some
> means of avoiding such lookups in cell drivers (i.e. the discussion
> which appears to have stalled).

Another month, another reminder: Will you pick this series up for 4.16,
Dmitry?

Thanks,
Johan
