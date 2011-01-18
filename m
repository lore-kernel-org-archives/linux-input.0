From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/16] input: tnetv107x-touchscreen: don't treat NULL clk
 as an error
Date: Mon, 17 Jan 2011 20:25:35 -0800
Message-ID: <20110118042535.GA23781@core.coreip.homeip.net>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
 <1294749833-32019-5-git-send-email-jamie@jamieiles.com>
 <20110112055640.GC22944@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110112055640.GC22944@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-kernel@vger.kernel.org, Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 11, 2011 at 09:56:41PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 11, 2011 at 12:43:41PM +0000, Jamie Iles wrote:
> > clk_get() returns a struct clk cookie to the driver and some platforms
> > may return NULL if they only support a single clock.  clk_get() has only
> > failed if it returns a ERR_PTR() encoded pointer.
> > 
> > Cc: Cyril Chemparathy <cyril@ti.com>
> > Cc: linux-input@vger.kernel.org
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Applied both, thank you Jamie.
> 

Actually, if we pass clk that is NULL along we going to get oops on many
arches, so I am going to change it to IS_ERR_OR_NULL.

Thanks.

-- 
Dmitry
