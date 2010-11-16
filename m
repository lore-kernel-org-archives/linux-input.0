From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC v1 PATCH 5/6] input: pmic8058-othc: Add support for PM8058
 based OTHC
Date: Tue, 16 Nov 2010 08:38:36 +0530
Message-ID: <4CE1F5B4.3010001@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-6-git-send-email-tsoni@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:61969 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab0KPDIr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 22:08:47 -0500
In-Reply-To: <1289393281-4459-6-git-send-email-tsoni@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Dmitry,

On 11/10/2010 6:18 PM, Trilok Soni wrote:
> From: Anirudh Ghayal <aghayal@codeaurora.org>
> 
> One-touch headset controller is a hardware module in Qualcomm's PMIC8058.
> It supports headset insert/remove and switch press/release detection events
> over 3 MIC BIAS lines. The MIC BIAS lines can be configured to support
> headset detection or act as regular BIAS lines.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Anirudh Ghayal <aghayal@codeaurora.org>
> ---

Any comments on this patch?

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
