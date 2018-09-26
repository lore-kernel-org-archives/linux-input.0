From: <dollinger.florian@gmx.de>
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
Date: Wed, 26 Sep 2018 17:23:09 +0200
Message-ID: <003601d455ac$d5512db0$7ff38910$@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de
Sender: linux-kernel-owner@vger.kernel.org
To: 'Bastien Nocera' <hadess@hadess.net>, andrew.smirnov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input-owner@kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hey Bastien,

> Probably because he didn't know about it, and how would he?

Hum, it's the first hit when you search for something like 'xbox one s driver linux' since half an year or longer 😊

> I spent quite a bit of time trying to get the XBox One S controller working over Bluetooth, without success, and I see that you have a patch for that which you didn't send upstream either:
https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

Jap, I just never pushed it because I never pushed anything to the linux kernel and I don't really know how the whole process works^^ Furthermore I wanted to fix possible before, but it looks like the driver is stable enough to push it now.

> I can imagine that a large portion of the driver can be integrated in the existing XBox pad driver, with each feature added in individual patches.

Would be great! But ist the xpad driver really the right place?

First of all, the BT interface is using HID, USB does not.
Furthermore, the driver is currently around 1,3k lines long - for a single device and only BT... (okay yes, there are a lot of comments in it).
But anyway, is it really a good idea to put everything into hid-microsoft?
Moreover, there is another interface which I am trying to support at the moment - the one which is used by the XBOX (WiFi).

I think in the end the whole hid-microsoft thingy will get blown-up a bit - right?
Or, everything is scattered over many places (hid-microsoft, xpad, another driver fort he wifi-interface).

Isn't it possible to use "one driver per device" in the kernel too, like I did?

> If I get the time, there are good chances I will send a patch to integrate the battery reporting in the existing driver at least, and then add support for missing buttons if there's a problem there (I see that mentioned in the README).

Jap, the wrong mapping is possibly the biggest problem of all. Battery support and FF is more "nice to have" but not really crucial. 

> "Trigger Force Feedback" is likely something that would need to be integrated at a lower level, this is probably not something we'd want to have replicated in each driver.

True.


Best regards, Flo
