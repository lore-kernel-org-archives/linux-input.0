From: Xiangfu Liu <xiangfu@qi-hardware.com>
Subject: keyboard driver
Date: Mon, 14 Sep 2009 16:05:30 +0800
Message-ID: <4AADF94A.3040800@qi-hardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:45245 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbZINIFb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 04:05:31 -0400
Received: by ywh4 with SMTP id 4so3928808ywh.5
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2009 01:05:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hard- and Software Development, Kernel, Distribution, Roadmap" <developer@lists.qi-hardware.com>
Cc: linux-input@vger.kernel.org

Hi

some problem need fix in keyboard driver
like:

a	w	u
|	|	|
|	s	j
|	|	|
Shift	Alt	Ctrl

press	=	output
1. [Shift] + [w] = W
2. [Shift] + [u] = U
3. a = a
-----------
1. [Shift] + [a] = a
2. a = A
3. a = a
-----------

so problem is: if the keys and modifier in same column it's will not 
correct generate the keys at the first time.

any one have some idea on this?
[1] is the diff. [2] is the keypad picture.

seems if I want make the [Fn] keys work
I must look into the driver code. because there is only [SHIFT]
[CONTROL] [ALTGR] three modifier keys.


[1] http://projects.qi-hardware.com/index.php/p/openwrt-xburst/source/commit/1035dea0049c584b82d60643d0c4f56881e97866/
[2] http://downloads.qi-hardware.com/hardware/mechanical/ben/2009_08_26/keyboard_problem_2.JPG
