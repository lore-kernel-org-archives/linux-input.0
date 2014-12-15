From: "Jia-Ju Bai" <baijiaju1990@163.com>
Subject: Potential bugs found in psmouse
Date: Mon, 15 Dec 2014 10:55:21 +0800
Message-ID: <000401d01812$91496a50$b3dc3ef0$@163.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:44762 "EHLO m12-15.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbaLOCz1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Dec 2014 21:55:27 -0500
Content-Language: zh-cn
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Recently I test linux device drivers 3.17.2, and find some potential bugs.

The target file is drivers/input/mouse/psmouse-base.c, which is used to
build psmouse.ko. I hope you can help me check my findings:
[1] psmouse_switch_protocol is called by psmouse_connect when initializing
the driver. However, psmouse_switch_protocol may be failed and return -1,
but its return value is not checked in psmouse_connect. In my experiment of
running the driver, when psmouse_switch_protocol in psmouse_connect is
failed, the system crash will occur.

Could you help me check these findings? Thank you very much, and I'm looking
forward to your reply.

--
Jia-Ju Bai


