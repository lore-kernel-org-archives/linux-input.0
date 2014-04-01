From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: uhid: Add UHID_CREATE2 + UHID_INPUT2
Date: Tue, 1 Apr 2014 18:30:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404011829440.31825@pobox.suse.cz>
References: <20140324205001.981DD100D4F@puck.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46691 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbaDAQa0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Apr 2014 12:30:26 -0400
In-Reply-To: <20140324205001.981DD100D4F@puck.mtv.corp.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: linux-input@vger.kernel.org, dh.herrmann@gmail.com

On Mon, 24 Mar 2014, Petri Gynther wrote:

> UHID_CREATE2:
> HID report descriptor data (rd_data) is an array in struct uhid_create2_req,
> instead of a pointer. Enables use from languages that don't support pointers,
> e.g. Python.
> 
> UHID_INPUT2:
> Data array is the last field of struct uhid_input2_req. Enables userspace to
> write only the required bytes to kernel (ev.type + ev.u.input2.size + the part
> of the data array that matters), instead of the entire struct uhid_input2_req.
> 
> Note:
> UHID_CREATE2 increases the total size of struct uhid_event slightly, thus
> increasing the size of messages that are queued for userspace. However, this
> won't affect the userspace processing of these events.
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

I have adjusted it slightly to accomodate the hid_get_raw_report() and 
hid_output_raw_report() API changes and pushed it out.

-- 
Jiri Kosina
SUSE Labs
