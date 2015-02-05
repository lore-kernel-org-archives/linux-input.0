From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Regression in dtor/input.git/next - flush pending events on clock
 type change
Date: Thu, 5 Feb 2015 18:06:29 -0500
Message-ID: <20150205230629.GC21618@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60536 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbbBEXGh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Feb 2015 18:06:37 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <anshul.g@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi Anshul,

The commit 0c3e99437a66e4c869c60c2398449e6d98f3a988 in dtor/input.git/next
tree introduce an interesting regression in libinput. The tests fail :)

Actually, evemu-record and libinput switch the clock to monotonic when
opening an input node, and the first thing that gets queued is a
SYN_DROPPED event.

However, in the libinput test suite, events are the bare minimum, and
most of the tests contain only one event set (one EV_SYN).
When seeing the SYN_DROPPED, the clients are supposed to drain the events
until the next EV_SYN, and so they are losing the events that came long
after the ioctl call.
And in the end, the test suite does not receive any events.

Removing the evdev_queue_syn_dropped() call in the ioctl handling fixes
the test suite, and Peter suggested that maybe we should queue a
SYN_DROPPED event iff there are events in the queue.

Cheers,
Benjamin
