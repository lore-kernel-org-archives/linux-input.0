From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v3 0/5] hid-multitouch: a first step towards multitouch unification
Date: Fri,  7 Jan 2011 19:42:37 +0100
Message-ID: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>
List-Id: linux-input@vger.kernel.org

Hi,

here is the v3.

all changes are coming from the mails with Henrik:

- restricted to new drivers only
- delete mt_buffer struct
- replace/adapt prev_valid in favor of seen_in_this_frame
- integrated fuzz
- introduce MT_QUIRKS
- other small fixes

Cheers,
Benjamin
