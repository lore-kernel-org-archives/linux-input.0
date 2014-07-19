From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH RESEND 0/5] Evdev Extensions
Date: Sat, 19 Jul 2014 15:10:40 +0200
Message-ID: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:53259 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbaGSNK6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2014 09:10:58 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so5591127wes.17
        for <linux-input@vger.kernel.org>; Sat, 19 Jul 2014 06:10:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@google.com>, David Herrmann <dh.herrmann@gmail.com>

Hi Dmitry

I posted all these ~2 months ago, but haven't seen any comments from you. Seeing
that you switched jobs (congratulations, btw!), I guess you were quite busy the
last few weeks. Hence, here's a resend of all the evdev changes squashed into a
single series. They're also available in my fdo repo [1] in case you wanna fetch
them directly.

No big changes except for a single "udev->state == UIST_CREATED" fix spotted by
Peter.

The last patch is still RFC, so please omit it in case you apply the patches!

All patches but the last are tested via libevdev and run fine here since several
months.

Thanks
David

[1] fdo repo: http://cgit.freedesktop.org/~dvdhrm/linux/log/?h=input-next

David Herrmann (5):
  Input: evdev - add event-mask API
  Input: uinput - uinput_validate_absbits() cleanup
  Input: uinput - add UI_GET_VERSION ioctl
  Input: uinput - add new UINPUT_DEV_SETUP ioctl
  Input: evdev - add new EVIOCGABSRANGE ioctl

 drivers/input/evdev.c       | 336 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/input/misc/uinput.c | 115 ++++++++++++---
 include/uapi/linux/input.h  | 100 ++++++++++++-
 include/uapi/linux/uinput.h |  64 ++++++++-
 4 files changed, 583 insertions(+), 32 deletions(-)

-- 
2.0.2

