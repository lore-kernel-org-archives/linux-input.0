From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Ben_Nanonote keyboard driver bug
Date: Fri, 18 Sep 2009 15:43:22 +0800
Message-ID: <4AB33A1A.7090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:50600 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZIRHn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 03:43:28 -0400
Received: by pxi32 with SMTP id 32so607406pxi.4
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2009 00:43:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hard- and Software Development, Kernel, Distribution, Roadmap" <developer@lists.qi-hardware.com>
Cc: linux-input@vger.kernel.org

Hi 

with Dmitry's help, our keyboard is work.

we use the matrix_keypad.c driver. I found a problem.
for example. the keypad is like this: (part of keypad)  
GPIO    GPIO    GPIO
|       |       |  
a_______w_______u_____GPIO
|	|	|
|_______s_______j_____GPIO
|	|	|
Shift___Alt_____Ctrl__GPIO

first time press [Shift] + [a] it's output [a] not the [A]
second time press [Shift] + [a] it's output [A]. correct.
then all work fine.  but when I release the [Shift]. and press [a]
it's will also output big [A]. but if the midifier and character not 
in same column GPIO. it will work fine. 

other modifier all like this. same GPIO will cause problem.

I should look into the matrix_keypad.c to fix this, right?

Best Regards
-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
