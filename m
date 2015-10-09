From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] HID: multitouch: Fetch feature reports on demand for
 Win8 devices
Date: Fri, 9 Oct 2015 11:53:08 +0300
Message-ID: <20151009085308.GT1506@lahna.fi.intel.com>
References: <alpine.LNX.2.00.1510061606440.2758@pobox.suse.cz>
 <1444221223-33481-1-git-send-email-mika.westerberg@linux.intel.com>
 <20151007133409.GA25728@mail.corp.redhat.com>
 <20151007155620.GB118995@ubuntu-hedt>
 <5615C30A.5060503@synaptics.com>
 <20151008094057.GN1506@lahna.fi.intel.com>
 <561713FF.9000406@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59431 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933099AbbJIIxN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Oct 2015 04:53:13 -0400
Content-Disposition: inline
In-Reply-To: <561713FF.9000406@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Seth Forshee <seth.forshee@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 08, 2015 at 06:10:23PM -0700, Andrew Duggan wrote:
> No, this touchpad doesn't have HID_QUIRK_NO_INIT_REPORTS set and
> usbhid/hid-core.c is calling usbhid_init_reports() which is retrieving
> feature 8. But, I did some additional testing and I wasn't able to reproduce
> this issue on other systems. The failure occurs on a Dell XPS 13 9343, but
> the exact same touchpad and the exact same kernel (I booted both systems off
> an external HD to ensure that the kernel and OS are identical) I didn't see
> a problem. I also tried a different USB PTP touchpad which didn't have an
> issue. Also, I tried returning in mt_get_feature() instead of reading the
> report when the report id is 8. When I did that everything worked.
> 
> So as of right now, it looks like a single non production USB PTP touchpad
> fails on one particular system. But, all other tests have been successful.
> 
> Let me know if you have any other suggestions for me to test. But, it seems
> like this failure might be fairly isolated.

Thanks a lot for testing all this.

If the failure is limited to a single non-production touchpad then, I
suppose we should be fine. As long as there are no such systems out
there in the wild.

One additional thing we could check in mt_get_feature() is if the device
is connected via I2C and only in that case fetch the feature in
question.

Jiri, Benjamin, what do you think?
