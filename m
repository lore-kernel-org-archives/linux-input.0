From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] input: pmic8xxx-pwrkey: Add support
 for pm8018 pwrkey
Date: Sun, 26 Jun 2016 15:06:30 +0200
Message-ID: <576FD356.70002@baylibre.com>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-3-git-send-email-narmstrong@baylibre.com>
 <20160624220748.GB11719@dtor-ws> <576E41FC.1080102@baylibre.com>
 <20160625155349.GD17812@dtor-ws>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDAYD2P3QYGRBWFGX65QKGQE4EL2FYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160625155349.GD17812@dtor-ws>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/25/2016 05:53 PM, Dmitry Torokhov wrote:
> On Sat, Jun 25, 2016 at 10:34:04AM +0200, Neil Armstrong wrote:
>> On 06/25/2016 12:07 AM, Dmitry Torokhov wrote:
>>> On Fri, Jun 24, 2016 at 11:18:04AM +0200, Neil Armstrong wrote:
>>>> In order to support pwrkey for Qualcomm MDM9615 SoC, add support
>>>> for the pm8018 pwrkey in pmic8xxx-pwrkey.
>>>>
>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>
>>> NAK.
>>
>> Hi Dmitry,
>>
>> Actually, the new compatible string make sense, because the driver is compatible with the
>> "pm8018" pwrkey but from a system point of view, it's not a pm8921 pwrkey, hence the new
>> compatible string.
> 
> A lot of systems note this fact in DTS, but not require driver changes,
> by specifying several compatible strings:
> 
> 	compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
> 	compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
> 	compatible = "rockchip,rk3036-timer", "rockchip,rk3288-timer";

Sure, your point is valid.
But here, the situation is quite different, the question is about confidence.
>From the system point of view, I'm 100% sure there is a pm8010-pwrkey variant here, but
I`m not convinced at all how it is similar from the 8921 version.
>From the software point of view, I'm 80% sure the *actual* driver in it current form
somehow works for the pm8018-pwrkey, not more.
If somehow the driver is updated to support a 8921 feature that is not supported by the
8018 version, it will rely on the compatible string to make this a smart move.
Since I do not have the pm8018 datasheet and the 8921 either, I cannot statue on this,
So the smartest move from my side is to actually have a different compatible string
to avoid future blocking situations.

>>
>> Rob Herring was very clear with me with this policy, and it will simplify further driver
> 
> Could I get a pointer to this discussion so I can educate myself better
> about DT policies?

I had quite a lot of comments on the OXNAS support push (started here https://lkml.org/lkml/2016/3/3/495) were
the policy was to narrow the new compatible strings to a SoC specific naming.
For the qcom driver, the strings the already compliant and why not continue with the pm8018 ?

>> architecture change since it will not imply devicetree changes anymore.
> 
> Would we need the driver changes? What are the differences in power key
> functionality between 8018 and 8921?

You raise the biggest question, I do not know, so why should we say the pm8018-pwrkey /is/ compatible with pm8921-pwronly only by looking existing driver ?

>>
>> My point of view is that the devicetree describes the hardware and need to have SoC specific
>> compatible string since it describes the actual silicon, and drivers must make sure to handle
>> all the SoC or family variants using the compatible string and the match data.
> 
> No, the compatible string means that the hardware is *compatible* with
> something. It does not mean that we need to adjust driver every time a
> company pumps out a new package including said hardware.

It was something that I questionned myself about, but it seems the maintainers agrees quite easily to accept these compatible adding patches
like the USB Ids or PCI ids patches.

Regards,
Neil

> Thanks.
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
