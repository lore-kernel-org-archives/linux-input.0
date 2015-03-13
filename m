From: Timo Teras <timo.teras@iki.fi>
Subject: hidraw with exclusive access ?
Date: Fri, 13 Mar 2015 08:37:58 +0200
Message-ID: <20150313083758.076c8dfb@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:35450 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbCMGin (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Mar 2015 02:38:43 -0400
Received: by lams18 with SMTP id s18so20677982lam.2
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2015 23:38:42 -0700 (PDT)
Received: from vostro ([2001:1bc8:101:f402:21a:9fff:fe0c:4022])
        by mx.google.com with ESMTPSA id i9sm205664lbs.26.2015.03.12.23.38.41
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2015 23:38:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm trying to write userland driver for an input controller -
basically a macrokeyboard: some keys act like regular keys, and some
are not really described in the descriptor so it needs custom parser.
It has also extra commands to set/blink LEDs, etc.

I'd need exclusive access to it. Mainly because some of the keys emit
normal looking presses and I would not like them to be fed into the
input system when my application is running. As side effect I get also
in dmesg errors like "input input16: event field not found" due to this.

Now this is of course doable with libusb, not using kernel hid
subsystem, and reimplementing the relevant hid bits (or using some of
the existing hid libraries doing this). But this sounds a bit overkill
and hidraw seems to be exactly for this kind of use case.

The only problem is that I was not able to find a 'grab device' type of
functionality in hidraw. Basically equivalent of EVIOCGRAB in input
subsystem. Something that would make sure the reports come only to
hidraw device.

Would it make sense to implement something like this for hidraw?

As an alternative I think we could have hid-rawonly driver, that would
by default bind to nothing. And when bound, would connect to the hid
device with HID_CONNECT_HIDRAW flag only. I could then in userland
rebind the device from hid-generic to hid-rawonly.

Or finally, to implement a full kernel side driver it. But I'd
rather not go there. Especially since the device has multiple leds, and
the input system allows only limited leds. (The leds could be exported
as led devices, but then I'd need more userland logic to figure out
which led devices map to which input device.)

Thoughts?

Thanks,
Timo
