From: "Jia-Ju Bai" <baijiaju1990@163.com>
Subject: Re: Re: Potential bugs found in psmouse
Date: Thu, 18 Dec 2014 08:02:14 +0800
Message-ID: <00eb01d01a55$e1e79fa0$a5b6dee0$@163.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:55514 "EHLO m12-15.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbaLRACV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 19:02:21 -0500
Content-Language: zh-cn
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Dear Sir,
Actually, I find that psmouse_attr_set_protocol checks
psmouse_switch_protocol's return vaule, but psmouse_connect does not. So I
let psmouse_switch_protocol() in psmouse_connect return -1 in purpose to
test the robustness of psmouse driver. 
However, psmouse_switch_protocol() in psmouse_connect gets NULL as protocol
and it will not fail. I think you are right, and this error is unreal.
Thank you very much!

--
Jia-Ju Bai


