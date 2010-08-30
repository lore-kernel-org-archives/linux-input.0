From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [PATCH 0/1] input: keyboard: add qci keyboard driver
Date: Mon, 30 Aug 2010 14:22:10 -0400
Message-ID: <4C7BF6D2.5080501@codeaurora.org>
References: <4C7838DD.1020004@codeaurora.org> <201008271533.01542.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57093 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab0H3SWM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 14:22:12 -0400
In-Reply-To: <201008271533.01542.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Hsin.Wu@quantatw.com

On 8/27/2010 6:33 PM, Dmitry Torokhov wrote:
> No, this is crazy... This is a twin-brother of the touchpad driver and
> I really do not understand why chip claiming to have PS/2 interface
> (3 ports if I were to believe the diagram) would not allow us talk to
> the devices...

I didn't provide a key bit of information, sorry. The keyboard is not 
attached to the EC's PS/2 port. It is on a matrix of GPIOs.

I was trying to explain that even though the firmware on the EC uses 
0xF4 written over i2c to initialize it, it doesn't appear to support 
other PS/2 commands directed to the keyboard on the GPIO matrix.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
