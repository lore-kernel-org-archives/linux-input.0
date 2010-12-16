From: Trilok Soni <tsoni@codeaurora.org>
Subject: convert gpio-keys.c driver to request_any_context_irq
Date: Thu, 16 Dec 2010 15:56:01 +0530
Message-ID: <4D09E939.8030700@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:61899 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab0LPK0H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 05:26:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

Hi Dmitry,

gpio_keys.c driver should be converted to use request_any_context_irq(...)
infrastructure because some of the devices could use gpios from PMIC like
chips where their irqs gets registered as nested. I don't have any
device with such configuration but I was looking at this driver and I thought
if someone has come across this then they can test and submit the patch.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
