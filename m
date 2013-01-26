From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Sat, 26 Jan 2013 19:51:00 +0100
Message-ID: <87ip6jdbhn.fsf@dell.be.48ers.dk>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
	<092b691c8e994d31cb235fd7c45afee4@localhost>
	<87zjzwqhxi.fsf@dell.be.48ers.dk>
	<CAJiQ=7DmMAuV8GPvxyUMJbTG8TBPBG8PaaZ5-kED6gFf_5k21Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:46712 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3AZSvG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jan 2013 13:51:06 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so716206eek.37
        for <linux-input@vger.kernel.org>; Sat, 26 Jan 2013 10:51:04 -0800 (PST)
In-Reply-To: <CAJiQ=7DmMAuV8GPvxyUMJbTG8TBPBG8PaaZ5-kED6gFf_5k21Q@mail.gmail.com>
	(Kevin Cernekee's message of "Sat, 26 Jan 2013 10:45:59 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: dmitry.torokhov@gmail.com, seth.forshee@canonical.com, linux-input@vger.kernel.org

>>>>> "Kevin" == Kevin Cernekee <cernekee@gmail.com> writes:

Hi,

 Kevin> It should show one input device for the trackstick, and one input
 Kevin> device for the touchpad:

 Kevin> [397682.041027] input: DualPoint Stick as
 Kevin> /devices/platform/i8042/serio1/input/input17
 Kevin> [397682.054959] input: AlpsPS/2 ALPS DualPoint TouchPad as
 Kevin> /devices/platform/i8042/serio1/input/input18

Hmm, odd - I rebooted and now it seems ok:

dmesg|egrep -i 'stick|alps'
input: DualPoint Stick as /devices/platform/i8042/serio1/input/input13
input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input14

What is this trackstick thing?


 Kevin> I'm not sure what would cause it to register two identical touchpads;
 Kevin> I don't see that on either E6230 or E6430.  Did you build psmouse.ko
 Kevin> from my DKMS sources, or apply the patches on top of some other
 Kevin> baseline?

I applied the series on top of 3.7.4.


 >> But the input events seem very noisy (E.G. the cursor jumps up and down
 >> if I keep my finger pressed on the touchpad). Especially the Y
 >> coordinate seems unstable:

 Kevin> OK - I do see this on E6230 but not E6430.  Normal usage is fine but
 Kevin> the "pressed finger" test fails on E6230.  I'll do some digging and
 Kevin> try to figure out why.

Great, thanks! Let me know if you want me to test something.

-- 
Bye, Peter Korsgaard
