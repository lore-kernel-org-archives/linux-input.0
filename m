From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v3 0/5] input: synaptics - report correct width and pressure values
Date: Sun, 22 Mar 2015 15:43:51 +0100
Message-ID: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

I updated the series fixing the error reported by Shunsuke Shimizu that
I made when I rebased v1. I've also included a change to make input
devices correctly report their capabilities and included a change to
make MT devices report widths as ABS_TOOL_WIDTH.

Gabriele Mazzotta (5):
  input: synaptics - fix width values calculation on image sensors
  input: synaptics - change default width value of cr48 sensors
  input: synaptics - setup devices depending on their capabilities
  input: synaptics - make image sensors and cr48 sensors report widths
  input: MT - add ABS_TOOL_WIDTH to the legacy pointer emulation

 drivers/input/input-mt.c        | 12 +++++++--
 drivers/input/mouse/synaptics.c | 55 +++++++++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.1.4
