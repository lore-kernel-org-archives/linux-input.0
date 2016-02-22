From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH]  Input: colibri-vf50-ts - call iio_channel_release_all()
 in all error paths
Date: Mon, 22 Feb 2016 11:39:42 -0800
Message-ID: <20160222193942.GC26177@dtor-ws>
References: <1455459049-5690-1-git-send-email-festevam@gmail.com>
 <20160215050247.GA16995@Sanchayan-Arch.toradex.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35604 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbcBVTjp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 14:39:45 -0500
Received: by mail-pf0-f176.google.com with SMTP id c10so100850340pfc.2
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2016 11:39:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160215050247.GA16995@Sanchayan-Arch.toradex.int>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: maitysanchayan@gmail.com
Cc: Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

On Mon, Feb 15, 2016 at 10:32:47AM +0530, maitysanchayan@gmail.com wrote:
> Hello Fabio,
> 
> On 16-02-14 12:10:49, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > We need to make sure to call iio_channel_release_all() in all error
> > paths of the probe function.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> > ---
> > Build-tested only.
> > 
> >  drivers/input/touchscreen/colibri-vf50-ts.c | 39 ++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
> > index 69828d0..67f8a17 100644
> > --- a/drivers/input/touchscreen/colibri-vf50-ts.c
> > +++ b/drivers/input/touchscreen/colibri-vf50-ts.c
> > @@ -279,9 +279,8 @@ static int vf50_ts_probe(struct platform_device *pdev)
> >  
> >  	error = devm_add_action(dev, vf50_ts_channel_release, channels);
> >  	if (error) {
> > -		iio_channel_release_all(channels);
> >  		dev_err(dev, "Failed to register iio channel release action");
> > -		return error;
> > +		goto channel_release;
> >  	}
> 
> As far as my understanding goes, from the discussion which happened during the
> submission of the patchset for this driver, the channel release gets taken care
> by the vf50_ts_channel_release function. Once it is successfully registered with
> devm_add_action, any further error returns in probe, will result in this function
> being called and the channels getting released.

That is correct, devm_add_action injects a custom action into devm
release sequence, so we should be releasing all channels when bailing
out due to an error.

Thanks.

-- 
Dmitry
