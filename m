From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Tue, 3 Jan 2017 10:54:00 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701031050510.28985@cbobk.fhfr.pm>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com> <1482456149-4841-7-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbdACJyG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Jan 2017 04:54:06 -0500
In-Reply-To: <1482456149-4841-7-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, andriy.shevchenko@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 23 Dec 2016, Even Xu wrote:

[ ... snip ... ]
> +static ssize_t ishtp_cl_write(struct file *file, const char __user *ubuf,
> +	size_t length, loff_t *offset)
> +{
> +	struct ishtp_cl_miscdev *ishtp_cl_misc = file->private_data;
> +	struct ishtp_cl *cl;
> +	void *write_buf;
> +	struct ishtp_device *dev;
> +	int ret;
> +
> +	/* Non-blocking semantics are not supported */
> +	if (file->f_flags & O_NONBLOCK) {
> +		ret = -EINVAL;
> +		goto out_unlock;

When taking the error path here you'd try to unlock 
ishtp_cl_misc->cl_mutex before actually acquiring it.

-- 
Jiri Kosina
SUSE Labs

