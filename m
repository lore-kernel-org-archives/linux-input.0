From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Wed, 4 Jan 2017 13:59:30 +0100
Message-ID: <20170104125930.GA8296@kroah.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
 <1482456149-4841-7-git-send-email-even.xu@intel.com>
 <alpine.LSU.2.20.1701031050510.28985@cbobk.fhfr.pm>
 <1483512029.25176.7.camel@intel.com>
 <alpine.LSU.2.20.1701041032150.28985@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1701041032150.28985@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Xu, Even" <even.xu@intel.com>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 04, 2017 at 10:36:18AM +0100, Jiri Kosina wrote:
> On Wed, 4 Jan 2017, Xu, Even wrote:
> 
> > > [ ... snip ... ]
> > > > 
> > > > +static ssize_t ishtp_cl_write(struct file *file, const char __user
> > > > *ubuf,
> > > > +	size_t length, loff_t *offset)
> > > > +{
> > > > +	struct ishtp_cl_miscdev *ishtp_cl_misc = file-
> > > > >private_data;
> > > > +	struct ishtp_cl *cl;
> > > > +	void *write_buf;
> > > > +	struct ishtp_device *dev;
> > > > +	int ret;
> > > > +
> > > > +	/* Non-blocking semantics are not supported */
> > > > +	if (file->f_flags & O_NONBLOCK) {
> > > > +		ret = -EINVAL;
> > > > +		goto out_unlock;
> > > When taking the error path here you'd try to unlock 
> > > ishtp_cl_misc->cl_mutex before actually acquiring it.
> > > 
> > 
> > Thanks for your comments, Jiri, I update my patch below:
> 
> Greg, how would you like to handle this (after you're done with reviewing 
> it of course), given that this driver depends on the preceeding 6 patches 
> to intel-ish-hid driver?

Let me go review it now, but if it's ok, I have no problem taking it in
my tree, or if you want to take it through yours, that's fine with me,
which ever is easiest for you.

thanks,

greg k-h
