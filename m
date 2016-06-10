From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 10 Jun 2016 08:23:47 -0700
Message-ID: <1465572227.24319.7.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
	 <1465509287.24319.3.camel@linux.intel.com>
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
	 <1465566904.10525.11.camel@linux.intel.com>
	 <1465568791.7409.38.camel@hadess.net>
	 <1465569941.10525.17.camel@linux.intel.com>
	 <1465571076.7409.39.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465571076.7409.39.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Darren Hart <darren-P76s1CtE8BHQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
> >=20

[...]

> Are there any errors when setting the triggers?
>=20
Is there any debug option in this service to give more verbose output?


> The code there is probably a bit naive, but I'd rather fix that
> rather
> than postpone the start of the daemon.
Agree, we shouldn't postpone.=C2=A0

Thanks,
Srinivas

>=20
> >=20
> > After=3Dmulti-user.target, is not the ideal solution as it is too
> > late.
> > So need further debug.
> >=20
> > >=20
> > >=20
> > > See also=C2=A0https://github.com/hadess/iio-sensor-proxy/issues/8=
2
> > >=20
> > > >=20
> > > > >=20
> > > > > I'll also take some time and review the patch series later
> > > > > this
> > > > > afternoon.
> > > > Atri Bhattacharya reported issues with suspend/resume. With my
> > > > test
> > > > patches it is fixed for him
> > > >=20
> > > > If you want to hold on, I will repost with fixes for
> > > > susend/resume.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > input" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-=
info.html
