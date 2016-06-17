From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Date: Fri, 17 Jun 2016 14:09:05 -0700
Message-ID: <1466197745.24319.106.camel@linux.intel.com>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
	 <alpine.LNX.2.00.1606172243590.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1606172243590.6874@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, chaya.golan@intel.com, daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-17 at 22:45 +0200, Jiri Kosina wrote:
> On Fri, 17 Jun 2016, Jiri Kosina wrote:
>=20
> > > +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device
> *dev,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uuid_le uuid, char
> *name)
> > > +{
> >=C2=A0
> > Should be static.
>=20
> Actually, going deeper into the code and trying to untangle all the=C2=
=A0
> dependencies, there are quite a few more in other ipc.c, hid-
> client.c,=C2=A0
> etc. Please fix that globally in the next iteration.
>=20
Great. I ran sparse and identified few more. I will fix this is new
iteration.

One thing I am still wondering is that the current ISH model is built
in only. Some distros configure CONFIG_HID as module. So in Kconfig in=C2=
=A0
drivers/hid/intel-ish-hid/, I need to add "select HID".
What do you think about this?

Unless you are in middle of review, I want to go ahead and send v2.


Thanks,
Srinivas

> Thanks,
>=20
> --=C2=A0
> Jiri Kosina
> SUSE Labs
>=20
