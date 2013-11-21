From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/3] Fixes for multitouch / generic gamepads interaction
Date: Thu, 21 Nov 2013 13:38:30 +0100
Message-ID: <528DFEC6.3050705@euromail.se>
References: <1384983141-31019-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:44477 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab3KUM4e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 07:56:34 -0500
In-Reply-To: <1384983141-31019-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, simon@mungewell.org, case@corpsmoderne.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> I have been reported recently a problem with the Sixaxis controller
> (http://www.spinics.net/lists/linux-input/msg28098.html).
> The root of the problem comes from hid-input, which maps unknown axis to
> ABS_MISC. However, when an event code is already in use, hid-input uses the one
> after, leading to uses of ABS_MISC + N, where N is the number of unknown axis.

Yes, and clearly we should not do that. :-)

> We are encountering a problem with the multitouch protocol here because if a
> device has more than 7 unknown axis (which is the case for the PS3 Sixaxis
> controller), then the unknown axis get maps to ABS_MT_SLOT and beyond.
> 
> This infers two problems:
> - the axis currently mapped on ABS_MT_SLOT is a special case in the kernel,
> and it is not updated
> - the axis after ABS_MT_SLOT are not filtered anymore, as the kernel things
> the device is using a multitouch protocol A.

The problem is generic, and ABS_MT_SLOT just happens to be the first value that
the hid logic hits. When sevenaxis comes out, we have to do this all over again.

> The patch 0001 solves the first problem, whereas the patches 0002 and 0003
> fix the second. Bonus point: the userspace is now correctly notified that one of
> the multitouch protocols is in used, so it does not have to rely on bad designed
> heuristics.

The bad heuristics are lines 918 and onwards in hid-input.c. I am sure we can
come up with a way to allocate those axes in a much less fragile way.

Thanks,
Henrik

