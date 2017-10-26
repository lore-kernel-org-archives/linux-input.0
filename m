From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v5 5/6] input: Add MediaTek PMIC keys support
Date: Thu, 26 Oct 2017 17:27:44 +0900
Message-ID: <20171026082744.GA29398@gangnam>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
 <CGME20170927104421epcas2p190d03c1c6759f394debfc01b23641ece@epcas2p1.samsung.com>
 <1506509048-19032-6-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-disposition: inline
In-reply-to: <1506509048-19032-6-git-send-email-chen.zhong@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alessandro Zummo <a.zummo@towertech.it>, Jaechul Lee <jcsing.lee@samsung.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Eddie Huang <eddie.huang@mediatek.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Wed, Sep 27, 2017 at 06:44:07PM +0800, Chen Zhong wrote:
> This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> interrupts including pwrkey and homekey, also add setting for
> long press key shutdown behavior.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>

if you want you can add:

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
