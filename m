From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Fri, 13 Aug 2010 15:04:37 +0530
Message-ID: <4C6511AD.4060800@codeaurora.org>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org> <0680EC522D0CC943BC586913CF3768C003B3909F9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:43950 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934145Ab0HMJeo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 05:34:44 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3909F9C@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Neil Leeder <nleeder@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>

Hi Shubhrajyoti,

>> +
>> +gpio_request_fail:
>> +	input_unregister_device(context->qcitp_dev);
>> +	context->qcitp_dev = NULL;
>> +
>> +register_fail:
>> +	input_free_device(context->qcitp_dev);
> You may like to revisit the use of free after unregister.
> 

That looks OK, because qcitp_dev is set to NULL before this call.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
