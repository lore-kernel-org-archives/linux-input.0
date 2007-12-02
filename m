From: Mark Lord <lkml@rtr.ca>
Subject: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 02 Dec 2007 11:21:32 -0500
Message-ID: <4752DB8C.50608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2360 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbXLBQVe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2007 11:21:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rubini@ipvvis.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

I've only just recently tried running 2.6.24 on my main machine.
And it appears that I'll have to go back to 2.6.23,
because the USB mouse is not working correctly.

Single-clicking on things with 2.6.24 very frequently gives a "double-click".
This does not happen with 2.6.23.8.

I wonder what broke it?

I've grabbed mousedev.c from 2.6.23 and inserted that in place
of the updated 2.6.24 source, but no change.  So it's not that file.

?????
