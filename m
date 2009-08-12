From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] [input] add mc13783 touchscreen driver
Date: Wed, 12 Aug 2009 09:01:28 -0700
Message-ID: <20090812163207.373B5526EC9@mailhub.coreip.homeip.net>
References: <1249981667-4366-1-git-send-email-s.hauer@pengutronix.de> <1249981667-4366-2-git-send-email-s.hauer@pengutronix.de> <1249981667-4366-3-git-send-email-s.hauer@pengutronix.de> <20090812024609.5EB8B526EC9@mailhub.coreip.homeip.net> <20090812111018.GC17992@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754134AbZHLQBm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090812111018.GC17992@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 12, 2009 at 01:10:18PM +0200, Sascha Hauer wrote:
> Hi Dmitry
> 
> On Tue, Aug 11, 2009 at 07:15:33PM -0700, Dmitry Torokhov wrote:
> > Hi Sascha,
> > 
> > On Tue, Aug 11, 2009 at 11:07:44AM +0200, Sascha Hauer wrote:
> > > +
> > > +	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
> > > +
> > > +	priv->workq = create_singlethread_workqueue("mc13783_ts");
> > 
> > Do you really need a separate workqueue? Would not keventd suffice?
> 
> Yes, I do. mc13783_adc_do_conversion() runs in a workqueue aswell. With
> keventd I would deadlock.
> 

I see. Then please add a comment why it is needed so nobody is tempted
to doa "cleanup" ;)

-- 
Dmitry
