From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Regression with a Mac (on a "Geyser")
Date: Tue, 11 Mar 2008 22:25:00 -0700
Message-ID: <20080311222500.b9329708.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:59484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYCLF3j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2008 01:29:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: zaitcev@redhat.com, alex@malexmedia.net

Hi, Guys:

One of my users is hitting a problem with the touchpad on a Mac
dying after a period of time. Although it's possible that an
application action is involved, we have established that kernel
2.6.23 works, but 2.6.24 fails.

Would Johannes or someone versed in HID be so kind to look at this:
 https://bugzilla.redhat.com/show_bug.cgi?id=435419

Thanks,
-- Pete
