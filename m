From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 0/2] input: add generic filter for input events
Date: Tue,  4 Nov 2008 12:31:26 +1030
Message-ID: <1225764088-10761-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:41905 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbYKDCCU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 21:02:20 -0500
Received: from localhost ([127.0.0.1]:47480 helo=localhost.localdomain)
	by ipx10616.ipxserver.de with esmtp (Exim 4.63)
	(envelope-from <peter.hutterer@who-t.net>)
	id 1KxBFO-0007eb-MS
	for linux-input@vger.kernel.org; Tue, 04 Nov 2008 03:02:23 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


The mac_hid module provides a virtual device to emulate right and/or middle
mouse button clicks on certain key presses. This emulation however only hooks
into keyboard.c, but not into evdev.c.

Consumers that listen to all evdev devices (such as the X server) thus receive
both the emulated mouse button event and the original key event. They do not
know that these events are associated.

These patches provide input handlers with an additional "filter" callback.
This filter function is invoked before the event is passed to the handlers and
can opt to discard the event. The mac_hid module registers such a filter
function and re-routes the event as mouse click through the virtual device.

This is a first stab in the dark at the attempt to fix this issue. Comments
are much appreciated.

Cheers,
  Peter
