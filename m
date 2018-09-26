From: Bastien Nocera <hadess@hadess.net>
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
Date: Wed, 26 Sep 2018 15:45:02 +0200
Message-ID: <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
         <20180926125130.974-1-dollinger.florian@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926125130.974-1-dollinger.florian@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dollinger Florian <dollinger.florian@gmx.de>, andrew.smirnov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input-owner@kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hey Florian,

On Wed, 2018-09-26 at 14:51 +0200, Dollinger Florian wrote:
> From: Florian Dollinger <dollinger.florian@gmx.de>
> 
> Hi there! Why do you re-engineer the wheel? :) There is already a
> fully functional and tested driver out there (
> https://github.com/atar-axis/xpadneo). Would be much easier to help
> me (the owner of xpadneo) to push it into the kernel.

Probably because he didn't know about it, and how would he? I also
didn't know about it, because it didn't exist last I worked on those
joypads.

I spent quite a bit of time trying to get the XBox One S controller
working over Bluetooth, without success, and I see that you have a
patch for that which you didn't send upstream either:
https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

I can imagine that a large portion of the driver can be integrated in
the existing XBox pad driver, with each feature added in individual
patches.

If I get the time, there are good chances I will send a patch to
integrate the battery reporting in the existing driver at least, and
then add support for missing buttons if there's a problem there (I see
that mentioned in the README).

"Trigger Force Feedback" is likely something that would need to be
integrated at a lower level, this is probably not something we'd want
to have replicated in each driver.

Cheers
