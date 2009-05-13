From: "Yao-Chung Chang" <yaochung@cic.org.tw>
Subject: about mouse lost synchronization
Date: Wed, 13 May 2009 15:27:33 +0800
Message-ID: <000001c9d39c$4baeb6f0$e30c24d0$@org.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.cic.org.tw ([140.126.26.1]:47121 "EHLO ns1.cic.edu.tw"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbZEMH1z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 03:27:55 -0400
Received: from matrix (dyn-224.cic.edu.tw [140.126.26.224])
	by ns1.cic.edu.tw (8.12.11/8.12.9) with ESMTP id n4D7Rtiu010742
	for <linux-input@vger.kernel.org>; Wed, 13 May 2009 15:27:55 +0800 (CST)
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear all

I've implemented a ps/2 serio driver that uses GPIO (two GPIO pins). Each 

bit is triggered by GPIO interrupt. When in console mode, GPM works

fine, and I can see the mouse cursor moves correctly. But When entering 

GUI, say QT or microwindows, the following messages occurred:

Mouse at xxxxx/serio0/input0 lost synchronization, throwing 1 bytes away.
..
Mouse at xxxxx/serio0/input0 lost synchronization, throwing 1 bytes away.

Mouse at xxxxx/serio0/input0 lost synchronization, throwing 2 bytes away.

And the mouse cursor is floating and moves incorrectly. 

What is the criteria that kernel think the mouse packet is lost of sync.?

                                        Regards,
                                                ycchang
 

__________ Information from ESET NOD32 Antivirus, version of virus signature
database 4069 (20090512) __________

The message was checked by ESET NOD32 Antivirus.

http://www.eset.com
 

