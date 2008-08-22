From: Thomas Reitmayr <treitmayr@devbase.at>
Subject: Usage of new KEY_NUMERIC_* codes in an existing driver (yealink)
Date: Fri, 22 Aug 2008 19:01:28 +0200
Message-ID: <1219424488.6684.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpgw01.world4you.com ([80.243.163.21]:38445 "EHLO
	smtpgw01.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbYHVTpI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2008 15:45:08 -0400
Received: from [85.127.158.181] (helo=[192.168.1.76])
	by smtpgw01.world4you.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <treitmayr@devbase.at>)
	id 1KWa0v-0004hk-Ls
	for linux-input@vger.kernel.org; Fri, 22 Aug 2008 19:01:37 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux-Input <linux-input@vger.kernel.org>

Hi,
I am in the process of extending the existing yealink driver, partly to
support various other models. The existing driver as included in the
current kernel uses the shift key to report the keys "*" and "#", but I
am hesitating to do the same bad "trick" for the other models.

As I would like to eventually submit the extended driver upstream, what
is the recommended strategy in my situation regarding usage of the new
KEY_NUMERIC_* codes? Use them only for the new models (which would
result in an ugly mix), or also update the codes for the existing
USB-P1K model (which would break userspace programs but finally fix
things for some foreign keyboard layouts), or for the existing USB-P1K
model report the old and the new codes (which might look like two key
presses)?

Thanks for your advice,
-Thomas

PS: The updated driver is available at
http://www.devbase.at/svn/view.cgi/yealink-module/trunk/?root=voip
(still including #if's reg. kernel versions, some comments to be
corrected, etc.)

