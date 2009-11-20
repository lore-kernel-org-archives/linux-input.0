From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: gpio-keys: allow drivers to specify whether
	IRQ can be shared
Date: Fri, 20 Nov 2009 00:38:17 -0800
Message-ID: <20091120083817.GB3009@core.coreip.homeip.net>
References: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com> <dacbc701ebdd15c48ebb32920bf70fd42aa14baa.1258614931.git.ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:46830 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbZKTIiP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 03:38:15 -0500
Received: by pwi3 with SMTP id 3so1958354pwi.21
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2009 00:38:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <dacbc701ebdd15c48ebb32920bf70fd42aa14baa.1258614931.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Mika,

On Thu, Nov 19, 2009 at 09:23:45AM +0200, Mika Westerberg wrote:
> Added new field to struct gpio_keys_button: exclusive_irq which can
> be used to specify whether driver wants to have exclusive access to
> IRQ or can it be shared. By default IRQs for gpio-keys are shareable.
> 

I think the idea makes sense with one exception - why limit just to
sharing and not let platform specify the exact IRQ flags it needs,
defaulting to IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_SHARED?

-- 
Dmitry
