From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Input: migor_ts - Convert to dev_pm_ops
Date: Thu, 6 Jan 2011 14:28:13 +0900
Message-ID: <AANLkTikedP-fk5p2p58Fuy_C1S-_+Ls04RGKWaPyb1wt@mail.gmail.com>
References: <1294254606-26277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64574 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab1AFF2O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jan 2011 00:28:14 -0500
Received: by wyb28 with SMTP id 28so16084304wyb.19
        for <linux-input@vger.kernel.org>; Wed, 05 Jan 2011 21:28:13 -0800 (PST)
In-Reply-To: <1294254606-26277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, Magnus Damm <damm@opensource.se>, linux-input@vger.kernel.org

On Thu, Jan 6, 2011 at 4:10 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> There is a general move towards the use of dev_pm_ops rather than
> bus specific suspend APIs as this simplifies both the bus and PM core
> implementations. Convert the migor_ts driver over.
>
> Compile tested only.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Great, thank you!

Acked-by: Magnus Damm <damm@opensource.se>
