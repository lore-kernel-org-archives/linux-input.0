From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: MacBook8,1 (2015) HID Hardware Support
Date: Sat, 19 Sep 2015 10:22:41 -0700
Message-ID: <20150919172241.GB7081@dtor-ws>
References: <CAOviyajKA-s4Y6a5OfJmtO7H2Uc4bxCZ0dwCnAzA0K=odjegMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33048 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbbISRWp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2015 13:22:45 -0400
Content-Disposition: inline
In-Reply-To: <CAOviyajKA-s4Y6a5OfJmtO7H2Uc4bxCZ0dwCnAzA0K=odjegMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, jikos@kernel.org, Jochen Radmacher <jradmacher@gmx.de>, Yang Hongyang <burnef@gmail.com>, coldnew.tw@gmail.com, George Hilios <ghilios@gmail.com>, Janez Urevc <janez@janezurevc.name>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 20, 2015 at 03:10:16AM +1000, Aleksa Sarai wrote:
> Hello,
> 
> I've been trying to get Linux installed on a MacBook8,1 (not the pro)
> and have had trouble getting keyboard input to work, despite
> a4a2c54560f2c57b88ba0283f141b44f594c2337 ("HID: apple: Add support for
> the 2015 Macbook Pro") and d58069265c9d15c04c9e3832cd1d9dffe9d4d5f6
> ("Input: bcm5974 - add support for the 2015 Macbook Pro"). Even
> compiling it into the kernel itself or forcing hid-apple module
> loading in both initramfs and init did not help. One would assume (I
> did) it's because the hardware is different to the MacBookPro12,1.
> However, looking at the product and vendor ID:
> 
> Apple Internal Keyboard / Trackpad:
> 
> Product ID: 0x0272
> Vendor ID: 0x05ac (Apple Inc.)
> Version: 6.22
> Manufacturer: Apple Inc.
> Location ID: 0x01000000
> 
> It seems that this hardware was added to hid-apple as
> USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI in both of the above linked
> commits, so what gives? Is there some peculiarity with this hardware?
> Am I not reading the above patches correctly? I'd be happy to test any
> patches you'd like to throw at me.

IIRC these models use SPI instead of USB for the keyboard/trackpad, so
the commits you are referencing will not work for you.

I do not know if anyone is looking into getting SPI variants to work.

Thanks.

-- 
Dmitry
