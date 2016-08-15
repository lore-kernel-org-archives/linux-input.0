From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
Date: Mon, 15 Aug 2016 09:42:40 -0700
Message-ID: <1471279360.20508.20.camel@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <alpine.LNX.2.00.1608071214500.22028@cbobk.fhfr.pm>
	 <884e74df-569e-8218-fbda-f9c7ecfe1e5a@kernel.org>
	 <af2d1c90-a0ec-0888-8048-76463bf98ece@kernel.org>
	 <CAKdAkRS-sVHqQ1tUZWVxNTfX5=ZxFzbCAxvsJPHV4=85mdEeRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44423 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbcHOQo4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2016 12:44:56 -0400
In-Reply-To: <CAKdAkRS-sVHqQ1tUZWVxNTfX5=ZxFzbCAxvsJPHV4=85mdEeRA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org

On Mon, 2016-08-15 at 08:45 -0700, Dmitry Torokhov wrote:
> On Mon, Aug 15, 2016 at 7:52 AM, Jonathan Cameron <jic23@kernel.org>
> wrote:
> > 
> > On 15/08/16 15:07, Jonathan Cameron wrote:
> > > 
> > > On 07/08/16 11:15, Jiri Kosina wrote:
> > > > 
> > > > On Sun, 7 Aug 2016, Srinivas Pandruvada wrote:
> > > > 
> > > > > 
> > > > > Some platforms power off sensor hubs during S3 suspend, which
> > > > > will require
> > > > > longer time to resume. This hurts system resume time, so
> > > > > resume
> > > > > asynchronously.
> > > > > 
> > > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux
> > > > > .intel.com>
> > > > Jonathan, are you going to cherry-pick this patch from the
> > > > series?
> > > > Alternatively, if you're okay with it, I can pull it in
> > > > together with the
> > > > whole set with your Acked-by or Reviewed-by.
> > > > 
> > > I'll take it via IIO. Got a bit of catching up to do (been on
> > > holiday)
> > Applied to the togreg branch of iio.git - initially pushed out as
> > testing for the autobuilders to play with it.
> > This one is not really connected to the others so makes sense to
> > take it separately.
> > 
> > I'm out of my depth on the rest of the patches in this series
> > and don't have time to learn enough to follow them! Sorry I
> > can't help on that front.
> About this patch: me sees a new work, me does not see new calls to
> cancel_work_sync() or flush_work() anywhere, me gets worried.
This work is scheduled during resume and is not delayed call. Only time
really we need to cancel or flush if module is unloaded before resume
work, not sure if this case realistic. Do you see any other case
possible?

Thanks,
Srinivas

> 
> Thanks.
> 
