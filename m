From: Denis Carikli <denis@eukrea.com>
Subject: Re: [PATCH] Input: tsc2007 - remove unused poll_delay from platform
 data
Date: Mon, 25 Nov 2013 09:40:35 +0100
Message-ID: <52930D03.2070607@eukrea.com>
References: <20131121051319.GA6131@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:42368 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751906Ab3KYJEo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Nov 2013 04:04:44 -0500
Received: from mail95.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id F3C81FFB4BE
	for <linux-input@vger.kernel.org>; Mon, 25 Nov 2013 09:43:02 +0100 (CET)
In-Reply-To: <20131121051319.GA6131@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Bill Pemberton <wfp5p@virginia.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org

On 11/21/2013 06:13 AM, Dmitry Torokhov wrote:
> The driver does not use poll_delay parameter, so let's remove it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I tested on top of the "tsc2007 misc fixes" patch.

Tested-by: Denis Carikli <denis@eukrea.com>

Denis.
