From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: HID, driver interaction with device during probe defeated by
 4ea5454203d991ec85264f64f89ca8855fce69b0
Date: Mon, 9 Apr 2012 00:03:06 +0200
Message-ID: <20120409000306.101c3427@neptune>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:42725 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab2DHWNJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Apr 2012 18:13:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi,

picolcd driver stopped working (probe fails) recently, probably in
relation with commit 4ea5454203d991ec85264f64f89ca8855fce69b0
(HID: Fix race condition between driver core and ll-driver).

The probe code does send a report to the HID device to query version
information but times-out getting the response.

What would be the proper approach to fix this chicken-egg problem?
Semaphore introduced by above patch is only being released after
driver probe function has returned but prevents and incoming reports
from being delivered.

Touching the semaphore inside driver looks like a bad idea to me...

Thanks,
Bruno
