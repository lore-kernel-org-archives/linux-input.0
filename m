From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/5] input: sun4i-ts: Add support for
 temperature sensor
Date: Tue, 31 Dec 2013 16:02:32 +0100
Message-ID: <52C2DC88.3060902@redhat.com>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com> <1388156399-29677-3-git-send-email-hdegoede@redhat.com> <20131228011304.GB14188@core.coreip.homeip.net> <20131231130006.GW3144@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBEVZROLAKGQEY2AB6YY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131231130006.GW3144@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 12/31/2013 02:00 PM, Maxime Ripard wrote:
> Hi,
>
> On Fri, Dec 27, 2013 at 05:13:04PM -0800, Dmitry Torokhov wrote:
>> On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
>>>
>>> +Optional properties:
>>> + - ts-attached: boolean set this to tell the driver that an actual touchscreen
>>> +		is attached and that it should register an input device,
>>> +		without this it only registers the builtin temperate sensor
>>
>> I believe the guidance is to avoid describing kernel behavior in DT
>> property so I think it should say:
>>
>>   - ts-attached: boolean indicating that an actual touchscreen is
>> 		attached to the controller.
>
> Custom properties are also supposed to be prefixed by the vendor prefix.

Will fix for v3.

Regards,

Hans
