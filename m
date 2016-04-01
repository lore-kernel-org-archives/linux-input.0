From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v4 0/4] input: synaptics - report correct width and pressure values
Date: Fri,  1 Apr 2016 15:06:48 +0200
Message-ID: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

The problem of the previous set, v3, was the use of ABS_MT_TOUCH_MAJOR
to report finger widths without them being expressed in surface units.
In this set only the width of the first touch is reported, this time
using ABS_TOOL_WIDTH.

Gabriele Mazzotta (4):
  input: synaptics - fix pressure values calculation on image sensors
  input: synaptics - fix width values calculation on image sensors
  input: synaptics - change default width value of cr48 sensors
  input: synaptics - make image sensors and cr48 sensors report widths

 drivers/input/mouse/synaptics.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.8.0.rc3
