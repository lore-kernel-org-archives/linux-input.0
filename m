From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: input: touchscreen: sx8654: add
 compatible models
Date: Thu, 18 Oct 2018 15:35:13 -0500
Message-ID: <20181018203513.GA21155@bogus>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
 <20181017125116.20077-4-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017125116.20077-4-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

On Wed, 17 Oct 2018 14:51:11 +0200, Richard Leitner wrote:
> As the sx865[456] share the same datasheet and differ only in the
> presence of a "capacitive proximity detection circuit" and a "haptics
> motor driver for LRA/ERM" add them to the compatbiles. As the driver
> doesn't implement these features it should be no problem.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
