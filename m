From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 10 Jun 2016 07:45:41 -0700
Message-ID: <1465569941.10525.17.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
	 <1465509287.24319.3.camel@linux.intel.com>
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
	 <1465566904.10525.11.camel@linux.intel.com>
	 <1465568791.7409.38.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465568791.7409.38.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Darren Hart <darren-P76s1CtE8BHQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-10 at 16:26 +0200, Bastien Nocera wrote:
> On Fri, 2016-06-10 at 06:55 -0700, Srinivas Pandruvada wrote:
> > On Fri, 2016-06-10 at 10:44 +0100, Grant Likely wrote:
> > [...]
> > >=20
> > > Yes, I do see the in_*_raw_* files in sysfs, and I'm able to get
> > > data
> > > out of them. Gnome also seems to recognize that the
> > > accelerometers
> > > are
> > > there because it adds a rotation lock button to the system menu.
> > >=20
> > > However, the events are getting through yet. It may be that I'm
> > > missing something in my kernel config. I'm rebuilding the kernel
> > > with
> > > Debian's config for the 4.5.5 kernel as a quick sanity test. I'll
> > > report back when I've tried.
> > >=20
> > You need to add in /usr/lib/system/systemd/iio-sensor-*
> >=20
> > After=3Dmulti-user.target
> >=20
> >=20
> > This service starts too early.
>=20
> Nobody has been able to explain to me why that would be a problem.
>=20
> Can you back this up with some data? Does iio-sensor-proxy exit too
> early? Does that leave time to the IIO sub-system to do some init
> work
> it should already have done?
The driver's =C2=A0trigger callback doesn't even get called to take any
action or provide any data. So to get called need to restart the
service or do suspend/resume.
After=3Dmulti-user.target, is not the ideal solution as it is too late.
So need further debug.

>=20
> See also=C2=A0https://github.com/hadess/iio-sensor-proxy/issues/82
>=20
> > > I'll also take some time and review the patch series later this
> > > afternoon.
> >=20
> > Atri Bhattacharya reported issues with suspend/resume. With my test
> > patches it is fixed for him
> >=20
> > If you want to hold on, I will repost with fixes for susend/resume.
>=20
