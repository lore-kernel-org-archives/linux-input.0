From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC 0/6] Input: mt: Document in-kernel tracking and solve jumping cursors issues
Date: Mon, 19 Jan 2015 15:53:49 -0500
Message-ID: <1421700835-22157-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Well, I am posting this as an RFC for 2 reasons:
- I could not end up in a complete documentation on how the in-kernel tracking
  was working (patches 1/6 to 5/6)
- I introduce a new input-mt API symbol, so I am pretty sure there will be some
  changes requested. (path 6/6)

Anyway, this is the second part of the jumping cursors issue reported few months
ago:
https://bugs.freedesktop.org/show_bug.cgi?id=76722

Henrik if you have any pointers on how mathematically the reduced cost matrix
and the adjust dual function works, I think that should be enough to document
the code. I gave up trying to understand by hand (or with breakpoints), and all
I know is that it works.

Thanks for your feedback,

Cheers,
Benjamin

Benjamin Tissoires (6):
  Input: mt: make input_mt_assign_slots() a little bit more readable
  Input: mt: Document input_mt_set_slots()
  Input: mt: document input_mt_set_matrix()
  Input: mt: document find_reduced_matrix()
  Input: mt: document adjust_dual()
  Input: mt: introduce dmax in in-kernel tracking

 drivers/input/input-mt.c        | 184 +++++++++++++++++++++++++++++++++-------
 drivers/input/mouse/synaptics.c |   3 +-
 include/linux/input/mt.h        |   4 +
 3 files changed, 161 insertions(+), 30 deletions(-)

-- 
2.1.0
