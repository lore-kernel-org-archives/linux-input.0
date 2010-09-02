From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH 1/1] input: keyboard: add qci keyboard driver
Date: Thu, 02 Sep 2010 14:21:14 +0530
Message-ID: <4C7F6582.6060108@codeaurora.org>
References: <4C7838DD.1020004@codeaurora.org> <1282947517-32118-1-git-send-email-nleeder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:29863 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0IBIvT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 04:51:19 -0400
In-Reply-To: <1282947517-32118-1-git-send-email-nleeder@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Hsin.Wu@quantatw.com, Horace Fu <horace.fu@quantatw.com>

Hi Neil,

On 8/28/2010 3:48 AM, Neil Leeder wrote:
> +	__set_bit(EV_KEY, context->qcikbd_dev->evbit);
> +	__set_bit(EV_REP, context->qcikbd_dev->evbit);

If you are going to roll out new version of this patch to address the last
comment from Dmitry, then I have couple of suggestions. If possible
then please incorporate.

Make EV_REP optional, not all the systems needs it by default. Better to introduce
pdata->rep.

Some of the systems would need each key press to wake up the system, so
disable_irq in suspend would not be what they want. How about introducing
pdata->wakeup flag and then using device_init_wakeup, device_may_wakeup,
enable/disable_irq_wake friends in probe and .suspend/.resume functions.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
