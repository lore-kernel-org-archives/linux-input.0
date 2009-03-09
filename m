From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 0/5] WM97xx updates
Date: Mon, 09 Mar 2009 16:57:29 +0100
Message-ID: <49B53C69.5040805@gmail.com>
References: <20090303182402.GA29542@rakim.wolfsonmicro.main>	<20090304091538.GD7394@dtor-d630.eng.vmware.com>	<49AE492F.6020006@atmel.com>	<20090304105358.GA32107@rakim.wolfsonmicro.main>	<49AE65FF.2060309@atmel.com> <20090309164846.75152a9a@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:60283 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbZCIP5g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2009 11:57:36 -0400
In-Reply-To: <20090309164846.75152a9a@hcegtvedt>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

On 9.3.2009 16:48, Hans-Christian Egtvedt wrote:
> Please see attached patch.

Note that atmel_wm97xx struct still leaks on atmel_wm97xx_probe fail paths.
