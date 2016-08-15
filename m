From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] Input: psmouse: Remove deprecated
 create_singletheread_workqueue
Date: Mon, 15 Aug 2016 18:53:45 -0400
Message-ID: <20160815225345.GC3672@mtj.duckdns.org>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
 <83fc8cbf4f5ef7b5e814353468b9ee9d5dd6d7d2.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34605 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbcHOWxr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2016 18:53:47 -0400
Content-Disposition: inline
In-Reply-To: <83fc8cbf4f5ef7b5e814353468b9ee9d5dd6d7d2.1471151622.git.bhaktipriya96@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 14, 2016 at 10:53:07AM +0530, Bhaktipriya Shridhar wrote:
> alloc_ordered_workqueue replaces the deprecated
> create_singlethread_workqueue.
> 
> There are multiple work items on the work queue viz
> &priv->dev3_register_work, &priv->recalib_wq, &psmouse->resync_work,
> which require execution ordering. Hence, an ordered workqueue has been
> used.
> 
> The workqueue is not being used on a memory reclaim path.
> Hence, WQ_MEM_RECLAIM has not been set.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
