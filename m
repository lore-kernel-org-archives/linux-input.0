From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 10 Jun 2016 17:04:36 +0200
Message-ID: <1465571076.7409.39.camel@hadess.net>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>	
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>	
	 <1465509287.24319.3.camel@linux.intel.com>	
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>	
	 <1465566904.10525.11.camel@linux.intel.com>	
	 <1465568791.7409.38.camel@hadess.net>
	 <1465569941.10525.17.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41875 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcFJPEq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2016 11:04:46 -0400
In-Reply-To: <1465569941.10525.17.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>

On Fri, 2016-06-10 at 07:45 -0700, Srinivas Pandruvada wrote:
> On Fri, 2016-06-10 at 16:26 +0200, Bastien Nocera wrote:
> > On Fri, 2016-06-10 at 06:55 -0700, Srinivas Pandruvada wrote:
> > > On Fri, 2016-06-10 at 10:44 +0100, Grant Likely wrote:
> > > [...]
> > > >=20
> > > > Yes, I do see the in_*_raw_* files in sysfs, and I'm able to
> > > > get
> > > > data
> > > > out of them. Gnome also seems to recognize that the
> > > > accelerometers
> > > > are
> > > > there because it adds a rotation lock button to the system
> > > > menu.
> > > >=20
> > > > However, the events are getting through yet. It may be that I'm
> > > > missing something in my kernel config. I'm rebuilding the
> > > > kernel
> > > > with
> > > > Debian's config for the 4.5.5 kernel as a quick sanity test.
> > > > I'll
> > > > report back when I've tried.
> > > >=20
> > > You need to add in /usr/lib/system/systemd/iio-sensor-*
> > >=20
> > > After=3Dmulti-user.target
> > >=20
> > >=20
> > > This service starts too early.
> >=20
> > Nobody has been able to explain to me why that would be a problem.
> >=20
> > Can you back this up with some data? Does iio-sensor-proxy exit too
> > early? Does that leave time to the IIO sub-system to do some init
> > work
> > it should already have done?
> The driver's =C2=A0trigger callback doesn't even get called to take a=
ny
> action or provide any data. So to get called need to restart the
> service or do suspend/resume.

Are there any errors when setting the triggers?

The code there is probably a bit naive, but I'd rather fix that rather
than postpone the start of the daemon.

> After=3Dmulti-user.target, is not the ideal solution as it is too lat=
e.
> So need further debug.
>=20
> >=20
> > See also=C2=A0https://github.com/hadess/iio-sensor-proxy/issues/82
> >=20
> > > > I'll also take some time and review the patch series later this
> > > > afternoon.
> > >=20
> > > Atri Bhattacharya reported issues with suspend/resume. With my
> > > test
> > > patches it is fixed for him
> > >=20
> > > If you want to hold on, I will repost with fixes for
> > > susend/resume.
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
