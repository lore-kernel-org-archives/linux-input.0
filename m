From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/6] Input: pmic8xxx-keypad - change name of wakeup property
Date: Fri, 17 Jul 2015 17:42:18 -0700
Message-ID: <55A9A0EA.4040802@codeaurora.org>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com> <1437179781-21124-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437179781-21124-4-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/17/2015 05:36 PM, Dmitry Torokhov wrote:
> Wakeup property of device is not Linux-specific, it describes intended
> system behavior regardless of the OS being used. Therefore let's drop
> "linux," prefix, and, while at it, use the same name as I2C bus does:
> "wakeup-source".
>
> We keep parsing old name to keep compatibility with old DTSes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
