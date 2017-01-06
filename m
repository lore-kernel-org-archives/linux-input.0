From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 4/5] input: tm2-touchkey: Add touchkey driver support
 for TM2
Date: Fri, 6 Jan 2017 14:16:05 +0200
Message-ID: <20170106121605.dvq6kaacqouqecqe@kozik-lap>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p26f09370d63026c8fbb64df049d2e2cfd@epcas5p2.samsung.com>
 <20170106114114.19321-5-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170106114114.19321-5-andi.shyti@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, Beomho Seo <beomho.seo@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 06, 2017 at 08:41:13PM +0900, Andi Shyti wrote:
> From: Jaechul Lee <jcsing.lee@samsung.com>
> 
> This patch adds support for the TM2 touch key and led
> functionality.
> 
> The driver interfaces with userspace through an input device and
> reports KEY_PHONE and KEY_BACK event types. LED brightness can be
> controlled by "/sys/class/leds/tm2-touchkey/brightness".
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig        |  11 ++
>  drivers/input/keyboard/Makefile       |   1 +
>  drivers/input/keyboard/tm2-touchkey.c | 280 ++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+)
>  create mode 100644 drivers/input/keyboard/tm2-touchkey.c
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
