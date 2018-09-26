From: Bastien Nocera <hadess@hadess.net>
Subject: XBox One S controller, Bluetooth support (was Re: hid: microsoft:
 Add rumble support for Xbox One S controller)
Date: Wed, 26 Sep 2018 18:09:33 +0200
Message-ID: <932c109c28bbba7b833ff82cc68ee0ccc9a30374.camel@hadess.net>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
         <20180926125130.974-1-dollinger.florian@gmx.de>
         <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dollinger Florian <dollinger.florian@gmx.de>, andrew.smirnov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2018-09-26 at 15:45 +0200, Bastien Nocera wrote:
> Hey Florian,
> 
> On Wed, 2018-09-26 at 14:51 +0200, Dollinger Florian wrote:
> > From: Florian Dollinger <dollinger.florian@gmx.de>
> > 
> > Hi there! Why do you re-engineer the wheel? :) There is already a
> > fully functional and tested driver out there (
> > https://github.com/atar-axis/xpadneo). Would be much easier to help
> > me (the owner of xpadneo) to push it into the kernel.
> 
> Probably because he didn't know about it, and how would he? I also
> didn't know about it, because it didn't exist last I worked on those
> joypads.
> 
> I spent quite a bit of time trying to get the XBox One S controller
> working over Bluetooth, without success, and I see that you have a
> patch for that which you didn't send upstream either:
> https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

For this patch, after speaking with the Bluetooth maintainers, we would
need to:
- add relevant btmon outputs before and after the patch in the commit
message
- remove the mention of "many devices" (if you've seen other devices
with that problem in the wild, please mention them, otherwise mention
that it's for "XBox One S" controllers, and clones)
- run the patch against the "Profile Tuning Suite Tool" from the
Bluetooth SIG. This requires a Windows laptop, and a piece of hardware
from the Bluetooth SIG, see below.

The first 2 should be pretty easy to do, just send your patch using
"git send-email" to the linux-bluetooth list (CC:ed), with the data
attached.

For the qualification test, I was told Szymon has a test suite that he
could use to double-check the tests. If not, I should be able to buy
the adapter and run that test suite locally.

Cheers
