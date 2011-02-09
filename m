From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: drivers/input/touchscreen/ads7846.c:959: error: 'GPIOF_DIR_IN'
 undeclared
Date: Wed, 09 Feb 2011 09:34:55 +0200
Message-ID: <4D52439F.9090505@compulab.co.il>
References: <AANLkTim2706Negrvd-ektbNMLwucM9M0icphb_uFY_9D@mail.gmail.com> <20110208211035.GC16527@core.coreip.homeip.net> <20110208212046.GA29410@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:57365 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056Ab1BIHfG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Feb 2011 02:35:06 -0500
In-Reply-To: <20110208212046.GA29410@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sourav Poddar <sourav.poddar@ti.com>, Linux-Next <linux-next@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/08/11 23:20, Wolfram Sang wrote:

> On Tue, Feb 08, 2011 at 01:10:36PM -0800, Dmitry Torokhov wrote:
>
>> Crap, sorry about that, I'll fix it up tonight.
> I had the same issue while working on some other gpio-cleanup.
> I am just about to finish a patch.

This was pretty obvious and I had a thought that this will happen,
but failed in sharing my thoughts with you back then.
May be because of too much talking around it... Sorry... :(

-- 
Regards,
Igor.

