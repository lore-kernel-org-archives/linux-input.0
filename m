From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v3 1/1] input: add support for Nomadik SKE keypad controller
Date: Wed, 08 Sep 2010 18:28:04 +0530
Message-ID: <4C87885C.70704@codeaurora.org>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com> <4C8645CB.9070206@codeaurora.org> <33A307AF30D7BF4F811B1568FE7A9B181C8565B5@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:64987 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab0IHM6I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 08:58:08 -0400
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B181C8565B5@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hi Sundar,

> 
> These registers are for the SKE Keypad - Scroll Key Encoder and Keypad modules. The 
> scroll key encoder too shares them and hence in the header file.

Let's keep the only ones which are shared and not all. I am not sure about the scroll key
encoder driver location.

> 
> Okay.
> 
>> Can you please clarify why you need thread? Looking at the code, I don't think that
>> we have any need of creating thread. request_irq(...) should work just fine.
> 
> Yes it can. I am seeing increasing tendency to migrate to threaded_irq from the legacy irq recently
> and hence the threaded request.
> 

Use threaded_irq only when needed with different flags and not everywhere. In this case we don't
need threaded irq at all.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
