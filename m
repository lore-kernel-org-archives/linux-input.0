From: Jose Diez <jose@mediacru.sh>
Subject: Help writing a custom HID driver
Date: Thu, 06 Nov 2014 18:33:41 +0000
Message-ID: <545BBF05.9030203@mediacru.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mediacru.sh ([5.254.104.62]:51914 "EHLO mediacru.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbaKFSj4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Nov 2014 13:39:56 -0500
Received: from [192.168.0.4] (cpc8-cove11-2-0-cust751.3-1.cable.virginm.net [82.16.198.240])
	by mediacru.sh (Postfix) with ESMTPSA id 255BC40122
	for <linux-input@vger.kernel.org>; Thu,  6 Nov 2014 19:33:43 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello linux-input,

I'm trying to write a custom HID driver. It works fine, and I can send 
reports just fine, but one of the requirements of this device is that I 
have to reply to reports with code 62 with another report with code 62, 
which resets a watchdog in the device.

This is my code so far: http://codepad.org/m4QiWhDt

The problem is in line 40. It seems like I'm not allowed to call 
hid_hw_output_report from the raw_event callback handler. I've tried 
surrounding the call with spin_locks, but I still get the "scheduling 
while atomic" error.

I'm not sure how to approach this - can someone help? It would be much 
appreciated. Thanks.
