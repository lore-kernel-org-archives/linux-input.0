From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH 0/3] fix y2038 problem in input_event
Date: Mon,  2 Nov 2015 21:35:36 +0800
Message-ID: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36434 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbKBNgb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 08:36:31 -0500
Received: by pacfv9 with SMTP id fv9so155739604pac.3
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 05:36:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: y2038@lists.linaro.org, arnd@arndb.de, dmitry.torokhov@gmail.com, WEN Pingbo <pingbo.wen@linaro.org>

Before this, I have discussed this problem with Arnd. And Arnd have
an idea that by converting timeval to long / long in input_event, so that
input_event structure size will be unchanged, and timeval structure will
removed entirely. But we also need to avoid using CLOCK_REALTIME in
userland, to keep the new input_event structure y2038 safe.

The input_event will only support monotonic time in Arnd's idea. And
we still need to add wall time support for old 32-bit binary. 

Those patches try to keep original input capacity, and resolve y2038
problem in input_event radically.

struct input_event is only used between kernel and userspace
communication (except uinput). So that we can replace input_event
with input_event64 in kernel entirely, and add a conversion in
input_event_from/to_user() to keep compatible with old 32-bits binary.

userland can switch to input_event64, which is y2038 safe, via ioctl.

WEN Pingbo (3):
  evdev: convert input_event to input_event64
  evdev: add new ioctl EVIOCSEVENT / EVIOCGEVENT
  uinput: convert input_event to input_event64

 drivers/input/evdev.c        | 38 ++++++++++++-------
 drivers/input/input-compat.c | 88 +++++++++++++++++++++++++++++++++++++-------
 drivers/input/input-compat.h |  9 +++--
 drivers/input/misc/uinput.c  | 17 ++++++---
 include/linux/uinput.h       |  2 +-
 include/uapi/linux/input.h   | 18 +++++++++
 6 files changed, 134 insertions(+), 38 deletions(-)

-- 
1.9.1

