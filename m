From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
Date: Sun, 28 Aug 2016 19:37:25 -0500
Message-ID: <20160829003725.GA20749@rob-hp-laptop>
References: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36734 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756310AbcH2Ah1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 28 Aug 2016 20:37:27 -0400
Content-Disposition: inline
In-Reply-To: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

On Tue, Aug 23, 2016 at 05:04:48PM +0200, Hans de Goede wrote:
> The driver has supported touchscreen-fw-name to specify the firmware to
> load since day 0, but this was omitted from the binding, document this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt | 1 +
>  1 file changed, 1 insertion(+)

I'd really like to deprecate in favor of a standard property name. We've 
somewhat agreed on 'firmware-name' though there is no common binding doc 
yet. But given this is in use:

Acked-by: Rob Herring <robh@kernel.org>
