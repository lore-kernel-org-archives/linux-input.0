From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] HID: huion: add libinput support
Date: Tue, 17 Feb 2015 17:54:11 -0500
Message-ID: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46806 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbbBQWyT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 17:54:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Nikolai,

I know you are actually merging hid-huion and hid-uclogic, so we might not want
to take this in this current state. We may need to postpone it when you have
send the merge.

This series makes the Huion tablet (a H610 Pro) behave like a Wacom one from the
libinput point of view.
It will introduce a change in the default behavior for the users (which I
believe is a good change) where the pad part of the tablet will not send
random keyboard shortcuts but actual button events.

I'd be glad if you could validate the changes with the other huions you have
(or the Digimend project), because, having only one PID for all their tablets
is rather weird and difficult to support.

Last, I think we could add these tablets in the libwacom project, so that there
will be a nice GUI to configure the buttons. However, not having the PID to
discriminate between tablets is going to be a problem. Do you have any reliable
way of knowing the model from the kernel or the user space?

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: huion: enable button mode reporting
  HID: huion: split the stylus and pad in 2 nodes

 drivers/hid/hid-huion.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

-- 
2.1.0

