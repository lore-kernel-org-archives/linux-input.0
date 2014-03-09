From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v3 0/3] input: appletouch: fixes for jagged/uneven cursor
 movement
Date: Sun, 09 Mar 2014 00:03:25 -0600
Message-ID: <531C042D.5090103@gmail.com>
References: <52D9DE7A.7040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:42870 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaCIGD3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Mar 2014 01:03:29 -0500
Received: by mail-yk0-f175.google.com with SMTP id 131so15698060ykp.6
        for <linux-input@vger.kernel.org>; Sat, 08 Mar 2014 22:03:28 -0800 (PST)
In-Reply-To: <52D9DE7A.7040509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Changes from last time:

1: Dropped fuzz as a module parameter; also changed threshold defaults back to 5, as I found an outside case where the lower threshold was problematic for finger counting

2: Nix negative subscripts, make smooth array large enough that boundary condition is basically irrelevant (though still handled just in case), scale up and down a little bit more effectively, style

3: Unchanged, except for setting dev->fingers_old to 0 when x and y don't come back with coordinates

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>

Clinton Sprain (3):
  input: appletouch: dial back fuzz setting
  input: appletouch: implement sensor data smoothing
  input: appletouch: fix jumps when additional fingers are detected

 drivers/input/mouse/appletouch.c |  114 +++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 31 deletions(-)

-- 
1.7.9.5

