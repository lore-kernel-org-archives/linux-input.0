From: Alex Hudson <home@alexhudson.com>
Subject: Driver problems: t213 on i8042 port
Date: Wed, 08 Dec 2010 10:33:08 +0000
Message-ID: <1291804388.3052.11.camel@lapland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vm2.hosting.betterhosted.com ([78.46.205.147]:49500 "EHLO
	mx1.betterhosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0LHLDd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 06:03:33 -0500
Received: from services1.betterhosted.com (unknown [192.168.54.3])
	by mx1.betterhosted.com (Postfix) with ESMTP id 232449F908
	for <linux-input@vger.kernel.org>; Wed,  8 Dec 2010 09:34:47 +0000 (GMT)
Received: from [192.168.178.101] (cpc2-croy13-0-0-cust346.croy.cable.virginmedia.com [77.103.217.91])
	by services1.betterhosted.com (Postfix) with ESMTPSA id C93CC29C92
	for <linux-input@vger.kernel.org>; Wed,  8 Dec 2010 10:34:46 +0000 (GMT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>

Hi all,

I'm having some trouble with the serio support for a touchit213 device,
and I'm hoping by describing what's going on someone can offer some
clues.

The PC in question is a tablet PC with the touchscreen apparently
connected to the fourth serial/ps2 port on the i8042 internally, rather
than ttyS0 or something.

The manufacturer provides an xf86 driver which is extremely ropey, and
requires raw access the port. This works:

	echo -n "serio_raw" > /sys/bus/serio/devices/serio4/drvctl

.. and /dev/serio_raw0 is created.

Now, there is a serio driver for the touchit213 series, but the obvious:

	echo -n "touchit213" > /sys/bus/serio/devices/serio4/drvctl

.. doesn't work. I don't see anything in the logs; whereas if I use
inputattach to connect the driver to ttyS0 (which doesn't have the
device, obviously) I can see that the driver is enabled
in /var/log/messages and a touch /dev/input/event device is created.

I've looked through the source for the touchit213 driver, and it's nice
simple code - and I'm assuming that it's failing somewhere in the
connect function. However, I'm struggling to get much further than this.

I guess the first question is, should this work? Attaching touchit213 to
a 'real' serial port appears to work, so I'm making the guess that this
is something to do with it being a port on the i8042. However, I don't
really know much serio and haven't been able to find any good
documentation about it - it could be I'm just missing an appropriate
incantation?

Second question is, if it's supposed to work - does anyone have some
good ideas for debugging this? I think otherwise I'm going to be
sprinkling kprintfs() in the driver and seeing what happens - are there
any better ways than this?

Thanks for any help you can offer,

Alex.


--
This message was scanned by Better Hosted and is believed to be clean.
http://www.betterhosted.com

