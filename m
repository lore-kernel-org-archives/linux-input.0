From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH 0/2] input: appletouch: fixes for jagged/uneven cursor movement
Date: Thu, 09 Jan 2014 17:59:29 -0600
Message-ID: <52CF37E1.3030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56814 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbaAIX7d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 18:59:33 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so4477626iej.12
        for <linux-input@vger.kernel.org>; Thu, 09 Jan 2014 15:59:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

From: Clinton Sprain <clintonsprain@gmail.com>

For many devices, the appletouch driver can make the trackpad feel
insensitive and cursor movement will tend to jerk in steps. This is
particularly noticeable when moving the cursor diagonally. This can
greatly impact the trackpad's usability.

The proposed changes address this by dialing back the fuzz and threshold
parameters and by implementing a new cursor movement smoothing algorithm.

User feedback couldn't be found for some older devices that use this driver,
so module parameters have been added to allow users to manually set the
fuzz and threshold settings and/or opt out of the new smoothing algorithm.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
Tested-by: Curtis Rueden <ctrueden@gmail.com>

Clinton Sprain (2):
  input: appletouch: parametrize and set saner defaults for fuzz and
    threshold
  input: appletouch: use better cursor movement smoothing algorithm

 drivers/input/mouse/appletouch.c |  184 +++++++++++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 42 deletions(-)

--
1.7.9.5
