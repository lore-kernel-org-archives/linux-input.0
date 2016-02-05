From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Pull USB plug while fftest on PS4 pad --> Kernel panic
Date: Fri, 5 Feb 2016 22:03:09 +0100
Message-ID: <n932md$odm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48793 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985AbcBEVFH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 16:05:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aRnYu-0006zP-S6
	for linux-input@vger.kernel.org; Fri, 05 Feb 2016 22:05:04 +0100
Received: from p5dd5670f.dip0.t-ipconnect.de ([93.213.103.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 22:05:04 +0100
Received: from Manuel.Spam by p5dd5670f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 22:05:04 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm currently using the following Kernel version:
Linux manuelspc 4.3.3-3-ARCH #1 SMP PREEMPT Sun Jan 24 10:28:30 CET 2016 
x86_64 GNU/Linux

While testing with force feedback, I found the following bug which makes 
it impossible to disconnect the PS4 controller while some "force 
feedback user" (may also be a game) is still running.

To reproduce, connect a PS4 controller via USB. Now run "fftest" on it 
and choose effect number "0".

While the effect still runs, pull the USB plug.

Result: The kernel panics. Had to hard-reset the machine.

Is it OK to just report this here or should I open a bug on Bugzilla for 
that?
If more information is needed, just ask.

Best regards,

Manuel

