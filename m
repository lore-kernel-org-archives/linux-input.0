From: Karsten Merker <merker@debian.org>
Subject: [PATCH RFC V2 0/3] Input: goodix - add axis swapping and axis inversion support
Date: Fri,  9 Oct 2015 19:55:49 +0200
Message-ID: <1444413352-24529-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

Hello,

this is v2 of my "Input: goodix - add axis swapping and axis inversion
support" patchset.
The goodix touchscreen driver has gained device-tree support in kernel
4.1, but doesn't currently support the touchscreen-swapped-x-y,
touchscreen-inverted-x and touchscreen-inverted-y properties.

On systems which combine a portrait-mode display with a landscape-mode
touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
features is necessary to have the touchscreen and the display use the
same coordinate system.

With support for axis inversion, the "rotated_screen" flag in the
driver can also be removed, as "rotated_screen" is just a special case
of x/y axis inversion.

This patchset sits on top of the "[PATCH v8 0/9] Goodix touchscreen
enhancements" series by Irina Tirdea:
https://www.spinics.net/lists/linux-input/msg41437.html

I have successfully tested the axis swapping on an (arm-based) MSI
Primo 81 tablet, but I lack appropriate hardware to do a real-world
test of the "rotated_screen" code path, so I would appreciate very
much if somebody with appropriate hardware (WinBook TW100 or TW700)
could give it a try.

Regards,
Karsten

Changelog:

v1: * Initial version (based von v6 of Irina Tirdea's "Goodix
      touchscreen enhancements" series).
      Reviewed-by: Bastien Nocera <hadess@hadess.net>

v2: * Rebase against v8 of Irina Tirdea's "Goodix touchscreen
      enhancements" series.
    * Fix a typo in the commit message.
    * Add an update for the goodix dt bindings documentation
      (patch No. 3).


Karsten Merker (3):
  Input: goodix - add dt axis swapping and axis inversion support
  Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
  Input: goodix - update dt bindings documentation (axis
    swapping/inversion)

 .../bindings/input/touchscreen/goodix.txt          |  6 ++++
 drivers/input/touchscreen/goodix.c                 | 33 ++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.1.4
