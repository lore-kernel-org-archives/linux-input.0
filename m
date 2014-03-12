From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v4 0/3] input: appletouch: fixes for jagged/uneven cursor
 movement
Date: Wed, 12 Mar 2014 18:13:07 -0500
Message-ID: <5320EA03.2040206@gmail.com>
References: <52D9DE7A.7040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:54782 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaCLXNM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 19:13:12 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so200016ier.13
        for <linux-input@vger.kernel.org>; Wed, 12 Mar 2014 16:13:11 -0700 (PDT)
In-Reply-To: <52D9DE7A.7040509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

input: appletouch: fixes for jagged/uneven cursor movement

The appletouch driver can make some touchpads feel insensitive, with movement that tends to jerk in steps. This is particularly evident when moving diagonally. There is also undesirable movement when additional fingers enter or leave the touchpad.

These patches address these issues by dialing back the fuzz setting, by implementing sensor data smoothing and by discarding movements that directly coincide with a change in the number of fingers detected on the touchpad.

Changes since v3:

1: No change
2: Fix loop counter in atp_calculate_abs
3: No change

Clinton Sprain (3):
  input: appletouch: dial back fuzz setting
  input: appletouch: implement sensor data smoothing
  input: appletouch: fix jumps when additional fingers are detected

 drivers/input/mouse/appletouch.c |  114 +++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 31 deletions(-)

-- 
1.7.9.5
