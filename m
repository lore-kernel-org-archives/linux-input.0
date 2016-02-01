From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] Input: tps6507x-ts - add binding for tps6507x-ts
Date: Mon, 1 Feb 2016 08:39:15 -0600
Message-ID: <20160201143915.GA9909@rob-hp-laptop>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
 <1454308130-12452-2-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60598 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418AbcBAOjX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Feb 2016 09:39:23 -0500
Content-Disposition: inline
In-Reply-To: <1454308130-12452-2-git-send-email-sushaanth.s@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 01, 2016 at 11:58:47AM +0530, Sushaanth Srirangapathi wrote:
> add binding information for tps6507x touchscreen input.
> 
> "ti,min-pressure" was added as TI specific binding because it
> was specific to tps6507x IP and not applicable or relevant for
> other touchscreen drivers.
> 
> Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/tps6507x.txt |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Seems like you would need other properties from the common touchscreen 
binding.

Acked-by: Rob Herring <robh@kernel.org>

