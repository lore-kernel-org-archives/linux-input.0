From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 0/2] sparse-keymap: Emit events useful for key debugging
Date: Wed, 23 Mar 2011 16:13:41 -0500
Message-ID: <1300914823-9440-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

A number of ACPI/WMI drivers use sparse-keymap for hotkeys. Some of the
most common hotkey problems are new keys with perviously unused scan
codes and keys that reuse scan codes for different functions than in
previous models. Diagnosis of these key problems can be done easily
from userspace as long as the drivers emit MSC_SCAN events for all keys
and KEY_UNKNOWN key events for unknown scan codes. sparse-keymap does
neither.

The following patches modify sparse-keymap to emit these events,
facilitating easier debugging of malfunctioning keys from userspace.

Thanks,
Seth


Seth Forshee (2):
  Input: sparse-keymap - report scancodes with key events
  Input: sparse-keymap - report KEY_UNKNOWN for unknown scan codes

 drivers/input/sparse-keymap.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
