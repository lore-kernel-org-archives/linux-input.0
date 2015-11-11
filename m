From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH v2 0/2] hid: sony: Clear and restore controller state on suspend and resume
Date: Wed, 11 Nov 2015 09:49:36 -0500
Message-ID: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35359 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbKKOtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2015 09:49:47 -0500
Received: by ykba77 with SMTP id a77so51446828ykb.2
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2015 06:49:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, ao2@ao2.it, Frank Praznik <frank.praznik@gmail.com>

On systems with standby power for charging devices the LEDs and rumble on the
controller can continue to function even when the system is in standby since
the state is not cleared when the system goes to sleep.

The state on wakeup can also differ from the state when the system entered
standby as the LEDs can be cleared when the device is reset on wakeup.

The first patch refactors the output report functions to allow sending an
output report without going through the work queue.  This is necessary when
clearing the state of the controller before the system is goes into standby
since the work might not be executed before the system goes to sleep.

The second patch implements the suspend and resume callbacks which serializes
and clears the LEDs on suspend and restores them on resume.

Force-feedback is cleared on suspend but the state is not restored on resume
since it can potentially result in hardware damage if the device is unattended
when the system wakes.  A new event will be required to resume force-feedback.

