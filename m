From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Date: Mon, 20 Jun 2016 11:29:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606201129060.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>  <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>  <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm> <1466197963.24319.110.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466197963.24319.110.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, chaya.golan@intel.com, daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
List-Id: linux-input@vger.kernel.org

On Fri, 17 Jun 2016, Srinivas Pandruvada wrote:

> > > +config INTEL_ISH_HID_TRANSPORT
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n
> > > +
> > > +config INTEL_ISH_HID
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Intel Integrated Sensor Hub"
> >=20
> > Why can't the transport driver be built as a module?
> In current use case for PM, we don't want anyone to unload and
> complain.

Sorry, I don't understand this explanation, could you please elaborate?

Thanks,

--=20
Jiri Kosina
SUSE Labs
