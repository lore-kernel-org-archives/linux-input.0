From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: uinput: How to use force feedback?
Date: Sun, 17 Jan 2016 14:27:29 +0100
Message-ID: <n7g4s1$i1l$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44560 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbcAQN1o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jan 2016 08:27:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aKnMr-0002EF-61
	for linux-input@vger.kernel.org; Sun, 17 Jan 2016 14:27:41 +0100
Received: from p5dd5670f.dip0.t-ipconnect.de ([93.213.103.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2016 14:27:41 +0100
Received: from Manuel.Spam by p5dd5670f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2016 14:27:41 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I have an existing uinput driver, which itself sits on an open device 
with a blocking read(), waiting for events to come in. Every event is 
translated to a key code and then sent to uinput.

My next step would be to pass through force feedback information, but I 
don't really understand how I should do this.

As far as I can see, the "uninput device" itself sends events in this 
case. But my main loop is already blocked by the "read", I use to get 
device events.

I see two possible solutions:
- "Somehow", I should be able to get "blocking read" from two open 
devices. As far as I found out, so far, "select" should be the right 
command to do this?
- I could start two threads. One blocked by the "device events" and one 
by the "uinput events".

Which one would you recommend? Is uinput/ioctl thread safe? Is the 
second thread a good idea or is the communication, coming from uinput, 
such "low traffic", that it doesn't delay key handling in a relevant way?

Thank you very much in advance

Manuel

