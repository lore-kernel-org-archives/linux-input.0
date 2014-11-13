From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for
 interrupt only keys
Date: Thu, 13 Nov 2014 16:32:59 +0530
Message-ID: <54648FE3.4080109@nvidia.com>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com> <1763965.yCxTDubTPH@wuerfel> <4899804.1F6dNN1eJX@ws-stein> <1616597.6UJpl1xeSr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4965 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642AbaKMLFV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2014 06:05:21 -0500
In-Reply-To: <1616597.6UJpl1xeSr@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org

On Thursday 13 November 2014 04:30 PM, Arnd Bergmann wrote:
> On Thursday 13 November 2014 11:52:48 Alexander Stein wrote:
>> On Thursday 13 November 2014 11:47:13, Arnd Bergmann wrote:
>>> Regarding your initial use case of testing interrupt polarity, would
>>> you have been able to do the same thing by looking at the interrupt
>>> count in /proc/interrupts?
>> This is only possible if some driver actually requests this interrupt, no?
> Yes, I think that is correct, at least with sparseirq, which is now the
> default. For interrupts that are mapped by the irqchip, you can look
> up the number of spurious interrupts in /proc/irq/<nr>/spurious.
>
>
yes, I came across multiple PMIC(TPS65910, MAXIM, Ricoh)  module which 
generates interrupt when their On-key pin get toggle. Key is connected 
with this pin of PMIC and for on-key driver, we are using the gpio-keys 
driver by passing interrupt number instead of complete new driver.

