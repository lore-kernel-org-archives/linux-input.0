From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: How to calibrate /dev/input/eventX joystick?
Date: Wed, 03 Aug 2011 20:51:44 +0200
Message-ID: <j1c5jj$njh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41333 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab1HCTAJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Aug 2011 15:00:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1Qogfo-0004VX-Fg
	for linux-input@vger.kernel.org; Wed, 03 Aug 2011 21:00:08 +0200
Received: from p4fd18e2c.dip0.t-ipconnect.de ([79.209.142.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 21:00:07 +0200
Received: from Manuel.Spam by p4fd18e2c.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 21:00:07 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I have a software, which uses my joystick via /dev/input/eventX and not 
/dev/input/jsX.

Unfortunately the "dead zone" is too big. I need some way to reduce this. How 
can this be done? I've searched through the kernel source, but I didn't find the 
source files, responsible for creating the event devices for joysticks. 
Calibrating the jsX device doesn't seem to change anything with the eventX device.

Thanks in advance

Yours

Manuel

