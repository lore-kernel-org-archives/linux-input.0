From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6] input: add ADC resistor ladder driver
Date: Sun, 28 Aug 2016 19:33:28 -0500
Message-ID: <20160829003328.GA19426@rob-hp-laptop>
References: <1471954696-11897-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33761 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756089AbcH2Adb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 28 Aug 2016 20:33:31 -0400
Content-Disposition: inline
In-Reply-To: <1471954696-11897-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Aug 23, 2016 at 02:18:16PM +0200, Alexandre Belloni wrote:
> A common way of multiplexing buttons on a single input in cheap devices is
> to use a resistor ladder on an ADC. This driver supports that configuration
> by polling an ADC channel provided by IIO.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Changes in v6:
>  - switched to microvolts
> 
> Changes in v5:
>  - Dmitry's changes
>  - s/mvolt/millivolt/
> 
> 
>  .../devicetree/bindings/input/adc-keys.txt         |  49 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/keyboard/Kconfig                     |  15 ++
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/adc-keys.c                  | 210 +++++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
>  create mode 100644 drivers/input/keyboard/adc-keys.c
