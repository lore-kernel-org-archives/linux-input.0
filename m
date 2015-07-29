From: cpaul@redhat.com
Subject: [PATCH 0/1] Alps button reporting bugfix
Date: Wed, 29 Jul 2015 16:45:25 -0400
Message-ID: <1438202726-5100-1-git-send-email-cpaul@redhat.com>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG2Upi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 16:45:38 -0400
In-Reply-To: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>

From: Stephen Chandler Paul <cpaul@redhat.com>

Hi! This was a perfect test case for ps2emu. I managed to reproduce the issue
you were having perfectly, and I'm pretty sure I've debugged the issue and
written a patch to fix it. Would you mind applying the next patch I'll be
sending to a clean build of the latest kernel, and telling me if it fixes your
issue or not?

Cheers,
	Stephen Chandler Paul

Stephen Chandler Paul (1):
  Input - alps: Fix button reporting on the V2 Alps protocol

 drivers/input/mouse/alps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.4.3

