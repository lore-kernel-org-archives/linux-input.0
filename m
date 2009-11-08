From: Peter Urbanec <vger.kernel.org.input@urbanec.net>
Subject: Re: Issues detecting i8042 AUX port
Date: Sun, 08 Nov 2009 15:22:09 +1100
Message-ID: <4AF64771.3050401@urbanec.net>
References: <4ACB533A.7080001@urbanec.net> <alpine.LRH.2.00.0910082315070.12171@twin.jikos.cz> <4AE989D0.1070302@urbanec.net> <alpine.LSU.2.00.0911021532090.4203@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pecan2.exetel.com.au ([220.233.0.70]:51284 "EHLO
	pecan2.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZKHEWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Nov 2009 23:22:06 -0500
Received: from 243.118.70.115.static.exetel.com.au ([115.70.118.243] helo=gw.urbanec.net)
	by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <vger.kernel.org.input@urbanec.net>)
	id 1N6zI1-0005GV-Vw
	for linux-input@vger.kernel.org; Sun, 08 Nov 2009 15:22:10 +1100
Received: from black.urbanec.net ([192.168.42.11])
	by gw.urbanec.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <vger.kernel.org.input@urbanec.net>)
	id 1N6zI1-00030X-Pz
	for linux-input@vger.kernel.org; Sun, 08 Nov 2009 15:22:09 +1100
In-Reply-To: <alpine.LSU.2.00.0911021532090.4203@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Jiri Kosina wrote:
> Does 2.6.32 work out of the box without any modifications? Dmitry added 
> generic blacklist entry for all notebook chasis types, so 2.6.32 should 
> have solved it for you.

I currently don't have the resources to do much testing, but once 2.6.32 
is released and available as a Gentoo package, I'll re-test without the 
i8042.noloop option.

I expect that Dmitry's fix will be effective, but if there are any 
issues, I'll be back with more info.


Thanks.

	Peter Urbanec
