From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Thu, 13 Nov 2014 12:00:16 +0100
Message-ID: <1616597.6UJpl1xeSr@wuerfel>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com> <1763965.yCxTDubTPH@wuerfel> <4899804.1F6dNN1eJX@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57830 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932695AbaKMLAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2014 06:00:30 -0500
In-Reply-To: <4899804.1F6dNN1eJX@ws-stein>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

On Thursday 13 November 2014 11:52:48 Alexander Stein wrote:
> On Thursday 13 November 2014 11:47:13, Arnd Bergmann wrote:
> > Regarding your initial use case of testing interrupt polarity, would
> > you have been able to do the same thing by looking at the interrupt
> > count in /proc/interrupts?
> 
> This is only possible if some driver actually requests this interrupt, no?

Yes, I think that is correct, at least with sparseirq, which is now the
default. For interrupts that are mapped by the irqchip, you can look
up the number of spurious interrupts in /proc/irq/<nr>/spurious.

	Arnd
