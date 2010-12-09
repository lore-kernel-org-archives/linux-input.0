From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Thu, 09 Dec 2010 12:32:57 +0530
Message-ID: <4D007F21.5060602@codeaurora.org>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org> <AANLkTikOOH3qHHRtqETytYBk_MiCeVBU724CooUYqgdy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:55394 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0LIHDB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 02:03:01 -0500
In-Reply-To: <AANLkTikOOH3qHHRtqETytYBk_MiCeVBU724CooUYqgdy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: Daniel Walker <dwalker@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arve@android.com

Hi Abraham,

On 12/9/2010 12:04 PM, Arce, Abraham wrote:
> 
>> +
>> +static unsigned int trout_col_gpios_evt2[] = { 35, 34, 33, 32, 31, 23, 30, 109 };
> 
> WARNING: line over 80 characters

I would leave this to Daniel if he wants to fix it, because by making it under 80 is not
going to improve any code readability, so I prefer to keep it as is.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
