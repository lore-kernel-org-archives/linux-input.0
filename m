From: Sean Young <sean@mess.org>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Thu, 27 Oct 2011 21:35:50 +0100
Message-ID: <20111027203549.GA6514@pequod.mess.org>
References: <20111026213705.GA32664@pequod.mess.org>
 <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
 <4EA9466F.4000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pequod.mess.org ([188.220.58.213]:41590 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab1J0Ufe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 16:35:34 -0400
Content-Disposition: inline
In-Reply-To: <4EA9466F.4000508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@bitmath.org>

On Thu, Oct 27, 2011 at 01:54:23PM +0200, Benjamin Tissoires wrote:
> Hi Sean, can you test the following patch please:
> 
> 
> From 488272baf9bc95718dba2b9a0f62fe3309ca578f Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Date: Thu, 27 Oct 2011 13:36:05 +0200
> Subject: [PATCH 1/2] hid-multitouch: fix interaction with other hid drivers

-snip-

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2572db9..09e3d9b 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1230,7 +1230,6 @@ int hid_connect(struct hid_device *hdev,
> unsigned int connect_mask)

Your patch got mangled -- for example, the line above got wrapped. I had
to apply it manually.

I've tested it and it works fine. I do not get the error nor the delay
with this applied, which is great.

Thanks!

Sean
