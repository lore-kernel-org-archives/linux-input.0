From: Rakesh Iyer <riyer@nvidia.com>
Subject: Laptop Function key (KEY_FN) not recognized by XWindows
Date: Fri, 4 Feb 2011 17:05:50 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A0080B0@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:18502 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1BEBFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 20:05:52 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "'dmitry.torokhov@gmail.com'" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi All.

I am writing a Keyboard driver where the Function key (as seen in Laptop) is used as a modifier.
In my driver I have used "KEY_FN"(from include/linux/input.h) as the keycode for this key.

When I run "xev" the key press events do not get detected.
If I modify the keycode to say KEY_MEDIA, "xev" does show the event properly.

I am wondering how to go about getting this key detected and processed by XWindows.

Thanks and Regards
Rakesh
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
