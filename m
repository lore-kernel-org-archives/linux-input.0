From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Questions about Multi-touch Protocal
Date: Tue, 05 Jan 2010 15:18:00 +0900
Message-ID: <4B42D998.4050303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38776 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0AEGSw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2010 01:18:52 -0500
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KVR00IKTG60ET@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 05 Jan 2010 15:18:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KVR00BMSG601C@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 05 Jan 2010 15:18:00 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, dmitry.torokhov@gmail.com, jkosina@suse.cz

Hi, all.

I have some questions about Multi-touch(MT) Protocal.

First, what is the purpose of ABS_MT_TOUCH_MAJOR event? I wonder how
it is used at userspace side.

Should the ABS_MT_TOUCH_MAJOR be the mininum set of events for multi
touch? I'm not sure whether this question is valid because of first
question.

Finally, what is difference of ABS_MT_TOUCH_MAJOR and
ABS_MT_WIDTH_MAJOR?

I read the MT Protocol document of kernel, but i cannot understand above
things clearly.

Thanks.
