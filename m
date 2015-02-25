From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] HID: huion/uclogic merge and few additions
Date: Tue, 24 Feb 2015 19:05:26 -0500
Message-ID: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

Hi,

So, this is a attempt to get a common base with the out of the tree driver
for Huion and UC-Logic tablets here https://github.com/DIGImend/digimend-kernel-drivers

I am CC-ing DIGImend-devel though the patches are aimed at Jiri's tree upstream.

Nick, I changed a little bit the first patch compared to your version.
I blindly applied HID_QUIRK_MULTI_INPUT. I don't expect anything to break with
this, but I was not able to reinject all the devices you have through uhid to
check.
I'd like you to at least sign both first and second if you are happy with the
code.

The remaining bit for the tablet I have is the switch to the button reporting
mode, but I think that will need a little bit more testing from the users of
the DIDImend project.

Cheers,
Benjamin

Benjamin Tissoires (4):
  HID: uclogic: Set quirks from inside the driver
  HID: uclogic: merge hid-huion driver in hid-uclogic
  HID: uclogic: present only the working interfaces on the Huion tablets
  HID: uclogic: name the input nodes based on their tool

 drivers/hid/Kconfig             |   8 +-
 drivers/hid/Makefile            |   1 -
 drivers/hid/hid-huion.c         | 290 --------------------------------------
 drivers/hid/hid-uclogic.c       | 301 +++++++++++++++++++++++++++++++++++++++-
 drivers/hid/usbhid/hid-quirks.c |   4 -
 5 files changed, 301 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/hid/hid-huion.c

-- 
2.1.0
