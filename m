From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH v2 4/4] ARM: dts: sun7i: Add lradc node
Date: Wed, 22 Oct 2014 10:46:27 +0200
Message-ID: <54476EE3.6060401@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com> <1413879890-7254-5-git-send-email-hdegoede@redhat.com> <20141022083802.GE7893@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORB265TWRAKGQEJUJWVZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141022083802.GE7893@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 10/22/2014 10:38 AM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Tue, Oct 21, 2014 at 10:24:50AM +0200, Hans de Goede wrote:
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 48 +++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun7i-a20.dtsi                |  7 ++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> index 9d669cdf..85e7194 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> @@ -14,6 +14,7 @@
>>  /dts-v1/;
>>  /include/ "sun7i-a20.dtsi"
>>  /include/ "sunxi-common-regulators.dtsi"
>> +#include <dt-bindings/input/input.h>
> 
> I'm just wondering... Weren't we supposed to switch all includes to
> the preprocessor syntax in such a case?

I've just checked other in tree users of dt-bindings/input/input.h and you
seem to be right, I will fix this for the next version.

Regards,

Hans
