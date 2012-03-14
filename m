From: "Ganir, Chen" <chen.ganir@ti.com>
Subject: User space raw hid support
Date: Wed, 14 Mar 2012 11:47:42 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B44E9F3@DNCE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152Ab2CNLrp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 07:47:45 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2EBliWH022500
	for <linux-input@vger.kernel.org>; Wed, 14 Mar 2012 06:47:44 -0500
Received: from DNCE72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2EBlhp1003659
	for <linux-input@vger.kernel.org>; Wed, 14 Mar 2012 06:47:44 -0500 (CDT)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi all.

I'm currently working on a HID Over GATT Implementation (HID over Bluetooth Low energy).

As part of the design, it is required to configure the HID subsystem from user space, configure a report descriptor with input/output/feature report points, and send/receive data from and to the kernel HID Subsystem, from user space.

Is there anything already supporting this feature ? I was looking at hid-raw, but it is used to send raw data from user space to the hid device - I need to send raw hid from the device to the kernel.

Our basic idea was to develop a new misc char driver, at /dev/uhid. This device will be opened for each remote device we have access to, configured, and then read/write the raw HID packets from the device directly to this driver. We would like our solution to be a simple proxy between the device and the HID system, and we do not want to include a HID parser in our code, to make sure latency stays as low as possible.

Thanks for your assistance,

Chen Ganir
Texas Instruments.
