From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Sat, 8 Aug 2009 02:38:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908080237090.25797@wotan.suse.de>
References: <200908062247.29254.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60403 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918AbZHHAiy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Aug 2009 20:38:54 -0400
In-Reply-To: <200908062247.29254.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 6 Aug 2009, Lamarque Vieira Souza wrote:

> 	One think I have discovered is that when using hid session the 
> mouse send several 9-bytes frames with this content:  0x05 0xff 0x6e 
> 0x6f 0x54 0xc6 0x10 0x00 0x02 (or 0x03 instead of 0x02). If I filter 
> those frames in hidp_recv_intr_frame (linux/net/bluetooth/hidp/core.c) 
> before calling hid_input_report, the cursor does not get stucked but the 
> overhead of doing that is too high, the cursor gets sluggish. Using 
> input session instead of hid session gets muth better results and is not 
> as uggly as filtering frames. Can someone help me to find a better 
> solution?

Hi,

we'd need to know a little bit more to be able to interpret that data 
packet. Could you please

- compile the kernel with CONFIG_HID_DEBUG option set
- modprobe the 'hid' module with 'debug=2' option

and provide the dmesg output that appears when the device is 
connected (so that we have contents of the HID report descriptor and 
kernel interpretation of it) and also after the data packet containing the 
mentioned sequence has been received?

Thanks,

-- 
Jiri Kosina
SUSE Labs
