From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] Input: pm8xxx-vib: sync device tree bindings doc
 with the driver
Date: Sat, 1 Apr 2017 09:54:09 -0700
Message-ID: <20170401165409.GE17130@dtor-ws>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
 <20170331161538.11657-2-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33380 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdDAQyM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 12:54:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so22651154pgf.0
        for <linux-input@vger.kernel.org>; Sat, 01 Apr 2017 09:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170331161538.11657-2-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com

On Fri, Mar 31, 2017 at 12:15:34PM -0400, Damien Riegel wrote:
> The driver uses a hardcoded value for the register, so the parameter set
> in the device tree is not actually used.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> index 4ed467b1e402..86ce95fc6cf8 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> @@ -12,7 +12,8 @@ PROPERTIES
>  - reg:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition: address of vibration control register
> +	Definition: address of vibration control register. This value is
> +		    actually ignored and hardcoded in the driver to value 0x4a

I do not think we need to commit that the value is hard coded, it is
implementation detail of current version of Linux driver, whereas DT
bindings should be independent of OS as much as reasonably possible.

Also, I think you can change the code to actually read and use it from
DT to support your other device use case.

Thanks.

-- 
Dmitry
