From: Sebastien Bourdeauducq <sb@m-labs.hk>
Subject: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Sat, 31 Jan 2015 23:01:17 +0800
Message-ID: <54CCEE3D.9040306@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:44652 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbAaPQ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 10:16:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by ssl.serverraum.org (Postfix) with ESMTP id 620F13F12C
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 16:01:21 +0100 (CET)
Received: from ssl.serverraum.org ([127.0.0.1])
	by localhost (ssl.serverraum.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pj1nZc-0iubL for <linux-input@vger.kernel.org>;
	Sat, 31 Jan 2015 16:01:21 +0100 (CET)
Received: from [192.168.0.104] (123202036015.ctinets.com [123.202.36.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ssl.serverraum.org (Postfix) with ESMTPSA id 3CBF83F12B
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 16:01:19 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

among the many problems that the Baytrail-based Thinkpad Tablet 10 has 
under Linux, the built-in Wacom digitizer does not work. I get the 
following messages in the kernel log (with i2c_hid.debug=1):

[  593.224249] i2c_hid i2c-WCOM0008:00: Fetching the HID descriptor
[  593.224259] i2c_hid i2c-WCOM0008:00: __i2c_hid_command: cmd=01 00
[  593.243080] i2c_hid i2c-WCOM0008:00: HID Descriptor: 1e 00 00 01 ee 
00 02 00 03 00 0a 00 00 00 00 00 04 00 05 00 6a 05 14 01 02 03 00 00 00 00
[  593.243110] i2c_hid i2c-WCOM0008:00: Could not register for 
WCOM0008:00 interrupt, irq = -1, ret = -22
[  593.253422] i2c_hid: probe of i2c-WCOM0008:00 failed with error -22

What should I look at?

Sebastien
