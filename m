From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] touchscreen: sun4i-ts: A10 (sun4i) has
 double the temperature precision
Date: Tue, 17 Jun 2014 08:31:27 +0200
Message-ID: <539FE0BF.7030708@redhat.com>
References: <1402943069-19420-1-git-send-email-hdegoede@redhat.com> <1402943069-19420-2-git-send-email-hdegoede@redhat.com> <20140616213048.GA422@core.coreip.homeip.net>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBSGB76OAKGQEPVDD4PA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140616213048.GA422-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tong Zhang <lovewilliam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 06/16/2014 11:30 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Mon, Jun 16, 2014 at 08:24:28PM +0200, Hans de Goede wrote:
>> Testing has revealed that the temperature in the rtp controller of the A10
>> (sun4i) SoC has a resolution of 50 milli degrees / step, where as the
>> A13 (sun5i) and later models have 100 milli degrees / step.
>>
>> Add a new sun5i-a13-ts compatible to differentiate the newer models and
>> set the resolution based on the compatible string.
>>
>> This fixes the temperature reported on the A10 being twice as high as expected.
> 
> Should we maybe add explicit temperature steps property so that we won;t
> need to patch again if they decided to change resolution again?

I can understand where your coming from, but in general the rule for
devicetree bindings is to not add properties for things which are purely
dependent on the SoC generation. Those must be deferred from the compatible
string.

Regards,

Hans
