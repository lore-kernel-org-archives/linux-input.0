From: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [RFC] HID: hid-lg4ff g27 leds using LED subsystem
Date: Tue, 20 Mar 2012 00:48:54 +0000
Message-ID: <1332204534.9740.81.camel@ted>
References: <1549268.LAjoPqsQ59@qosmio-x300>
	    <1331760499-28737-1-git-send-email-simon@mungewell.org>
	 <de5fe43451847cc2858568686f49f2bf.squirrel@mungewell.org>
	 <alpine.LNX.2.00.1203191732570.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:52785 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990Ab2CTBMQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 21:12:16 -0400
In-Reply-To: <alpine.LNX.2.00.1203191732570.18356@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>

On Mon, 2012-03-19 at 17:33 +0100, Jiri Kosina wrote:
> On Wed, 14 Mar 2012, simon@mungewell.org wrote:
> 
> > > I'm posting this more as a 'Request for Comments' following on from
> > > Michal's patch this morning.
> > 
> > One thing I note sure about is permissions, the LEDs register as
> > --
> > Mar 14 14:57:35 ubuntu kernel: [ 6462.204185] Registered led device:
> > 0003:046D:C294.0009::RPM1
> > Mar 14 14:57:35 ubuntu kernel: [ 6462.204251] Registered led device:
> > 0003:046D:C294.0009::RPM2
> > Mar 14 14:57:35 ubuntu kernel: [ 6462.204301] Registered led device:
> > 0003:046D:C294.0009::RPM3
> > Mar 14 14:57:35 ubuntu kernel: [ 6462.204354] Registered led device:
> > 0003:046D:C294.0009::RPM4
> > Mar 14 14:57:35 ubuntu kernel: [ 6462.204402] Registered led device:
> > 0003:046D:C294.0009::RPM5
> > --
> > 
> > But I have to be root to perform
> > --
> > root@ubuntu:/sys/devices/pci0000:00/0000:00:11.0/0000:02:00.0/usb2/2-1/2-1:1.0/0003:046D:C294.0009/leds/0003:046D:C294.0009::RPM1#
> > echo 1 > brightness
> > --
> > 
> > Is it possible to register so that all/any user can control the LED status?
> 
> Looking at the code, I don't think that's possible. Adding Richard to CC, 
> he definitely might have an opinion on this.

Whilst there is kernel side API you could potentially (ab)use, its not
encouraged or easy to do with the LED class attributes. Its really a
userspace policy issue. You can change the permissions on the files in
sysfs to reflect the access you require from something like udev. 

Cheers,

Richard




