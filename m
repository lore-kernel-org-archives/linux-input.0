From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: How to use force feedback correctly?
Date: Mon, 16 Mar 2009 11:42:11 +0100
Message-ID: <200903161142.12123.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:34936 "EHLO
	john.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZCPLMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2009 07:12:38 -0400
Received: from 77-64-160-248.dynamic.primacom.net ([77.64.160.248] helo=weaselweb.localnet)
	by john.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alexander.stein@informatik.tu-chemnitz.de>)
	id 1LjAGw-0007SF-Aa
	for linux-input@vger.kernel.org; Mon, 16 Mar 2009 11:42:18 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I've read the documentation about force feedback in 
Documentation/input/ff.txt. But I'm rather unsure how to use it actually. So 
far I understood this you have to use /dev/input/eventX to access your ff-
device. But normally only root has read and write access to this device files, 
while a joystick is used normally using /dev/input/jsX which can be used by a 
non-root user.

So my actual question is: How can I use force feedback of a joystick without 
setting global read/write permissions to /dev/input/eventX? Or may I even be 
able to use force feedback using /dev/input/jsX?

Other thing: Is it possible that on line 52 in Documentation/input/ff.txt the 
declaration of the features array is wrong?
> #52 unsigned long features[1 + FF_MAX/sizeof(unsigned long)];
IMO it has to be declared like this:
> unsigned long features[1 + FF_MAX/ (8 * sizeof(unsigned long))];
Which creates actually a Bit array, not an Byte array.

Thanks in advance
Regards
Alexander
