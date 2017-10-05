From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5 v2] input: mouse: Add DT bindings for GPIO mice
Date: Thu, 5 Oct 2017 15:23:06 -0500
Message-ID: <20171005202306.s43u3wfmi66jcpq2@rob-hp-laptop>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
 <20170925163430.22397-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45895 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdJEUXJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 16:23:09 -0400
Content-Disposition: inline
In-Reply-To: <20170925163430.22397-3-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, devicetree@vger.kernel.org

On Mon, Sep 25, 2017 at 06:34:28PM +0200, Linus Walleij wrote:
> This adds DT bindings for simple mice attached to GPIO lines.
> As the properties are very general and pertains to all mice I
> can think of, we use very generic names for the 4-7 GPIO lines,
> "up", "down" etc.
> 
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Collect Hand-Christian's ACK
> - Uses 5-7 lines rather than 4-7 lines
> - Add suffix "-ms" to the scan interval property
> - Fix compatible string in the example
> ---
>  .../devicetree/bindings/input/gpio-mouse.txt       | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt

Acked-by: Rob Herring <robh@kernel.org>
