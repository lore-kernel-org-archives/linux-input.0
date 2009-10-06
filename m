From: Peter Urbanec <vger.kernel.org.input@urbanec.net>
Subject: Issues detecting i8042 AUX port
Date: Wed, 07 Oct 2009 01:24:58 +1100
Message-ID: <4ACB533A.7080001@urbanec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pecan2.exetel.com.au ([220.233.0.70]:52474 "EHLO
	pecan2.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbZJFOpT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2009 10:45:19 -0400
Received: from 243.118.70.115.static.exetel.com.au ([115.70.118.243] helo=gw.urbanec.net)
	by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <vger.kernel.org.input@urbanec.net>)
	id 1MvAyI-0003hQ-LS
	for linux-input@vger.kernel.org; Wed, 07 Oct 2009 01:24:58 +1100
Received: from black.urbanec.net ([192.168.42.11])
	by gw.urbanec.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <vger.kernel.org.input@urbanec.net>)
	id 1MvAyI-0001IN-Fz
	for linux-input@vger.kernel.org; Wed, 07 Oct 2009 01:24:58 +1100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have come across an issue that appears to be either timing sensitive
or possibly a race condition when it comes to detecting i8042 AUX port.

The full story is at http://bugs.gentoo.org/show_bug.cgi?id=287019
including attachments that contain the results of dmesg output with
i8042.debug turned on.

In a nutshell, I can run the same kernel on the same hardware and on
some boots the AUX port will not be detected and on other boots it will
come up fine. So far the only suspicion I have is that the
initialisation of USB ports and/or SATA disks may cause some kind of
delay that interferes with the i8042 detection of the AUX port.

It was suggested that I try adding my machine's DMI information to the
noloop exception table. I do not believe that doing so makes much sense,
since this is an intermittent problem, not an outright inability to
raise the AUX IRQ.

Any ideas?

