From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Thu, 02 Jan 2014 10:37:47 +0100
Message-ID: <52C5336B.9010903@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com> <1388604610-20380-2-git-send-email-hdegoede@redhat.com> <20140101205603.GA1141@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB4PGSSLAKGQE3FKYG4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140101205603.GA1141-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 01/01/2014 09:56 PM, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Wed, Jan 01, 2014 at 08:30:07PM +0100, Hans de Goede wrote:
>> +Required properties:
>> + - compatible: "allwinner,sun4i-lradc-keys"
>> + - reg: mmio address range of the chip
>> + - interrupts: interrupt to which the chip is connected
>> + - allwinner,chan0-step: step in mV between keys must be 150 or 200
>> + - allwinner,chan0-keycodes: array of include/uapi/linux/input.h KEY_ codes
>
> I think this should be "linux,chan0-keycodes".

Right, because the codes are Linux specific, will fix in v2.

Regards,

Hans
