From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: psmouse: Remove deprecated
 create_singletheread_workqueue
Date: Tue, 23 Aug 2016 13:51:22 -0700
Message-ID: <20160823205122.GD6712@dtor-ws>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
 <83fc8cbf4f5ef7b5e814353468b9ee9d5dd6d7d2.1471151622.git.bhaktipriya96@gmail.com>
 <20160815225345.GC3672@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160815225345.GC3672@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 15, 2016 at 06:53:45PM -0400, Tejun Heo wrote:
> On Sun, Aug 14, 2016 at 10:53:07AM +0530, Bhaktipriya Shridhar wrote:
> > alloc_ordered_workqueue replaces the deprecated
> > create_singlethread_workqueue.
> > 
> > There are multiple work items on the work queue viz
> > &priv->dev3_register_work, &priv->recalib_wq, &psmouse->resync_work,
> > which require execution ordering. Hence, an ordered workqueue has been
> > used.
> > 
> > The workqueue is not being used on a memory reclaim path.
> > Hence, WQ_MEM_RECLAIM has not been set.
> > 
> > Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Applied, thank you.

-- 
Dmitry
