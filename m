From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: wm97xx: Remove deprecated
 create_singletheread_workqueue
Date: Tue, 23 Aug 2016 14:02:39 -0700
Message-ID: <20160823210239.GG6712@dtor-ws>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
 <e062d8979274f279bf6e6181c321647ac193146d.1471151622.git.bhaktipriya96@gmail.com>
 <20160823210133.GF6712@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160823210133.GF6712@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 23, 2016 at 02:01:33PM -0700, Dmitry Torokhov wrote:
> On Sun, Aug 14, 2016 at 10:56:38AM +0530, Bhaktipriya Shridhar wrote:
> > alloc_ordered_workqueue() with WQ_MEM_RECLAIM set, replaces
> > deprecated create_singlethread_workqueue(). This is the identity
> > conversion. The workqueue "ts_workq" has been identity converted.
> > 
> > It queues work items viz &wm->ts_reader and &wm->pen_event_work which map
> > to wm97xx_pen_irq_worker (handles a pen down interrupt) and
> > wm97xx_ts_reader (the touchscreen sample reader) respectively. Hence,
> > an ordered dedicated workqueue has been used.
> > 
> > WQ_MEM_RECLAIM has been set to ensure forward progress under memory
> > pressure.
> > 
> > Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> 
> Applied, thank you.

(Sans WQ_MEM_RECLAIM).

> 
> > ---
> >  drivers/input/touchscreen/wm97xx-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> > index 1534e9b..c0af844 100644
> > --- a/drivers/input/touchscreen/wm97xx-core.c
> > +++ b/drivers/input/touchscreen/wm97xx-core.c
> > @@ -500,7 +500,7 @@ static int wm97xx_ts_input_open(struct input_dev *idev)
> >  {
> >  	struct wm97xx *wm = input_get_drvdata(idev);
> > 
> > -	wm->ts_workq = create_singlethread_workqueue("kwm97xx");
> > +	wm->ts_workq = alloc_ordered_workqueue("kwm97xx", WQ_MEM_RECLAIM);
> >  	if (wm->ts_workq == NULL) {
> >  		dev_err(wm->dev,
> >  			"Failed to create workqueue\n");
> > --
> > 2.1.4
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
