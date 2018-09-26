From: Florian Dollinger <dollinger.florian@gmx.de>
Subject: Re: XBox One S controller, Bluetooth support (was Re: hid: microsoft:
 Add rumble support for Xbox One S controller)
Date: Thu, 27 Sep 2018 00:35:30 +0200
Message-ID: <73a5acce-37cd-1ca4-333c-d02ce48fb644@gmx.de>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
 <20180926125130.974-1-dollinger.florian@gmx.de>
 <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
 <b455a236b677c03f623ddbd5c28e602def439bc9.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b455a236b677c03f623ddbd5c28e602def439bc9.camel@hadess.net>
Content-Language: en-HK
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, andrew.smirnov@gmail.com
Cc: linux-kernel@vger.kernel.org, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> For this patch, after speaking with the Bluetooth maintainers, we would
> need to:
> - add relevant btmon outputs before and after the patch in the commit
> message
> - remove the mention of "many devices" (if you've seen other devices
> with that problem in the wild, please mention them, otherwise mention
> that it's for "XBox One S" controllers, and clones)
> - run the patch against the "Profile Tuning Suite Tool" from the
> Bluetooth SIG. This requires a Windows laptop, and a piece of hardware
> from the Bluetooth SIG, see below.
> 
> The first 2 should be pretty easy to do, just send your patch using
> "git send-email" to the linux-bluetooth list (CC:ed), with the data
> attached.
> 
> For the qualification test, I was told Szymon has a test suite that he
> could use to double-check the tests. If not, I should be able to buy
> the adapter and run that test suite locally.
> 
> Cheers

Thanks, I will give it a try tomorrow (later) :)
