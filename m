From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: tegra-kbc: add NULL check on of_match_device()
 return value
Date: Mon, 10 Jul 2017 10:42:55 -0700
Message-ID: <20170710174255.GB23984@dtor-ws>
References: <20170707062758.GA17584@embeddedgus>
 <ec9b399b-ad14-21eb-9a2e-649f0dd1d489@nvidia.com>
 <20170707093041.GC15652@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33165 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbdGJRm7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 13:42:59 -0400
Content-Disposition: inline
In-Reply-To: <20170707093041.GC15652@ulmo.fritz.box>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 07, 2017 at 11:30:41AM +0200, Thierry Reding wrote:
> On Fri, Jul 07, 2017 at 08:42:32AM +0100, Jon Hunter wrote:
> > 
> > On 07/07/17 07:27, Gustavo A. R. Silva wrote:
> > > Check return value from call to of_match_device()
> > > in order to prevent a NULL pointer dereference.
> > > 
> > > In case of NULL print error message and return -ENODEV
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> > > ---
> > >  drivers/input/keyboard/tegra-kbc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> > > index 0c07e10..742c5ac 100644
> > > --- a/drivers/input/keyboard/tegra-kbc.c
> > > +++ b/drivers/input/keyboard/tegra-kbc.c
> > > @@ -617,6 +617,10 @@ static int tegra_kbc_probe(struct platform_device *pdev)
> > >  	const struct of_device_id *match;
> > >  
> > >  	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
> > > +	if (!match) {
> > > +		dev_err(&pdev->dev, "failed to match device\n");
> > > +		return -ENODEV;
> > > +	}
> > 
> > Given that Tegra always uses device-tree, I believe that this cannot
> > happen and so this additional check is not needed.
> 
> I think you can make it happen if you manually create the platform
> device with a name matching that of the driver. But you really shouldn't
> be doing that, so might as well let it crash and burn so that people
> realize their mistake early.
> 
> Errors are easily overlooked, crashes are not.

Agree.

Thanks.

-- 
Dmitry
