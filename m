From: "Patil, Rachna" <rachna@ti.com>
Subject: FW: Touchscreen co-ordinates swap
Date: Wed, 5 Oct 2011 17:38:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302578FAB8A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934481Ab1JEMIY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 08:08:24 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi,

I have a 4 wire resistive touchscreen, which I am working on. I have a =
query and require some advice on the same.
On an interrupt, I get set of x and y co-ordinates.
At =A0frame buffer (0, 0) my touchscreen reports a (max ,max) and frame=
 buffer (max, max) reports a (min ,min) on=20
touchscreen. The values are diagonally swapped. =A0

If I run ts_calib and then do a ts_test. I do not face an issues. I can=
 do a drag/draw as expected.
But if I run any other matrix GUI applications I see that the cursor po=
sition is swapped(as mentioned above).

Should the touchscreen also take care of calibration as a part of the d=
river
Or the application(user space) needs to do this ?


Regards,
Rachna.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
