From: "chris guirl" <thelusiv@gmail.com>
Subject: Improving drivers for Logitech Driving Force Pro and G25 wheels
Date: Fri, 14 Mar 2008 03:23:10 -0400
Message-ID: <9ff0fb570803140023t30387038l9acd16a6bb8640dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:16572 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbYCNHXM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2008 03:23:12 -0400
Received: by fg-out-1718.google.com with SMTP id l27so77000fgb.17
        for <linux-input@vger.kernel.org>; Fri, 14 Mar 2008 00:23:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a Logitech Driving Force Pro and I've been trying to figure out
how to make it work better in Linux. I have recently learned some
things about both wheels that would be nice to incorporate into the
driver. Most of this information was gained through a contact at
Logitech. I intend to investigate making some changes to the kernel to
improve the support for these wheels. Two of the main features I'd
like to incorporate are setting the wheel axis range to different
values so the full 900 degree range of the wheel can be used, and
providing separated axes for the gas and brake pedals.

So, where to start? I'm not very familiar with kernel hacking but I'll
begin doing some research on it soon. Can anyone on the list provide
me with some guidance? I've tried to find some driver hacking
documentation specific to my task but I haven't found much. Something
along the lines of a joystick or USB driver hacking tutorial would
help me a lot. I've also looked through a good bit of the Linux
joystick and USB HID code in the input section and I am unsure where
device specific code goes. I guess I have some more reading to do...
:) Thanks in advance for any tips.

Chris Guirl
