From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: touchscreen: mc13783_ts:  Remove deprecated
 create_singletheread_workqueue
Date: Tue, 23 Aug 2016 13:53:09 -0700
Message-ID: <20160823205309.GE6712@dtor-ws>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
 <0fec13b74998216009d338fad3e143a3488e0b4a.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0fec13b74998216009d338fad3e143a3488e0b4a.1471151622.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Aug 14, 2016 at 10:55:30AM +0530, Bhaktipriya Shridhar wrote:
> The workqueue "workqueue" has a single workitem(&priv->work) and hence
> doesn't require ordering. Also, it is not being used on a memory reclaim
> path. Hence, the singlethreaded workqueue has been replaced with the use
> of system_wq.
> 
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreaded
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> created with create_singlethread_workqueue(), system_wq allows multiple
> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
> 
> Workitem is sync cancelled in mc13783_ts_remove() to ensure that there
> are no workitems pending when the driver is disconnected.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Applied, thank you. But:

> @@ -233,7 +222,7 @@ static int mc13783_ts_remove(struct platform_device *pdev)
>  {
>  	struct mc13783_ts_priv *priv = platform_get_drvdata(pdev);
> 
> -	destroy_workqueue(priv->workq);
> +	cancel_delayed_work_sync(&priv->work);

This is not needed, we cancel work in mc13783_ts_close(). I dropped this
bit.

>  	input_unregister_device(priv->idev);
>  	kfree(priv);
> 
> --
> 2.1.4
> 

-- 
Dmitry
