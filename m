From: =?big5?B?vEK5xcJA?= <scott.liu@emc.com.tw>
Subject: The way of touch finger and pen stylus report
Date: Fri, 5 May 2017 15:31:02 +0800
Message-ID: <002301d2c571$8cadc360$a6094a20$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:3044 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdEEHah (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 03:30:37 -0400
References: 
In-Reply-To: 
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, benjamin.tissoires@gmail.com

I would like to write a touch driver for finger touch and pen stylus.
They have different definition on maximum range of X, Y, Pressure, 
additionally, pen have two buttons functionality that need to be reported.

So can driver register two input device to corresponding finger touch and
pen stylus?
Otherwise how single input device can map two different X, Y, Pressure
range.

Another thing is that pen stylus has two buttons which enumerate to
Eraser/Invert and Barrel as MS spec said.
Please refer to
https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design/compo
nent-guidelines/required-hid-top-level-collections

My question is that how do buttons represents to key bit event? Any example?

Hi Benjamin,
	My device is hidi2c and finger / pen has described in descriptor.
	So does hid-multitouch module support it?

Thanks.

BR,
Scott 


