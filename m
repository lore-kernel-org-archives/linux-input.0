From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Tue, 10 Jan 2012 23:38:12 -0800
Message-ID: <20120111073812.GB18668@core.coreip.homeip.net>
References: <20120110102211.GA7682@polaris.bitmath.org>
 <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
 <20120110114212.GA2142@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65440 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752498Ab2AKHiS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 02:38:18 -0500
Received: by obbup16 with SMTP id up16so474837obb.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 23:38:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120110114212.GA2142@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On Tue, Jan 10, 2012 at 12:42:12PM +0100, Henrik Rydberg wrote:
> On Tue, Jan 10, 2012 at 12:56:49PM +0200, Jussi Pakkanen wrote:
> > Some bcm5974 trackpads have a physical button beneath the physical surface.
> > This patch sets the property bit so user space applications can
> > detect the trackpad type and act accordingly.
> > 
> > Signed-off-by: Jussi Pakkanen <jussi.pakkanen@canonical.com>
> > Cc: stable@vger.kernel.org

Applied, however I removed stable notation as this change IMO does not
qualify for the stable since it does not address a regression.

Thanks.

> > ---
> >  drivers/input/mouse/bcm5974.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> > index 5ec617e..913e9fa 100644
> > --- a/drivers/input/mouse/bcm5974.c
> > +++ b/drivers/input/mouse/bcm5974.c
> > @@ -433,6 +433,9 @@ static void setup_events_to_report(struct input_dev *input_dev,
> >  	__set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
> >  	__set_bit(BTN_LEFT, input_dev->keybit);
> >  
> > +	if (cfg->caps & HAS_INTEGRATED_BUTTON)
> > +		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> > +
> >  	input_set_events_per_packet(input_dev, 60);
> >  }
> >  
> > -- 
> > 1.7.5.4
> > 
> 
>     Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Thanks,
> Henrik

-- 
Dmitry
