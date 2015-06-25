From: Samuel Thibault <sthibault@debian.org>
Subject: Re: Bug#514464: caps lock led does not show up
Date: Thu, 25 Jun 2015 17:41:12 +0200
Message-ID: <20150625154112.GF3093@type.bordeaux.inria.fr>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
 <20150609141723.GE3045@type>
 <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
 <20150611080809.GD3184@type.bordeaux.inria.fr>
 <20150611142803.GA3056@type.access.network>
 <20150611153755.GA2247@type>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16247
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379AbbFYPlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 11:41:14 -0400
Content-Disposition: inline
In-Reply-To: <20150611153755.GA2247@type>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anton Zinoviev <anton@lml.bas.bg>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 514464@bugs.debian.org

Hello,

The patch got into Linus' tree, so it will most probably get into Linux
4.2.  We should thus probably work on the console-setup support for it
already, it won't hurt.

So the idea is that console-setup can configure which modifier lights
which LED, by first emitting udev rules such as this:

ACTION=="add", SUBSYSTEM=="leds", ENV{DEVPATH}=="*/input*::capslock", ATTR{trigger}="kbd-ctrlllock"

for the subsequently-plugged keyboards, and then do the echo by hand for
existing keyboards, similarly to this:

for i in /sys/class/leds/input*::capslock/trigger 
do
	echo kbd-ctrlllock > $i
done

The physical LED names (capslock in the example above) are:

numlock (defaults to kbd-numlock)
capslock (defaults to kbd-capslock)
scrolllock (defaults to kbd-scrolllock)
compose
kana (defaults to kbd-kanalock)
sleep
suspend
mute
misc
mail
charging

and the trigger names (kbd-ctrlllock in the example above) are:

(the 4 legacy LED states)
kbd-scrollock
kbd-numlock
kbd-capslock
kbd-kanalock

(the 8 layout modifiers)
kbd-shiftlock
kbd-altgrlock
kbd-ctrllock
kbd-altlock
kbd-shiftllock
kbd-shiftrlock
kbd-ctrlllock
kbd-ctrlrlock

Anton, do you have all the informations you need to match that with the
xkb data?

Samuel
