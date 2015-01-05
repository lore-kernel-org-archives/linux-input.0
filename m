From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 0/4] input: synaptics - report correct width and pressure values
Date: Mon,  5 Jan 2015 23:28:31 +0100
Message-ID: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

Make image sensors and cr48 sensors report widths and fix the
calculation of width and pressure values in some cases.

Changes since v1:
 - Rebased on 35393dcb2ed3
 - Get widths from AGM packets too
 - Include support for cr48 sensors
 - Fix pressure values on image sensors

Gabriele Mazzotta (4):
  input: synaptics - fix pressure values calculation on image sensors
  input: synaptics - fix width values calculation on image sensors
  input: synaptics - change default width value of cr48 sensors
  input: synaptics - make semi-mt touchpads report widths

 drivers/input/mouse/synaptics.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

-- 
2.1.4
