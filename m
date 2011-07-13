From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: cy8ctmg110_ts - set reset_pin and irq_pin from
 platform data
Date: Wed, 13 Jul 2011 14:20:55 +0100
Message-ID: <20110713142055.3036c62d@lxorguk.ukuu.org.uk>
References: <1310562419.5753.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53369 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753322Ab1GMNSQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2011 09:18:16 -0400
In-Reply-To: <1310562419.5753.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Samuli Konttila <samuli.konttila@aavamobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org

On Wed, 13 Jul 2011 21:06:59 +0800
Axel Lin <axel.lin@gmail.com> wrote:

> The implementation in cy8ctmg110_probe() does not properly set reset_pin
> and irq_pin from platform data. Let's fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> Current implementation returns -ENODEV if no pdata available.
> But it does not use the information from pdata.
> I think currently the driver does not work because both ts->reset_pin and ts->irq_pin are 0, then gpio_request with ts->irq_pin will fail.
> 
> Just found this bug while reading the code.
> I don't have this hardware. I appreciate if someone can test it.

Looks right, but I'm likewise unable to test it as I no longer have
access to a device using it.

Alan
