From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2 V3] dt: add Atmel Captouch bindings
Date: Wed, 18 May 2016 11:44:04 -0500
Message-ID: <20160518164404.GA31862@rob-hp-laptop>
References: <1463432094-146726-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48586 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbcERQoJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2016 12:44:09 -0400
Content-Disposition: inline
In-Reply-To: <1463432094-146726-1-git-send-email-grundler@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree <devicetree@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hung-yu Wu <hywu@google.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>

On Mon, May 16, 2016 at 01:54:53PM -0700, Grant Grundler wrote:
> From: Daniel Hung-yu Wu <hywu@google.com>
> 
> Add binding for Atmel Capacitive Touch Button device.
> 
> Signed-off-by: Daniel Hung-yu Wu <hywu@google.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
>  .../devicetree/bindings/input/atmel,captouch.txt   | 36 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt

Acked-by: Rob Herring <robh@kernel.org>
