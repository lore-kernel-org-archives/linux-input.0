From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: input: touchscreen: sx8654: add
 sx8650 to comatibles
Date: Thu, 18 Oct 2018 15:35:36 -0500
Message-ID: <20181018203536.GA21783@bogus>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
 <20181017125116.20077-6-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017125116.20077-6-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

On Wed, 17 Oct 2018 14:51:13 +0200, Richard Leitner wrote:
> As the sx8650 is quite similar to the sx8654 support for it will be
> added in the driver. Therefore add it to the compatibles.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
