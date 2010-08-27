From: Neil Leeder <nleeder@codeaurora.org>
Subject: [PATCH 0/1] input: keyboard: add qci keyboard driver
Date: Fri, 27 Aug 2010 18:14:53 -0400
Message-ID: <4C7838DD.1020004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:9032 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0H0WOz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Aug 2010 18:14:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Hsin.Wu@quantatw.com

This is an update of the keyboard driver which Quanta previously posted 
to linux-input. Like the touchpad driver, I'm taking over maintenance 
for code aurora forum.

The keyboard is attached to an embedded controller which is accessed 
through I2C. It has a dedicated I2C address and its own interrupt line, 
so it is not treated as an mfd. Although a PS/2 command, 0xF4, is used 
to initialize the keyboard, the EC does not respond to other PS/2 
commands. I have tried a serio driver on the port and attempted to use 
keyboard drivers like xtkbd to communicate with it. These fail for 
similar reasons to those discussed in the qci touchpad thread. This is 
the reason for having this as a stand-alone driver.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
