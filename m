From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 0/3] input: Dynamic Minor Numbers
Date: Thu, 13 Sep 2012 21:19:49 +0200
Message-ID: <1347563992-27980-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39075 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2IMTSR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 15:18:17 -0400
Received: by wibhi8 with SMTP id hi8so7313145wib.1
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 12:18:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>

Hi

This patchset implements dynamic minor numbers for input devices. We definitely
need this infrastructure to avoid the current limit of 32 evdev devices. We
could just increase the number of static minors but I think a dynamic approach
is the better idea.

The first patch implements the allocation/deallocation of dynamic minor numbers
in the input-core. The second patch actually increases the maximum device number
so we can allocate dynamic minors. And the third patch converts the evdev source
to use dynamic minors when running out of static minor numbers.

I have only compile-tested this, yet. I will try to test this fully tomorrow.
But any comments are welcome.

Regards
David

David Herrmann (3):
  input: add dynamic-minor allocation helpers
  input: increase INPUT_DEVICES to 512 to allow dynamic minors
  input: evdev: use dynamic-minors if running out of static minors

 drivers/input/evdev.c |  95 ++++++++++++++++-------------
 drivers/input/input.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/input.h |   5 ++
 3 files changed, 219 insertions(+), 45 deletions(-)

-- 
1.7.12

