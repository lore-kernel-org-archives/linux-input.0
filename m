From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: input: Add documentation for cyttsp5
Date: Mon, 21 Aug 2017 21:43:24 -0500
Message-ID: <20170822024324.dp6uiykqix6jvx2f@rob-hp-laptop>
References: <20170818062045.31280-1-mylene.josserand@free-electrons.com>
 <20170818062045.31280-3-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33055 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbdHVCn0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Aug 2017 22:43:26 -0400
Content-Disposition: inline
In-Reply-To: <20170818062045.31280-3-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

On Fri, Aug 18, 2017 at 08:20:45AM +0200, Mylène Josserand wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,keycodes" property can be used.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../bindings/input/touchscreen/cypress,cyttsp5.txt | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt

Acked-by: Rob Herring <robh@kernel.org>
