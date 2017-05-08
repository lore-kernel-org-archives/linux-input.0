From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] input: edt-ft5x06: increase allowed data range for
 threshold parameter
Date: Mon, 8 May 2017 11:11:46 -0500
Message-ID: <20170508161146.vkmaohiesjd6e6vq@rob-hp-laptop>
References: <1493737259-26210-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33297 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdEHQLs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 12:11:48 -0400
Content-Disposition: inline
In-Reply-To: <1493737259-26210-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: dmitry.torokhov@gmail.com, simon.budig@kernelconcepts.de, daniel.wagener@kernelconcepts.de, mchehab@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Schoefegger Stefan <stefan.schoefegger@ginzinger.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

On Tue, May 02, 2017 at 05:00:59PM +0200, Martin Kepplinger wrote:
> The datasheet and application note does not mention an allowed range for
> the M09_REGISTER_THRESHOLD parameter. One of our customers needs to set
> lower values than 20 and they seem to work just fine on EDT EP0xx0M09 with
> T5x06 touch.
> 
> So, lacking a known lower limit, we increase the range for thresholds,
> and set the lower limit to 0. The documentation is updated accordingly.
> 
> Signed-off-by: Schoefegger Stefan <stefan.schoefegger@ginzinger.com>
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 2 +-
>  Documentation/input/devices/edt-ft5x06.rst                         | 2 +-
>  drivers/input/touchscreen/edt-ft5x06.c                             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
