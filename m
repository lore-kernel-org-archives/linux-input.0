From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] Generic suspend/resume for input devices
Date: Thu, 10 Sep 2009 22:48:00 -0700
Message-ID: <20090911054210.27150.93405.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:39320 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZIKFsA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:48:00 -0400
Received: by pzk14 with SMTP id 14so662552pzk.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:48:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rjw@sisk.pl

Hi,

The following patches implement generic suspend and resume for
input devices. As part of the suspend sequence input core will
turn off leds and bell (if they were active) and upon resume the
state of the leds, sound effects and repeat rate/delay will be
restored without requiring and special handling in individual
drivers.

The change required some additional locking in i8042/libps2 and
while I don't particularly like it the positive thing is that
the change should allow switching serio to the asynchronous
suspend and resume, i8042 should be able to handle it now.

--
Dmitry

