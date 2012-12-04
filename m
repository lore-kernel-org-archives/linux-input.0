From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] input: wacom - Prepare for syncing with input-mt
 changes
Date: Tue, 4 Dec 2012 19:54:56 +0100
Message-ID: <20121204185456.GA1728@polaris.bitmath.org>
References: <1354570740-2313-1-git-send-email-pingc@wacom.com>
 <20121204161021.GA1427@polaris.bitmath.org>
 <CAF8JNhJiLznSSDpzGzcp5CiWfcmGw-idkHX3+XCpvmHdZDKP8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:49171 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab2LDSxI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 13:53:08 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b31.telenor.se (Postfix) with ESMTP id 94729EAD19
	for <linux-input@vger.kernel.org>; Tue,  4 Dec 2012 19:53:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAF8JNhJiLznSSDpzGzcp5CiWfcmGw-idkHX3+XCpvmHdZDKP8g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

> > So the (touch_max > 1) logic replaces the branching on features and device
> > type?
> 
> There are only two types of devices defined for features->device_type:
> BTN_TOOL_PEN and BTN_TOOL_FINGER.
> 
> Once we come to !BTN_TOOL_PEN, we are dealing with touch devices.
> 
> The first if-statement assigns ABS_X/Y for number of contacts less or
> equal to 2. So, it is single and 2 finger touch devices. 2 finger
> touch devices are processed here since they will not use the new
> input_mt_init_slots call, which does not offer benefit to the devices.
> 
> input_mt_init_slots() will take care of ABS_X/Y assignment when flags
> are not zero. All touch devices with more than two contacts will use
> the new input_mt_init_slots call with non-zero flags.
> 
> The second if-statement is for all MT devices, which include two
> finger touch devices.

Great writeup - it could be worth using some of it in the commit
message. :-)

Thanks,
Henrik
