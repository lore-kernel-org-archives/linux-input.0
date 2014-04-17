From: simon@mungewell.org
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Thu, 17 Apr 2014 12:35:48 -0400
Message-ID: <796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
    <CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:47622 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaDQQfu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 12:35:50 -0400
In-Reply-To: <CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>


> I don't know the lg driver very well, but it looks like it's expecting
> a single report ID (0), but the device is showing two report IDs: 1
> and 2. So, from the perspective of the driver, this is correct: it
> wouldn't know how to deal with things since it is only expecting
> Report ID 0. It seems like the driver needs to be updated for this
> different device.

Hi,
The 'hid-lgff.c' driver supports lots of devices (see end of 'hid-lg.c'),
and presumably these devices offer up a wide/varied range of HID
descriptors.

Does the recently introduced(/changed) check need to have prior knowledge
of which 'Report ID's are actually used? If so, it possible that the
change has broken a number of devices...

I am trying to get the end user to test with an older kernel to see
whether his device was always 'broken'.

Thanks.
Simon

