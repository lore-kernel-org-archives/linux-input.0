From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: hid-sensor-hub: Remove hard coded indexes
Date: Mon, 17 Feb 2014 15:10:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171509530.1192@pobox.suse.cz>
References: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.LNX.2.00.1401291412230.21385@pobox.suse.cz> <52F619C9.8060701@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52F619C9.8060701-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 8 Feb 2014, Jonathan Cameron wrote:

> > > Remove the hard coded indexes, instead search for usage id and
> > > use the index to set the power and report state.
> > > This will fix issue, where the report descriptor doesn't contain
> > > the full list of possible selector for power and report state.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > 
> > Jonathan, I'd probably take this together with the patch for HID API
> > change. Could you please provide your Ack/Signoff, and I'll take it
> > through my tree, if you agree?
> Agreed. Help yourself ;)

Thanks! Now applied.

> Thanks and sorry for the slow response.  Amazing the backlog that builds
> up if you take about 3 weeks out (more or less)

Yeah, it basically immediately destroys all the energy you gained during 
the time off :)

-- 
Jiri Kosina
SUSE Labs
