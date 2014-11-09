From: Jose Diez <jose@mediacru.sh>
Subject: Help with input_report_key not reporting key
Date: Sun, 09 Nov 2014 10:57:51 +0000
Message-ID: <545F48AF.7040206@mediacru.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mediacru.sh ([5.254.104.62]:57844 "EHLO mediacru.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbaKIK6B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Nov 2014 05:58:01 -0500
Received: from [192.168.0.4] (cpc8-cove11-2-0-cust751.3-1.cable.virginm.net [82.16.198.240])
	by mediacru.sh (Postfix) with ESMTPSA id 933E6409C2
	for <linux-input@vger.kernel.org>; Sun,  9 Nov 2014 11:57:53 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hello linux-input,

Sorry to post about a similar question again, but I'm still stuck. So a 
bit of back story: I'm writing a custom HID driver which, among other 
things, will register several input devices.

I'm able to read HID reports from the device using the raw_event 
callback, and I'm able to communicate with the device, but I seem to 
have hit an obstacle I can't get over. I've tried to add a proper input 
device to the driver, and while it registers it properly and shows up in 
/dev/input/*, the events seem to not go through.

I found this simple kernel module, which indeed works properly and 
reports key events: http://sprunge.us/NLcD

I then adapted it to work with my kernel module, shown here: 
http://sprunge.us/egIi

It allocates the input device in fblng_probe(), sets the KEY_A bit in 
the keybit field, and registers it. Then, when a request comes to the 
device, in fblng_event(), I (try to) send a key with input_report_key. 
This doesn't seem to trigger a keypress.

I'm looking at the relevant /dev/input/eventX with `evtest`. I know I'm 
getting events through, because I can see it in `dmesg`. However, it 
doesn't actually go through to the input handler.

Any help, please?

Thanks a lot,
Jose
