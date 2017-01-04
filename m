From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Wed, 4 Jan 2017 10:36:18 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701041032150.28985@cbobk.fhfr.pm>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>  <1482456149-4841-7-git-send-email-even.xu@intel.com>  <alpine.LSU.2.20.1701031050510.28985@cbobk.fhfr.pm> <1483512029.25176.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753262AbdADJgW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 4 Jan 2017 04:36:22 -0500
In-Reply-To: <1483512029.25176.7.camel@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Xu, Even" <even.xu@intel.com>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>

On Wed, 4 Jan 2017, Xu, Even wrote:

> > [ ... snip ... ]
> > > 
> > > +static ssize_t ishtp_cl_write(struct file *file, const char __user
> > > *ubuf,
> > > +	size_t length, loff_t *offset)
> > > +{
> > > +	struct ishtp_cl_miscdev *ishtp_cl_misc = file-
> > > >private_data;
> > > +	struct ishtp_cl *cl;
> > > +	void *write_buf;
> > > +	struct ishtp_device *dev;
> > > +	int ret;
> > > +
> > > +	/* Non-blocking semantics are not supported */
> > > +	if (file->f_flags & O_NONBLOCK) {
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > When taking the error path here you'd try to unlock 
> > ishtp_cl_misc->cl_mutex before actually acquiring it.
> > 
> 
> Thanks for your comments, Jiri, I update my patch below:

Greg, how would you like to handle this (after you're done with reviewing 
it of course), given that this driver depends on the preceeding 6 patches 
to intel-ish-hid driver?

Thanks,

-- 
Jiri Kosina
SUSE Labs

