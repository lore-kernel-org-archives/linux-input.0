From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] input: Add support for the tm2 touchkey device driver
Date: Wed, 4 Jan 2017 08:15:00 -0600
Message-ID: <20170104141500.nhnycny3gbjp6e2l@rob-hp-laptop>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075733epcas5p47dff8d21854938b2439c9843d91bc301@epcas5p4.samsung.com>
 <1483430237-26823-2-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483430237-26823-2-git-send-email-jcsing.lee@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaechul Lee <jcsing.lee@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 03, 2017 at 04:57:14PM +0900, Jaechul Lee wrote:
> This patch adds the binding description of the tm2 touchkey
> device driver.
> 
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> ---
>  .../bindings/input/samsung,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt

Acked-by: Rob Herring <robh@kernel.org>
