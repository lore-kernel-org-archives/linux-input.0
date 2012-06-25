From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 01/22 v4] Input: atmel_mxt_ts - set phys to i2c client
 adapter name
Date: Mon, 25 Jun 2012 10:15:58 +0200
Message-ID: <20120625081558.GA641@polaris.bitmath.org>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
 <1339992522-22073-2-git-send-email-djkurtz@chromium.org>
 <20120621084107.GB2193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:59907 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2FYIMw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 04:12:52 -0400
Content-Disposition: inline
In-Reply-To: <20120621084107.GB2193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org

On Thu, Jun 21, 2012 at 01:41:07AM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 18, 2012 at 12:08:21PM +0800, Daniel Kurtz wrote:
> > This allows userspace to more easily distinguish which bus a particular
> > atmel_mxt_ts device is attached to.
> > 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 42e6450..eda9eed 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -1106,6 +1106,7 @@ static int __devinit mxt_probe(struct i2c_client *client,
> >  	}
> >  
> >  	input_dev->name = "Atmel maXTouch Touchscreen";
> > +	input_dev->phys = client->adapter->name;
> 
> Normally we set phys to 'xxx/input0' nstead of just the adaptor name.

Daniel, will we be seeing another version of this patch?

Thanks,
Henrik
