From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input: add driver for EETI touchpanels [v5]
Date: Tue, 19 May 2009 11:01:43 +0200
Message-ID: <20090519090143.GC25674@buzzloop.caiaq.de>
References: <20090516173226.GA1448@buzzloop.caiaq.de> <1242495290-11497-1-git-send-email-daniel@caiaq.de> <20090516205719.15fbec97@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:48652 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbZESJBp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 05:01:45 -0400
Content-Disposition: inline
In-Reply-To: <20090516205719.15fbec97@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-input@vger.kernel.org

On Sat, May 16, 2009 at 08:57:19PM +0200, Jean Delvare wrote:
> On Sat, 16 May 2009 19:34:50 +0200, Daniel Mack wrote:
> > This patch adds a driver for EETI's I2C connected touchscreens.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Tested-by: Sven Neumann <s.neumann@raumfeld.com>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > ---
> >  drivers/input/touchscreen/Kconfig   |    9 +
> >  drivers/input/touchscreen/Makefile  |    1 +
> >  drivers/input/touchscreen/eeti_ts.c |  286 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 296 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/touchscreen/eeti_ts.c
> 
> For the i2c part:
> Acked-by: Jean Delvare <khali@linux-fr.org>

Thanks!

Dmitry, any more thoughts about that, or is it ready for your tree?

Daniel

