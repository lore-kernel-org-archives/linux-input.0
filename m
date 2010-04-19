From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ABS_MAX incrementation?
Date: Mon, 19 Apr 2010 10:49:25 -0700
Message-ID: <20100419174924.GB22295@core.coreip.homeip.net>
References: <20100419171412.GH30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50348 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab0DSRth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 13:49:37 -0400
Received: by bwz19 with SMTP id 19so1822bwz.21
        for <linux-input@vger.kernel.org>; Mon, 19 Apr 2010 10:49:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100419171412.GH30801@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

Hi Daniel,

On Mon, Apr 19, 2010 at 07:14:12PM +0200, Daniel Mack wrote:
> Hi,
> 
> I'm planning to write a driver for a device with a number of absolute
> axis and 16 pressure-sensitive trigger pads. Alltogether, it will have
> more absoulte axis informations than the API in include/input.h is able
> to represent. More than that, the definitions I'm referring to won't
> describe the actual information in a sane way. I'm uncertain whether
> this list can be extended by something like the patch below. Or is this
> a nonono as it breaks existing user space applications? Any other idea
> of how to solve this?
>

Extending the number of axes should be possible (we have done that for
number of keys/buttons not that long ago) and yes, userspace breakages
are possible but are most likely userspace fault.

The fact that data is purely device specific is a bit disconcerning, but
I understand that not every device uses commonly defined events. It _is_
an input device though, right?

I wonder if ofr this kinde of "flex" pads we could move into 2-event
notification so as not to expand the number of "axes" forever - use
ABS_PAD to transmit pad number and ABS_MISC to transmit actual value.
Such scheme will not allow comminucate min and max values for dpads
though, so not very good...

Another issue is that ABS data is pretty large, it would be nice if we
moved from this data being always present ininput device structure to
having drivers allocate it when needed.

Thanks.

-- 
Dmitry
