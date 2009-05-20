From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add driver for EETI touchpanels [v5]
Date: Tue, 19 May 2009 19:30:06 -0700
Message-ID: <20090520023006.GC17649@dtor-d630.eng.vmware.com>
References: <20090516173226.GA1448@buzzloop.caiaq.de> <1242495290-11497-1-git-send-email-daniel@caiaq.de> <20090516205719.15fbec97@hyperion.delvare> <20090519090143.GC25674@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:30698 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZETCaM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 22:30:12 -0400
Received: by rv-out-0506.google.com with SMTP id f9so51281rvb.1
        for <linux-input@vger.kernel.org>; Tue, 19 May 2009 19:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519090143.GC25674@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Jean Delvare <khali@linux-fr.org>, linux-input@vger.kernel.org

On Tue, May 19, 2009 at 11:01:43AM +0200, Daniel Mack wrote:
> On Sat, May 16, 2009 at 08:57:19PM +0200, Jean Delvare wrote:
> > On Sat, 16 May 2009 19:34:50 +0200, Daniel Mack wrote:
> > > This patch adds a driver for EETI's I2C connected touchscreens.
> > > 
> > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > Tested-by: Sven Neumann <s.neumann@raumfeld.com>
> > > Cc: Jean Delvare <khali@linux-fr.org>
> > > ---
> > >  drivers/input/touchscreen/Kconfig   |    9 +
> > >  drivers/input/touchscreen/Makefile  |    1 +
> > >  drivers/input/touchscreen/eeti_ts.c |  286 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 296 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/input/touchscreen/eeti_ts.c
> > 
> > For the i2c part:
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Thanks!
> 
> Dmitry, any more thoughts about that, or is it ready for your tree?
> 

Applied to the 'next' branch, thank you Daniel.

-- 
Dmitry
