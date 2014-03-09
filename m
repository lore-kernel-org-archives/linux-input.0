From: Derya <derya.kiran@yahoo.de>
Subject: [Patch v2] Surface Pro 2 USB composite device handling
Date: Sun, 09 Mar 2014 18:51:27 +0100
Message-ID: <531CAA1F.4080809@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm10-vm9.bullet.mail.ir2.yahoo.com ([212.82.96.161]:27612 "EHLO
	nm10-vm9.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751090AbaCIRv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Mar 2014 13:51:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

This patch set is a reworked version of the one, that I submitted on Friday.
Followed the Benjamin's suggestions (many thanks)

- The first patch reverses commit 117309c51dca42121f70cacec801511b76acf75c
- The second readds the product ids and ensures the load of hid-core 
instead of hid-multiouch
