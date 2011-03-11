From: Peter <peter@slim-one.de>
Subject: Force Feedback Logitech G25/G25/Driving Force Pro
Date: Fri, 11 Mar 2011 12:15:04 +0100
Message-ID: <1299842104.2550.24.camel@slim-one-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:49164 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1CKLVz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 06:21:55 -0500
Received: from [88.65.56.250] (helo=[192.168.0.10])
	by smtprelay01.ispgateway.de with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <peter@slim-one.de>)
	id 1Py0JD-0004RX-Jx
	for linux-input@vger.kernel.org; Fri, 11 Mar 2011 12:15:03 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi,

i'd like to ask if someone could add the id's of the logitech wheels to
drivers/hid/hid-lgff.c, so that the wheels autocenter can be
enabled/disabled by userland programs like wine. There has been
discussion over this before:
http://www.mail-archive.com/linux-input@atrey.karlin.mff.cuni.cz/msg01426.html

Line 72:
        { 0x046d, 0xc294, ff_wheel },
has to be copied twice with 0xc294 changed to 0xc298 (DFP) and 0xc299
(G25/G27), because after switching to native mode the devices report
different ids:
        { 0x046d, 0xc298, ff_wheel },
        { 0x046d, 0xc299, ff_wheel },

That's it. 
I managed to get my G27 fully working in LFS (http://www.lfs.net) with
this small modification and some additional fixes to wine. The G25's
Force Feedback, all 4 axis and 20some buttons work like a charm.

Thx in advance, Peter


