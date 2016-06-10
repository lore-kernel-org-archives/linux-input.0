From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 10 Jun 2016 17:27:32 +0200
Message-ID: <1465572452.7409.41.camel@hadess.net>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>	
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>	
	 <1465509287.24319.3.camel@linux.intel.com>	
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>	
	 <1465566904.10525.11.camel@linux.intel.com>	
	 <1465568791.7409.38.camel@hadess.net>	
	 <1465569941.10525.17.camel@linux.intel.com>	
	 <1465571076.7409.39.camel@hadess.net>
	 <1465572227.24319.7.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465572227.24319.7.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Darren Hart <darren-P76s1CtE8BHQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-10 at 08:23 -0700, Srinivas Pandruvada wrote:
> On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
> > > 
> 
> [...]
> 
> > Are there any errors when setting the triggers?
> > 
> Is there any debug option in this service to give more verbose
> output?

Add:
Environment="G_MESSAGES_DEBUG=all"

To the service file. You should see the debug in systemctl:
systemctl status iio-sensor-proxy.service

Or in journalctl if there's too much data:
journalctl --reverse -u iio-sensor-proxy.service

Cheers
