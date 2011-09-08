From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: Driver support for TI's quadrature encoder module
Date: Thu, 8 Sep 2011 18:57:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593025743EEE8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58391 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778Ab1IHN1Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2011 09:27:25 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-input@vger.kernel.org>"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "daniel@caiaq.de" <daniel@caiaq.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "gregkh@suse.de" <gregkh@suse.de>, "hjk@hansjkoch.de" <hjk@hansjkoch.de>

Hi All,

I am developing a driver for TI's enhanced Quadrature Encoder Pulse
(eQEP) module. Details of the module at
http://www.ti.com/lit/ug/sprufu8/sprufu8.pdf

Little description about the module:-

This module is used for direct interface with a linear or rotary
incremental encoder.

Main features of the module:
a. Provides the direction of the motor (clock or anti-clock)
b. Provides position count values, which can be used to compute speed
   of a machine (motor/generator)
c. Generate a sync output from position compare sub-module
d. Can be used for High & Low speed measurements

This module has 4 inputs from external rotary/linear encoder.
a. Input A (Input from external rotary encoder, a pulse train)
b. Input B (Input from external rotary encoder, a pulse train)
c. Index Event (Input from external rotary encoder, a index event.
   This can be used as output, which can be generated after
   position compare)
d. Strobe Event (Input from external rotary encoder, a strobe event.
   This can be used as output, which can be generated after
   position compare)

The module provides pre-analyzed data based on the above four input
signals. We can use the data directly for knowing the position and
direction details.

I have few questions related to this:-

1. What subsystem this driver fit into? Input subsystem or UIO
subsystem?

Why I think it may fit into UIO subsystem?
a. Same driver is used for lot of applications like motor control,
volume control and menu navigation. This means we have to provide
lot of flexibility to the user in configuring the hardware to work
for different applications.

Why I think it may fit into Input subsystem?
a. The module is receiving the signals from external encoder. Based
on the signals it will generate some events, which we have to handle
at the user space.
b. I found some encoder drivers are already present under input
subsystem (example drivers/input/misc/rotary-encoder.c)

But, the current rotary encoder drivers are developed for much simpler 
hardware.

It looks like we need some additional interfaces to cater to the
hardware capabilities. I am thinking of sysfs interfaces which
allow user to directly configure the hardware for position control,
position compare, input source selection, capture timer period,
speed and direction of rotation.

Is this the right way to proceed? Is there anyone working on such
enhancements with whom I can collaborate?

Any inputs on the above questions greatly appreciated.

Regards,
Anilkumar
