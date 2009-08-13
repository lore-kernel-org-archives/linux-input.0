From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Thu, 13 Aug 2009 13:47:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908131343290.25797@wotan.suse.de>
References: <200908062247.29254.lamarque@gmail.com> <alpine.LNX.2.00.0908080237090.25797@wotan.suse.de> <200908072223.21450.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36845 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758AbZHMLrI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 07:47:08 -0400
In-Reply-To: <200908072223.21450.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 7 Aug 2009, Lamarque Vieira Souza wrote:

> >
> > - compile the kernel with CONFIG_HID_DEBUG option set
> > - modprobe the 'hid' module with 'debug=2' option
> >
> > and provide the dmesg output that appears when the device is
> > connected (so that we have contents of the HID report descriptor and
> > kernel interpretation of it) and also after the data packet containing the
> > mentioned sequence has been received?
> 	Here is the dmesg output. The mouse constantly emmits those 9-bytes frames 
> even if I do not touch it, which probably is why it also affects my notebook's 
> touchpad.

Hi, 

what kernel is this? The log seems to be very incomplete. What I am 
missing the most is

- report descriptor dump and interpretation (we can see that the report 
  descriptor has been successfully parsed at 408673.371808, but we don't 
  see the descriptor dump before -- maybe it scrolled away already?)
- The interpretation of input data is missing (no "hid-input" line as 
  result of hid_dump_input() being called through 
  hid_input_field()->hid_process_event()). Are you sure you have modprobe 
  the hid module with 'debug=2' parameter?

Thanks,

-- 
Jiri Kosina
SUSE Labs
