From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: [PATCH] appletouch: Improved finger detection
Date: Tue, 5 May 2009 12:10:34 -0700
Message-ID: <3AC3E247-D85C-4D8A-A73B-34677C32C2D5@freedesktop.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-19--897054505
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:47806 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZEETVA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2009 15:21:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.outersquare.org (Postfix) with ESMTP id A2BF313C16A
	for <linux-input@vger.kernel.org>; Tue,  5 May 2009 12:10:39 -0700 (PDT)
Received: from mail.outersquare.org ([127.0.0.1])
	by localhost (mail.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJPiyvCGDXCe for <linux-input@vger.kernel.org>;
	Tue,  5 May 2009 12:10:34 -0700 (PDT)
Received: from [10.0.10.2] (c-71-202-240-52.hsd1.ca.comcast.net [71.202.240.52])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jeremy@mail.outersquare.org)
	by mail.outersquare.org (Postfix) with ESMTPSA id 89C5613C0FD
	for <linux-input@vger.kernel.org>; Tue,  5 May 2009 12:10:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--Apple-Mail-19--897054505
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

The appletouch driver is prone to reporting multiple fingers when only  
one is
pressing.  The appletouch driver queries an array of pressure sensors  
and
counts local maxima in pressure to determine the number of fingers.   
It just
does this on the raw values, so a data stream like:

0 100 250 300 299 300 250 100 0

actually registers as 2 fingers.

This patch updates the logic to ignore small dips in pressure that are  
less
than the threshold.

Signed-off-by: Jeremy Huddleston <jeremyhu@freedesktop.org>

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/ 
appletouch.c
index 454b961..9bb42f6 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -349,7 +349,7 @@ static int atp_calculate_abs(int *xy_sensors, int  
nb_sensors, int fact,
  		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
  			(*fingers)++;
  			is_increasing = 1;
-		} else if (i > 0 && xy_sensors[i - 1] >= xy_sensors[i]) {
+		} else if (i > 0 && (xy_sensors[i - 1] - xy_sensors[i] >  
threshold)) {
  			is_increasing = 0;
  		}



--Apple-Mail-19--897054505
Content-Disposition: attachment;
	filename=appletouch.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="appletouch.patch"
Content-Transfer-Encoding: 7bit

The appletouch driver is prone to reporting multiple fingers when only one is
pressing.  The appletouch driver queries an array of pressure sensors and
counts local maxima in pressure to determine the number of fingers.  It just
does this on the raw values, so a data stream like:

0 100 250 300 299 300 250 100 0

actually registers as 2 fingers.

This patch updates the logic to ignore small dips in pressure that are less
than the threshold.

Signed off by: Jeremy Huddleston <jeremyhu@freedesktop.org>

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 454b961..9bb42f6 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -349,7 +349,7 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
 			(*fingers)++;
 			is_increasing = 1;
-		} else if (i > 0 && xy_sensors[i - 1] >= xy_sensors[i]) {
+		} else if (i > 0 && (xy_sensors[i - 1] - xy_sensors[i] > threshold)) {
 			is_increasing = 0;
 		}
 

--Apple-Mail-19--897054505
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-19--897054505--
