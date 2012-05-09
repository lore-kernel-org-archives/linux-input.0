From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol detection
Date: Wed, 9 May 2012 21:56:32 +0200
Message-ID: <20120509195632.GA12406@polaris.bitmath.org>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
 <1336136030-18503-2-git-send-email-benjamin.tissoires@gmail.com>
 <20120506190146.GA12571@polaris.bitmath.org>
 <CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:52109 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab2EITvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 15:51:17 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > Why not skip the pointer here?
> 
> well, the idea was to keep the memory footprint low. As these values
> are only needed at init, then I freed them once I finished using them.
> I can of course skip the pointer, but in that case, wouldn't the
> struct declaration be worthless?

My bad, I misread the placement of the free() statement. I was also
concerned about memory, since HID is big enough a memory hog as it
is. Barring the added complexity of this patch, it now makes more
sense.

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
