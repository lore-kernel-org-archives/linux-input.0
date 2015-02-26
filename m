From: Bastien Nocera <hadess@hadess.net>
Subject: Re: udev timeout for mma8450 unless the accelerometer is shaken
Date: Thu, 26 Feb 2015 15:02:54 +0100
Message-ID: <1424959374.2459.17.camel@hadess.net>
References: <CAGX7z0yi5JbTUsDEZRO1EffDBi4Co6YX=NyOZ9m2uJfyPh8o_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57602 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932777AbbBZODF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 09:03:05 -0500
In-Reply-To: <CAGX7z0yi5JbTUsDEZRO1EffDBi4Co6YX=NyOZ9m2uJfyPh8o_w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Sauer <ensonic@google.com>
Cc: linux-input@vger.kernel.org

On Thu, 2015-02-26 at 14:05 +0100, Stefan Sauer wrote:
> hi,
> 
> on my beaglebone-black I get these lines during bootup
> 
> [   71.745951] udevd[105]: worker [113]
> /devices/ocp.2/4819c000.i2c/i2c-2/2-001d/input/input2/event1 timeout;
> kill it
> [   71.771991] udevd[105]: seq 1243
> '/devices/ocp.2/4819c000.i2c/i2c-2/2-001d/input/input2/event1' killed
> [   71.799611] udevd[105]: worker [113] terminated by signal 9 (Killed)
> 
> The device is an accelerometer connected via i2c. When I shake it
> during bootup I don't get these warnings. Alternative repro:
> udevadm trigger --action=add --subsystem-match="input" --subsystem-match="misc"
> udevadm settle
> 
> The 'udevadm settle' will block until the device is moved. Is that expected?

This is likely due to the accelerometer support in udev. Which version
of udev/systemd is it? You might want to pick this patch if it isn't
already in your tree:
http://cgit.freedesktop.org/systemd/systemd/commit/src/udev/accelerometer/accelerometer.c?id=a545c6e1aa31b4d7e80c9d3609d9fc4fc9921498

Cheers

