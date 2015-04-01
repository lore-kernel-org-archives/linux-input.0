From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH FIX for 4.0 0/2] alps: Report alps v2 Dualpoint Stick events via the right event node
Date: Wed,  1 Apr 2015 17:44:04 +0200
Message-ID: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbbDAPoI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Apr 2015 11:44:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org

Hi Dmitry & Pali,

While working on some libinput code to deal with trackpoints of different
model laptops having quite different speed / sensitivity ootb, I noticed that
with the current 4.0-rc# kernels the trackpoint events on laptops with a
PROTO_V2 alps touchpad are no longer being send by the "Dualpoint Stick"
event node, instead a new "ALPS PS/2 Mouse" node gets created and sends
the trackpoint events.

The cause of this is that the stick on these devices sends bare ps/2 packets
as data.

Although this does not really break anything (atm, it does break my libinput
work), it is still wrong, esp. also since the "Dualpoint Stick" node has
the POINTING_STICK property set, where as the "ALPS PS/2 Mouse" node which
is actually sending the stick events does not.

If still possible I would like to see this fixes added to 4.0, if not we should
queue them up for stable.

Regards,

Hans
