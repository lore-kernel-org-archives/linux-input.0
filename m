From: Hanno Zulla <abos@hanno.de>
Subject: How to add support for Motorola RZ100?
Date: Thu, 23 Jul 2015 12:57:07 +0200
Message-ID: <55B0C883.20001@hanno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoot.epublica.de ([78.46.103.157]:41589 "EHLO zoot.epublica.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbbGWLFN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 07:05:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zoot.epublica.de (Postfix) with ESMTP id A80AA1840D97
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2015 12:57:08 +0200 (CEST)
Received: from zoot.epublica.de ([127.0.0.1])
	by localhost (zoot.epublica.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhGUkNoyQnEr for <linux-input@vger.kernel.org>;
	Thu, 23 Jul 2015 12:57:08 +0200 (CEST)
Received: from [10.1.0.136] (unknown [85.183.3.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by zoot.epublica.de (Postfix) with ESMTPSA id CB0CA1840D7F
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2015 12:57:07 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi there,

how can I help add support for the following device?

The "Motorola Smart Controller RZ100" is a combined telephony headset
and HID touchpad with four Android-specific buttons. It is designed to
work as a remote control for Motorola Android devices.

<https://motorola-global-portal.custhelp.com/app/product_page/faqs/p/1422,7975,8227>

<http://www.amazon.com/Motorola-Bluetooth-Smart-Controller-Android/dp/B0060EKFYG>

It is possible to pair this device with my Linux box, see the log output
below.

Using hid-recorder, the incoming events can be seen. But none of the
buttons or the touchpad are supported within my system.

How can I help adding this?

Thanks!



dmesg output:


Jul 23 11:57:48 e kernel: [ 6636.376497] hid-multitouch
0005:22B8:093D.0004: unknown main item tag 0x0

Jul 23 11:57:48 e kernel: [ 6636.376598] input: Motorola RZ100 UNKNOWN
as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/bluetooth/hci0/hci0:41/0005:22B8:093D.0004/input/input13

Jul 23 11:57:48 e kernel: [ 6636.377266] hid-multitouch
0005:22B8:093D.0004: input,hidraw3: BLUETOOTH HID v1.31 Mouse [Motorola
RZ100] on 00:10:60:a6:0c:12
