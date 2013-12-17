From: Randolf Rotta <rottaran@tu-cottbus.de>
Subject: LG 23ET83V-W multitouch monitor
Date: Tue, 17 Dec 2013 11:35:27 +0100
Message-ID: <52B028EF.6020509@tu-cottbus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.tu-cottbus.de ([141.43.99.248]:47590 "EHLO
	smtp2.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab3LQKo6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 05:44:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp2.tu-cottbus.de (Postfix) with ESMTP id 3dkG3164dDz10rmw
	for <linux-input@vger.kernel.org>; Tue, 17 Dec 2013 11:35:41 +0100 (CET)
Received: from smtp2.tu-cottbus.de ([127.0.0.1])
	by localhost (smtp2.tu-cottbus.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lmZURlxAC35s for <linux-input@vger.kernel.org>;
	Tue, 17 Dec 2013 11:35:27 +0100 (CET)
Received: from [141.43.203.121] (baldur.informatik.tu-cottbus.de [141.43.203.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: rottaran)
	by smtp2.tu-cottbus.de (Postfix) with ESMTPSA id 3dkG2l4D8hz10rls
	for <linux-input@vger.kernel.org>; Tue, 17 Dec 2013 11:35:27 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I got a LG 23ET83V multitouch monitor and needed driver support for 
that. I got it working with

options usbhid quirks=0x0457:0x1030:0x20000000

in /etc/modprobe.d/usbhid.conf

and

echo 3 0457 1030 18 
/sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id


Just saw, that there is a patch for this monitor now from Emanuel Krenz 
and Jiri Kosina. So maybe, my experiments do not provide new information.

Randolf
