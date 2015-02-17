From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] HID: hid-sensor-hub: Enhance get feature report
 API
Date: Tue, 17 Feb 2015 13:39:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171338390.2279@pobox.suse.cz>
References: <1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1421455165-3944-2-git-send-email-srinivas.pandruvada@linux.intel.com> <54CE018F.9010600@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54CE018F.9010600-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 1 Feb 2015, Jonathan Cameron wrote:

> On 17/01/15 00:39, Srinivas Pandruvada wrote:
> > Some hid sensor feature report can contain more than one reports.
> > This API can now support receiving multiple values from the feature
> > report.
> > Also update the parameters in the users of this API.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Oops, commented on old version.
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

I don't seem to have been CCed on v2 submission of this series. Srinivas, 
could you please resend to me with Jonathan's ack added?

-- 
Jiri Kosina
SUSE Labs
