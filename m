From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] Input: Add EVIOC mechanism for MT slots
Date: Mon, 23 Jan 2012 10:52:48 +0100
Message-ID: <20120123095248.GA6667@polaris.bitmath.org>
References: <1326396275-2492-1-git-send-email-rydberg@euromail.se>
 <4F0FEC84.7020605@canonical.com>
 <20120113091556.GA21749@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:52156 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab2AWJxB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jan 2012 04:53:01 -0500
Content-Disposition: inline
In-Reply-To: <20120113091556.GA21749@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

> > > +static int evdev_handle_mt_request(struct input_dev *dev,
> > > +				   unsigned int size,
> > > +				   int __user *ip)
> > > +{
> > > +	const struct input_mt_slot *mt = dev->mt;
> > > +	unsigned int code;
> > > +	int i;
> > > +
> > > +	if (get_user(code, &ip[0]))
> > > +		return -EFAULT;
> > > +	if (!input_is_mt_value(code))
> > > +		return -EINVAL;
> > > +
> > > +	if (size < sizeof(struct input_mt_request) + dev->mtsize * sizeof(int))
> > > +		return -EINVAL;
> > 
> > Why not fill in up to the size of the array provided?
> 
> Yes, I think we do the same with other ioctls as well.

Agreed, will do it that way.

> > > +/**
> > > + * struct input_mt_request - used by EVIOCGMTSLOTS ioctl
> > > + * @code: ABS_MT code to read
> > > + * @num_values: number of values written to the value array
> > > + * @values: value array, one value per slot
> > > + *
> > > + * The structure is used to retrieve MT slot data. Before the call,
> > > + * code is set to the wanted ABS_MT event type. On return, the value
> > > + * array is filled with the slot values for the specified ABS_MT code,
> > > + * and num_values is set to the actual number of slots.
> > > + *
> > > + * The call argument (len) is the size of the return buffer, satisfying
> > > + *
> > > + * len >= sizeof(input_mt_request) + sizeof(__s32) * number_of_slots
> > > + *
> > > + * If the request code is not an ABS_MT value, or if len is too small,
> > > + * -EINVAL is returned.
> > > + */
> > > +struct input_mt_request {
> > > +	__u32 code;
> > > +	__u32 num_values;
> 
> Hmm, might avoid this one... Userspace can do EVIOCGABS to get number of
> slots and then it will know how much data EVIOCGMTSLOTS will return...

I think it might be good to keep the length, to avoid possible future
synchronization problems. Perhaps we could get rid of the structure
though, for instance by specifying the write as a 32-bit code and the
read buffer as length, value, value...

Thanks,
Henrik
