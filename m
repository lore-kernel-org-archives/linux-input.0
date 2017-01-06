From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v5 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Fri, 6 Jan 2017 11:02:20 -0300
Message-ID: <9e4fe0ee-0c33-9a5f-a954-b13d35b0113f@osg.samsung.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p19be459900aec43b2b9ea343cdaf0a2bf@epcas1p1.samsung.com>
 <20170106134350.32428-3-andi.shyti@samsung.com>
 <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi.shyti@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-input@vger.kernel.org

Hello Krzysztof,

On 01/06/2017 10:49 AM, Krzysztof Kozlowski wrote:
> On Fri, Jan 06, 2017 at 10:43:47PM +0900, Andi Shyti wrote:
>> Currently tm2e dts includes tm2 but there are some differences
>> between the two boards and tm2 has some properties that tm2e
>> doesn't have.
>>
>> That's why it's important to keep the two dts files independent
>> and put all the commonalities in a tm2-common.dtsi file.
>>
>> At the current status the only two differences between the two
>> dts files (besides the board name) are ldo31 and ldo38.
>>
>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---

[snip]

 > Beside that it is starting to look good. I didn't find anything else but
> maybe Javier's eagle eye will catch something.
>

I didn't find anything else, the patch looks good to me now.
 
> 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
