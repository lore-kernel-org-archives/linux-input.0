From: Arjan van de Ven <arjan@infradead.org>
Subject: [patch 0/2] Make the touchpad on the MSI Wind netbook work
Date: Wed, 4 Feb 2009 19:15:40 -0800
Message-ID: <20090204191540.2d6abd87@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57101 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbZBEDRQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2009 22:17:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hi,

A MSI Wind (100) netbook landed on my desk with the comment "touchpad
doesn't work in Linux but works in XP". 

It turns out that there are a 2 separate issues with this netbook that
needed fixing 

1) The touchpad requires the equivalent of "i8042.reset", which resets
the controller before probing. (This is done via a DMI quirk in patch
2/2)

2) About half the time, the reset will fail the first time. In the
current code, this is fatal and then also disables the keyboard in
addition to the touchpad. Ungood. Patch 1 makes the kernel retry the
reset upto five times before giving up (it seems the 2nd or 3rd time
succeed for me), and also adds an option to not make such a failure
fatal to the keyboard.

I don't think this is a regression, but it is pretty nasty behavior
(the machine is useless without) so it could be a 2.6.29 candidate...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
