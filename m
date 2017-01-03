From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Tue, 3 Jan 2017 11:57:37 -0300
Message-ID: <d7bfdbc5-cb9d-81ca-2300-a035098e5884@osg.samsung.com>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung>
 <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
 <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ@mail.gmail.com>
 <20170103115530.zhjwn7bzmqmumy23@gangnam.samsung>
 <ff876454-b49f-3d63-d76e-012dd303b0e7@osg.samsung.com>
 <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi@etezian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, beomho.seo@samsung.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, galaxyra@gmail.com, Chanwoo Choi <cwchoi00@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hello Andi,

On 01/03/2017 11:40 AM, Andi Shyti wrote:
> Hi,
> 
>> FWIW, I also agree with Chanwoo that the difference is too small to
>> need a common .dtsi file.
> 
> in principle I don't like "switching on and off" properties by
> overwriting them with "status = disable", unless it's really

This is a very good point. It would had been different if it was the
opposite and tm2e had to enable the device node, but disabling it is
indeed more confusing.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
