From: Neil Leeder <nleeder@codeaurora.org>
Subject: [PATCH 0/1] mouse: add qci touchpad driver
Date: Fri, 06 Aug 2010 16:31:57 -0400
Message-ID: <4C5C713D.8010902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:27166 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762015Ab0HFUcE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 16:32:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>, Neil Leeder <nleeder@codeaurora.org>

This is an update of the driver that Quanta posted here a few days ago. 
Quanta wrote the original version of the driver and I am picking up 
maintenance for code aurora forum.

I've addressed the review comments. The only one that's outstanding is 
the use of the sensitivity value. I don't see an easy way that userspace 
would be able to apply the sensitivity scaling between the driver and 
say xorg, so for now I've left it in the driver, but I'd welcome any 
suggestions for improvement.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
