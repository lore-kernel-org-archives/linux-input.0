From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: lenovo-tpkbd: Fix memory leak in
 tpkbd_remove_tp()
Date: Mon, 17 Sep 2012 12:56:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171256290.31149@pobox.suse.cz>
References: <1347513912.3319.1.camel@phoenix> <20120914113527.02666021@bernhard-seibold.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43069 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914Ab2IQK4q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 06:56:46 -0400
In-Reply-To: <20120914113527.02666021@bernhard-seibold.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bernhard Seibold <mail@bernhard-seibold.de>
Cc: Axel Lin <axel.lin@gmail.com>, linux-input@vger.kernel.org

On Fri, 14 Sep 2012, Bernhard Seibold wrote:

> On Thu, 13 Sep 2012 13:25:12 +0800
> Axel Lin <axel.lin@gmail.com> wrote:
> 
> > We need to kfree names for led_mute and led_micmute in
> > tpkbd_remove_tp().
> > 
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
> 
> Acked-by: Bernhard Seibold <mail@bernhard-seibold.de>

Applied, thanks.

> > ---
> >  drivers/hid/hid-lenovo-tpkbd.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-lenovo-tpkbd.c
> > b/drivers/hid/hid-lenovo-tpkbd.c index 77d2df0..60c4e1e 100644
> > --- a/drivers/hid/hid-lenovo-tpkbd.c
> > +++ b/drivers/hid/hid-lenovo-tpkbd.c
> > @@ -519,6 +519,8 @@ static void tpkbd_remove_tp(struct hid_device
> > *hdev) led_classdev_unregister(&data_pointer->led_mute);
> >  
> >  	hid_set_drvdata(hdev, NULL);
> > +	kfree(data_pointer->led_micmute.name);
> > +	kfree(data_pointer->led_mute.name);
> >  	kfree(data_pointer);
> >  }
> >  
> 

-- 
Jiri Kosina
SUSE Labs
