From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Wed, 12 Nov 2014 17:04:57 +0100
Message-ID: <3325183.d9PtLzFMKy@wuerfel>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60309 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbaKLQFD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 11:05:03 -0500
In-Reply-To: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Wednesday 12 November 2014 17:02:56 Alexander Stein wrote:
> This features already exists for board config setups. Add support for
> device tree based systems.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Please note: Due to current lack of hardware I could not test it yet. V2
> includes the changes proposed by Dmitry.
> 
> Changes in v2:
> * Added device tree bindings
> * IRQ is only parsed and mapped when there is no "gpios" property
> 

Can you list one or more examples in the patch description?
Are these systems that don't expose the GPIO controller with a
standalone driver, or systems that really actually connect the
buttons to an interrupt pin?

	Arnd
