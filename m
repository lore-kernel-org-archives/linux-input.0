From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: add bindings document for
 ar1021_i2c driver
Date: Thu, 20 Apr 2017 08:40:42 -0500
Message-ID: <20170420134042.5uncs3ujetkt5erm@rob-hp-laptop>
References: <20170413204041.lqtqfc24vueo5fbj@rob-hp-laptop>
 <1492150298-15244-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36575 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945970AbdDTNkp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Apr 2017 09:40:45 -0400
Content-Disposition: inline
In-Reply-To: <1492150298-15244-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: dmitry.torokhov@gmail.com, christian.gmeiner@gmail.com, linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Apr 14, 2017 at 08:11:38AM +0200, Martin Kepplinger wrote:
> Add a simple binding document describing the supported devices and the
> I2C bus address.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> revision history
> ----------------
> v2: fixed subject line and binding; thanks Rob Herring
> v1: initial idea
> 
> 
>  .../devicetree/bindings/input/touchscreen/ar1021.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ar1021.txt

Acked-by: Rob Herring <robh@kernel.org>
