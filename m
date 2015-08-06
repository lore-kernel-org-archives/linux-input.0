From: Hans de Goede <hdegoede@redhat.com>
Subject: Adding an interface to evdev for tablet orientation
Date: Thu, 6 Aug 2015 15:19:25 +0200
Message-ID: <55C35EDD.8010806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbbHFNT2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2015 09:19:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>

Hi All,

Many accelerometers used in tablets not only offer acceleration
data along 3 axis, but also have a notion of the orientation of
the tablet (right side up, upside down, rotated 90 degrees left/right),
currently there is no way to export this info via evdev.

I think we need to add an axis/switch/? to the linux/uapi/input.h
definitions to support this, as it is useful info to have, and the hw
is likely a more reliable source of this info then deducting it from
the accelerometer readings as is done in e.g. :

https://github.com/hadess/iio-sensor-proxy/blob/master/src/orientation.c#L60

3 questions:

1) Do people agree that it is a good idea to export the hardware's
notation of the orientation through evdev ?

2) What sort of evdev events should orientation changes send, events
on a new axis, or switch events, or ... ?

3) The accelerometer hardware I've been looking at sofar typically
generates a hw interrupt for orientation changes, where as reading
the actual acceleration axis typically is a contineous process
requiring polling. The current iio-sensor-proxy code (which also
handles evdev accelerometers) leaves the evdev node closed and
only opens it on a change kevent, which means that we need to
generate change kevents on orientation changes. Another approach
would be to have 2 separate evdev nodes, one for the orientation
function, and on opening that we enable the irq), and one for
reading accel values and on opening this one we start polling.

Regards,

Hans
