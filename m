From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/1] input: keyboard: add qci keyboard driver
Date: Fri, 27 Aug 2010 15:33:01 -0700
Message-ID: <201008271533.01542.dmitry.torokhov@gmail.com>
References: <4C7838DD.1020004@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54857 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab0H0WdI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Aug 2010 18:33:08 -0400
In-Reply-To: <4C7838DD.1020004@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Hsin.Wu@quantatw.com

On Friday, August 27, 2010 03:14:53 pm Neil Leeder wrote:
> This is an update of the keyboard driver which Quanta previously posted
> to linux-input. Like the touchpad driver, I'm taking over maintenance
> for code aurora forum.
> 
> The keyboard is attached to an embedded controller which is accessed
> through I2C. It has a dedicated I2C address and its own interrupt line,
> so it is not treated as an mfd. Although a PS/2 command, 0xF4, is used
> to initialize the keyboard, the EC does not respond to other PS/2
> commands. I have tried a serio driver on the port and attempted to use
> keyboard drivers like xtkbd to communicate with it. These fail for
> similar reasons to those discussed in the qci touchpad thread. This is
> the reason for having this as a stand-alone driver.
>

No, this is crazy... This is a twin-brother of the touchpad driver and
I really do not understand why chip claiming to have PS/2 interface
(3 ports if I were to believe the diagram) would not allow us talk to
the devices...

-- 
Dmitry
