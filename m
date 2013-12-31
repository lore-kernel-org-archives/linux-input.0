From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/5] input: sun4i-ts: Add support for
 temperature sensor
Date: Tue, 31 Dec 2013 12:17:46 +0100
Message-ID: <52C2A7DA.20203@redhat.com>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com> <1388156399-29677-3-git-send-email-hdegoede@redhat.com> <20131228011304.GB14188@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBYOPRKLAKGQEMGFROEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131228011304.GB14188-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 12/28/2013 02:13 AM, Dmitry Torokhov wrote:
> On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
>>
>> +Optional properties:
>> + - ts-attached: boolean set this to tell the driver that an actual touchscreen
>> +		is attached and that it should register an input device,
>> +		without this it only registers the builtin temperate sensor
>
> I believe the guidance is to avoid describing kernel behavior in DT
> property so I think it should say:
>
>   - ts-attached: boolean indicating that an actual touchscreen is
> 		attached to the controller.

Will also fix for v3.

Regards,

Hans
