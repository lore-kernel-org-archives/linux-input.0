From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Patch for multitouch in include/linux/hid.h
Date: Sun, 10 Jan 2010 21:46:51 +0100
Message-ID: <E152F1B0-A2E9-4787-8D8D-9CE24CB86A9A@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:43367 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab0AJUqz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2010 15:46:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Dear Jiri,

I discovered I might have left a minor mistake in the Stantum driver  
I sent you, and I directly checked in your for-next tree. It happens  
that the mistake is there, and I'll work on a patch.

While checking, I found that you have applied PATCH 2/2, but not  
PATCH 1/2. Remember, I had forgotten to Cc you when I submitted my  
patches and you found out about the second later; you probably  
haven't seen the first. The point is that this PATCH 1/2 is in  
include/linux/hid.h and, as we discussed months ago, it might have  
consequences on other devices: it consists in changing the end of  
IS_INPUT_APPLICATION so that digitizer usages up to 0x0006 are  
considered as input applications. Could you have a look at it?  
Otherwise, the 3M, Stantum and Acer code will not be called by the  
HID core.

Cheers,

St.


