From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Fix a typo in file input-reset.txt
Date: Mon, 12 Nov 2018 11:27:49 -0800
Message-ID: <20181112192749.GD192687@dtor-ws>
References: <20181107055819.7527-1-miyatsu@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107055819.7527-1-miyatsu@qq.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ding Tao <miyatsu@qq.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 07, 2018 at 05:58:19AM +0000, Ding Tao wrote:
> Replace sysrq-reset-seq with keyset.
> 
> Signed-off-by: Ding Tao <miyatsu@qq.com>

Applied, thank you.

> ---
>  Documentation/devicetree/bindings/input/input-reset.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/input-reset.txt b/Documentation/devicetree/bindings/input/input-reset.txt
> index 2bb2626fdb78..1ca6cc5ebf8e 100644
> --- a/Documentation/devicetree/bindings/input/input-reset.txt
> +++ b/Documentation/devicetree/bindings/input/input-reset.txt
> @@ -12,7 +12,7 @@ The /chosen node should contain a 'linux,sysrq-reset-seq' child node to define
>  a set of keys.
>  
>  Required property:
> -sysrq-reset-seq: array of Linux keycodes, one keycode per cell.
> +keyset: array of Linux keycodes, one keycode per cell.
>  
>  Optional property:
>  timeout-ms: duration keys must be pressed together in milliseconds before
> -- 
> 2.17.1
> 

-- 
Dmitry
