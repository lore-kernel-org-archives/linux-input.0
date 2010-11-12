From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC v1 PATCH 6/6] drivers: rtc: Add support for Qualcomm PMIC8058
 RTC
Date: Fri, 12 Nov 2010 14:23:01 +0530
Message-ID: <4CDD006D.1050709@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-7-git-send-email-tsoni@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:7475 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0KLIxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 03:53:06 -0500
In-Reply-To: <1289393281-4459-7-git-send-email-tsoni@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>

Hi Alessandro,

On 11/10/2010 6:18 PM, Trilok Soni wrote:
> From: Anirudh Ghayal <aghayal@codeaurora.org>
> 
> PMIC8058 is Qualcomm's power management IC. A
> 32-bit RTC is housed inside this PMIC. The RTC driver
> uses SSBI to communicate with the RTC module.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Signed-off-by: Anirudh Ghayal <aghayal@codeaurora.org>

Please review this driver. Thanks.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
