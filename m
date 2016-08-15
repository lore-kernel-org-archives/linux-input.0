From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] Input: wm97xx: Remove deprecated
 create_singletheread_workqueue
Date: Mon, 15 Aug 2016 18:53:33 -0400
Message-ID: <20160815225333.GB3672@mtj.duckdns.org>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
 <e062d8979274f279bf6e6181c321647ac193146d.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36256 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcHOWxf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2016 18:53:35 -0400
Content-Disposition: inline
In-Reply-To: <e062d8979274f279bf6e6181c321647ac193146d.1471151622.git.bhaktipriya96@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 14, 2016 at 10:56:38AM +0530, Bhaktipriya Shridhar wrote:
> alloc_ordered_workqueue() with WQ_MEM_RECLAIM set, replaces
> deprecated create_singlethread_workqueue(). This is the identity
> conversion. The workqueue "ts_workq" has been identity converted.
> 
> It queues work items viz &wm->ts_reader and &wm->pen_event_work which map
> to wm97xx_pen_irq_worker (handles a pen down interrupt) and
> wm97xx_ts_reader (the touchscreen sample reader) respectively. Hence,
> an ordered dedicated workqueue has been used.
> 
> WQ_MEM_RECLAIM has been set to ensure forward progress under memory
> pressure.

I'm not sure WQ_MEM_RECLAIM makes sense on an input driver.

Thanks.

-- 
tejun
