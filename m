From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: input: add bindings document for
 ar1021_i2c driver
Date: Thu, 20 Apr 2017 10:42:15 -0700
Message-ID: <20170420174215.GA3730@dtor-ws>
References: <20170413204041.lqtqfc24vueo5fbj@rob-hp-laptop>
 <1492150298-15244-1-git-send-email-martin.kepplinger@ginzinger.com>
 <20170420134042.5uncs3ujetkt5erm@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35654 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966578AbdDTRmT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Apr 2017 13:42:19 -0400
Content-Disposition: inline
In-Reply-To: <20170420134042.5uncs3ujetkt5erm@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, christian.gmeiner@gmail.com, linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Apr 20, 2017 at 08:40:42AM -0500, Rob Herring wrote:
> On Fri, Apr 14, 2017 at 08:11:38AM +0200, Martin Kepplinger wrote:
> > Add a simple binding document describing the supported devices and the
> > I2C bus address.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > ---
> > 
> > revision history
> > ----------------
> > v2: fixed subject line and binding; thanks Rob Herring
> > v1: initial idea
> > 
> > 
> >  .../devicetree/bindings/input/touchscreen/ar1021.txt     | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
