From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC v1 PATCH 2/6] input: pm8058_keypad: Qualcomm PMIC8058 keypad
 controller driver
Date: Tue, 16 Nov 2010 09:19:03 +0530
Message-ID: <4CE1FF2F.6090105@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-3-git-send-email-tsoni@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:44237 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab0KPDtG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 22:49:06 -0500
In-Reply-To: <1289393281-4459-3-git-send-email-tsoni@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Dmitry,

On 11/10/2010 6:17 PM, Trilok Soni wrote:
> Add Qualcomm PMIC8058 based keypad controller driver
> supporting upto 18x8 matrix configuration.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> ---
>  drivers/input/keyboard/Kconfig           |   11 +
>  drivers/input/keyboard/Makefile          |    1 +
>  drivers/input/keyboard/pmic8058-keypad.c |  769 ++++++++++++++++++++++++++++++
>  include/linux/input/pmic8058-keypad.h    |   58 +++
>  4 files changed, 839 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/pmic8058-keypad.c
>  create mode 100644 include/linux/input/pmic8058-keypad.h

Any comments on this patch?

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
