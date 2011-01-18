From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/16] input: tnetv107x-touchscreen: don't treat NULL clk
 as an error
Date: Mon, 17 Jan 2011 20:35:55 -0800
Message-ID: <20110118043555.GA23851@core.coreip.homeip.net>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
 <1294749833-32019-5-git-send-email-jamie@jamieiles.com>
 <20110112055640.GC22944@core.coreip.homeip.net>
 <20110118042535.GA23781@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62794 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1AREgC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Jan 2011 23:36:02 -0500
Content-Disposition: inline
In-Reply-To: <20110118042535.GA23781@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-kernel@vger.kernel.org, Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org

On Mon, Jan 17, 2011 at 08:25:35PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 11, 2011 at 09:56:41PM -0800, Dmitry Torokhov wrote:
> > On Tue, Jan 11, 2011 at 12:43:41PM +0000, Jamie Iles wrote:
> > > clk_get() returns a struct clk cookie to the driver and some platforms
> > > may return NULL if they only support a single clock.  clk_get() has only
> > > failed if it returns a ERR_PTR() encoded pointer.
> > > 
> > > Cc: Cyril Chemparathy <cyril@ti.com>
> > > Cc: linux-input@vger.kernel.org
> > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > 
> > Applied both, thank you Jamie.
> > 
> 
> Actually, if we pass clk that is NULL along we going to get oops on many
> arches, so I am going to change it to IS_ERR_OR_NULL.
> 

Oh, wait... OK, I got confused by the changelog. IS_ERR is proper,
sorry.

-- 
Dmitry
