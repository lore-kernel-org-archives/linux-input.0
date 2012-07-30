From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH 3/3] input: misc: New USB eBeam input driver.
Date: Mon, 30 Jul 2012 16:25:00 +0200
Message-ID: <5016993C.9010906@laposte.net>
References: <1343433754-3887-1-git-send-email-yann.cantin@laposte.net> <1343433754-3887-4-git-send-email-yann.cantin@laposte.net> <20120728014252.GB19817@core.coreip.homeip.net> <5013AA95.7090006@laposte.net> <20120730055623.GD5830@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:41617 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab2G3OYr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jul 2012 10:24:47 -0400
In-Reply-To: <20120730055623.GD5830@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org

Hi,

>> The code structure (device selector + functions indirection) also seems overkill
>> to me for now, but permit to anticipate device's variations. If it appears that they
>> all works in the same way, it'll be easy (and more comfortable to me) to step down,
>> the opposite seems more difficult.
> 
> Actually I am hesitant to add infrastructure if it is unclear if we need
> it at all.

Understand.

I've thrown some hook to see if i can get my hands on other devices.

In the meantime, i'll bet on uniform support and strip down the driver. Wish me luck.

Thanks.
-- 
Yann Cantin
A4FEB47F
--
