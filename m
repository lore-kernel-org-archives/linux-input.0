From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Input: atmel_mxt_ts - don't always download device config?
Date: Mon, 12 Jan 2015 10:50:11 +0100
Message-ID: <54B398D3.7010803@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:10167 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbALJ4q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2015 04:56:46 -0500
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id DA85DC04E0
	for <linux-input@vger.kernel.org>; Mon, 12 Jan 2015 10:50:13 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org

Hi Nick,

being new to the atmel_mxt_ts and starting to work with it, we wonder if 
it's really necessary to download the device config [1] at each driver 
start up?

I've been told that technically each device config download does mean 
the configuration data is flashed to the device. I.e. it's stored 
persistently, even at power loss.

This would mean that it would be sufficient to check for the device 
config already existing/flashed to the device. And only doing the 
download in case this isn't done already.

Is this understanding correct? What do you think?

Many thanks and best regards

Dirk

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/touchscreen/atmel_mxt_ts.c?id=50a77c658b80e7e3303e3bcec195b30e2b62d513
