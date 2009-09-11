From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] Input filters
Date: Thu, 10 Sep 2009 22:28:18 -0700
Message-ID: <20090911052720.26911.67943.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:48865 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZIKF2S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:28:18 -0400
Received: by pzk14 with SMTP id 14so651216pzk.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:28:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mjg@redhat.com

Hi,

The following 2 patches implement a limited version of input filters
which allow suppressing certain events from reaching regular input
handlers/user space.

The name inspired by the recent patch from Matthew, although
implementation and intended usage quite different - Matthew needs to
filter non-input (battery, wlan, AC adapter state) from the raw data
stream emitted by i8042 whereas input filters are supposed to filter
(and maybe replace) _input_ events, most likely without regard as to
which device emitted them.

The first (and quite possible only) user of the filter facility is
Mac mouse button emulation which user to be hacked into the keyboard
driver. The setup worked until keyboard was the sole source of key
events but now that X is switching to evdev (which is completely
ignorant of mac emulation) user space started getting the original
key presses along with the emulated buttons. Input filters solve the
issue while encapsulating everything in drivers/macintosh and
removing dependencies between mac_hid, keyboard and evdev.

-- 
Dmitry
