From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] Input: add touchscreen bindings for TS-4800
Date: Thu, 10 Dec 2015 21:39:54 -0600
Message-ID: <20151211033954.GA638@rob-hp-laptop>
References: <1449763872-572-1-git-send-email-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42283 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbbLKDj7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 22:39:59 -0500
Content-Disposition: inline
In-Reply-To: <1449763872-572-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel@savoirfairelinux.com

On Thu, Dec 10, 2015 at 11:11:11AM -0500, Damien Riegel wrote:
> Add bindings for the TS-4800 touchscreen.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Generally, there are other properties needed from the common touchscreen 
binding. You don't need any of those here?

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/input/touchscreen/ts4800-ts.txt      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
> new file mode 100644
> index 0000000..63282fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
> @@ -0,0 +1,12 @@
> +* TS-4800 Touchscreen bindings
> +
> +Required properties:
> +- compatible: must be "technologic,ts4800-ts"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- syscon: phandle / integers array that points to the syscon node which
> +          describes the FPGA's syscon registers.
> +          - phandle to FPGA's syscon
> +          - offset to the touchscreen register
> +          - offset to the touchscreen enable bit
> +
> -- 
> 2.5.0
> 
