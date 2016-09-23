From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] input: touchscreen: add driver for Zeitec ZET6223
Date: Fri, 23 Sep 2016 08:41:20 -0500
Message-ID: <20160923134120.GA26818@rob-hp-laptop>
References: <20160913210826.30676-1-jelle@vdwaa.nl>
 <20160913210826.30676-2-jelle@vdwaa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33907 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030326AbcIWNlW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Sep 2016 09:41:22 -0400
Content-Disposition: inline
In-Reply-To: <20160913210826.30676-2-jelle@vdwaa.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 13, 2016 at 11:08:26PM +0200, Jelle van der Waa wrote:
> This is a basic driver for the Zeitec ZET6223 I2C touchscreen controllers.
> The driver does not support firmware loading, which is not required for
> all tablets which contain this chip.
> 
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
> ---
>  .../bindings/input/touchscreen/zet6223.txt         |  32 ++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |  11 ++
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/zet6223.c                | 207 +++++++++++++++++++++
>  5 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
>  create mode 100644 drivers/input/touchscreen/zet6223.c
