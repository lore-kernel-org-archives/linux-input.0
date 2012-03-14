From: simon@mungewell.org
Subject: Re: [RFC] HID: hid-lg4ff g27 leds using LED subsystem
Date: Wed, 14 Mar 2012 18:03:35 -0400
Message-ID: <de5fe43451847cc2858568686f49f2bf.squirrel@mungewell.org>
References: <1549268.LAjoPqsQ59@qosmio-x300>
    <1331760499-28737-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:42984 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031081Ab2CNWDh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 18:03:37 -0400
In-Reply-To: <1331760499-28737-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>

> I'm posting this more as a 'Request for Comments' following on from
> Michal's patch this morning.

One thing I note sure about is permissions, the LEDs register as
--
Mar 14 14:57:35 ubuntu kernel: [ 6462.204185] Registered led device:
0003:046D:C294.0009::RPM1
Mar 14 14:57:35 ubuntu kernel: [ 6462.204251] Registered led device:
0003:046D:C294.0009::RPM2
Mar 14 14:57:35 ubuntu kernel: [ 6462.204301] Registered led device:
0003:046D:C294.0009::RPM3
Mar 14 14:57:35 ubuntu kernel: [ 6462.204354] Registered led device:
0003:046D:C294.0009::RPM4
Mar 14 14:57:35 ubuntu kernel: [ 6462.204402] Registered led device:
0003:046D:C294.0009::RPM5
--

But I have to be root to perform
--
root@ubuntu:/sys/devices/pci0000:00/0000:00:11.0/0000:02:00.0/usb2/2-1/2-1:1.0/0003:046D:C294.0009/leds/0003:046D:C294.0009::RPM1#
echo 1 > brightness
--

Is it possible to register so that all/any user can control the LED status?
Simon

