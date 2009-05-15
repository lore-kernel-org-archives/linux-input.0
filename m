From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: How to choeck for a gpio-keys based switch state?
Date: Fri, 15 May 2009 17:47:55 +0200
Message-ID: <4A0D8EAB.6070900@tis.icnet.pl>
Reply-To: postmaster@icnet.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57638 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652AbZEOQVk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 12:21:40 -0400
Received: from ic0101.ic.hcp.icnet ([172.16.2.8])
	by d1.icnet.pl with asmtp (Exim 4.34)
	id 1M4zfV-0005Hh-4Z
	for linux-input@vger.kernel.org; Fri, 15 May 2009 17:49:53 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

Greetings from new list member.

I am trying to create a gpio-keys based platform device driver for a 
hook switch. I am wondering if there is a possibility to check for the 
switch state before the first event comes up. I think this feature could 
be essential for correct user experience - an application should know 
the switch state from the start.
As I am not able to find such functionality in the current gpio-keys 
driver, I wonder if this could be done over gpiolib sysfs interface by 
adding optional gpio_export() call to the driver init function. I can 
try to provide a patch if this sounds reasonable to you.

Thanks,
Janusz
