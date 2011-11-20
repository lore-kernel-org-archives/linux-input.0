From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Sun, 20 Nov 2011 23:22:11 +0400
Message-ID: <4EC95363.7040300@emcraft.com>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com> <20111114172809.GD12659@core.coreip.homeip.net> <4EC94254.8000700@emcraft.com> <20111120183607.GA18116@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:46219 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab1KTTWF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Nov 2011 14:22:05 -0500
In-Reply-To: <20111120183607.GA18116@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Anatolij Gustshin <agust@denx.de>

Hi Dmitry,

On 20.11.2011 22:36, Dmitry Torokhov wrote:
>> Do you really think leaving a pointer to a non-existing structure is a
>> good idea?
> 
> I2C core takes care of clearing it after remove() or failed probe().

Ah.. I see. Thanks!

Regards, Ilya.
