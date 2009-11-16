From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: A question about touchscreen absmax value
Date: Mon, 16 Nov 2009 10:53:18 +0900
Message-ID: <4B00B08E.2030905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:50688 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZKPBxi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Nov 2009 20:53:38 -0500
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KT600AORIKU71@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 16 Nov 2009 10:53:18 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KT6007DPIKT2U@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 16 Nov 2009 10:53:17 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, all.

I have a question about touchscreen resolution. My touchscreen device
can report the position from 0 to 1023 of x and y coordinates, so i
setted the absmax of input device to 1023. BTW, i only can get from 0 to 
479 x position and to 799 y position because the LCD resolution of the
target is 480 x 800. I wonder which value is setted to the absmax - 479
and 799 or 1023.
