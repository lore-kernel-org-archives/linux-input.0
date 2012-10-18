From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [BUG v3.6.2, 3.7-rc1] Unable to rmmod any hid special driver
Date: Thu, 18 Oct 2012 14:20:49 +0200
Message-ID: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39606 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2JRMUu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Oct 2012 08:20:50 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so6262723iag.19
        for <linux-input@vger.kernel.org>; Thu, 18 Oct 2012 05:20:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ratan Nalumasu <ratan@google.com>, linux-input <linux-input@vger.kernel.org>

Hi Guys,

Commit 4fe9f8e203fdad1524c04beb390f3c6099781ed9 upstream
Commit 57a38d925e665fcd729cd9ad4a75c84e11bd95c9 linux-stable

This commit "HID: hidraw: don't deallocate memory when it is in use"
prevents users to rmmod then insmod  any hid special driver without
either physically unplugging the device or without rmmod-ing the hid
bus itself.

When the user does a rmmod, hidinput_disconnect is called before
hidraw_disconnect, thus, the hidraw device is still there, but the
input one not. It leads to the fact that the device is not working
anymore even if you call modprobe.

Any idea to solve that?

Cheers,
Benjamin
