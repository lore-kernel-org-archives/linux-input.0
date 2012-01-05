From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Thu, 5 Jan 2012 12:09:44 -0800
Message-ID: <4F060388.80802@synaptics.com>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com> <20120105075855.GD31895@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:9618 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448Ab2AEUJp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 15:09:45 -0500
In-Reply-To: <20120105075855.GD31895@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On 01/04/2012 11:58 PM, Dmitry Torokhov wrote:
> On Wed, Dec 21, 2011 at 06:09:51PM -0800, Christopher Heiny wrote:
>> This patch implements a driver supporting Synaptics ClearPad and other
>> touchscreen sensors that use the RMI4 protocol, as defined here:
>>
>>      http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
>>
>> as well as successor documents that haven't made their way through to
>> publication yet.

[snip]


>>      - character device access to the RMI4 register map via rmidev
>
> Could you please tell me why this facility is needed?

In conjunction with an Android application (Synaptics RED), this allows 
the PC-based Design Studio 4 configuration and diagnostic tool to access 
the RMI4 sensor via USB, Wifi, Bluetooth, etc.  We figured it might also 
be useful to the general development community, so we included it here.

					Chris
