From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Quick note about the elantech driver
Date: Thu, 16 Jun 2011 16:43:14 +0200
Message-ID: <4DFA1682.2090403@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:50357 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab1FPOnU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 10:43:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavis (Postfix) with ESMTP id ECF997F80A6
	for <linux-input@vger.kernel.org>; Thu, 16 Jun 2011 16:43:18 +0200 (CEST)
Received: from mailservice.tudelft.nl ([130.161.131.69])
	by localhost (tudelft.nl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZDwd5a4BsLNq for <linux-input@vger.kernel.org>;
	Thu, 16 Jun 2011 16:43:15 +0200 (CEST)
Received: from smtp-a.tudelft.nl (smtp-a.tudelft.nl [130.161.180.7])
	by mx1.tudelft.nl (Postfix) with ESMTP id 3874A7F805F
	for <linux-input@vger.kernel.org>; Thu, 16 Jun 2011 16:43:15 +0200 (CEST)
Received: from [131.180.44.74] (x044074.tudelft.net [131.180.44.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-a.tudelft.nl (Postfix) with ESMTP id 2ADE9B3A62
	for <linux-input@vger.kernel.org>; Thu, 16 Jun 2011 16:43:15 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I've just found out that there is a patch written by Elantech themselves 
for getting more versions of their touchpads working with the latest 
kernels:
https://launchpadlibrarian.net/71387234/01elantech_2.6.38.patch

So if anyone has problem with a new elantech touchpad she/he can try 
this patch :-)

I'll try to have a look at it and see how to put the same functionality 
in a more elegant (and acceptable) way. But for now I have only very 
little free time, so it might take time. If anyone was beating me at it, 
it would be with pleasure ;-)

See you,
Eric

PS: In case someone is interested, I've also noticed the source of some 
kind of X driver there: 
http://people.freedesktop.org/~whot/patches/etd7-ps2-drv_1.4-1Free1.tar.gz
