From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Date: Fri, 17 Jun 2016 22:45:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172243590.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, chaya.golan@intel.com, daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
List-Id: linux-input@vger.kernel.org

On Fri, 17 Jun 2016, Jiri Kosina wrote:

> > +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
> > +					     uuid_le uuid, char *name)
> > +{
> 
> Should be static.

Actually, going deeper into the code and trying to untangle all the 
dependencies, there are quite a few more in other ipc.c, hid-client.c, 
etc. Please fix that globally in the next iteration.

Thanks,

-- 
Jiri Kosina
SUSE Labs
