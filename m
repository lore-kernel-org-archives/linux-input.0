From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH resend v2] input: Add new sun4i-lradc-keys driver
Date: Thu, 18 Dec 2014 09:42:14 +0100
Message-ID: <54929366.7050002@redhat.com>
References: <1418827411-13265-1-git-send-email-hdegoede@redhat.com> <1418827411-13265-2-git-send-email-hdegoede@redhat.com> <1918972.jFlKNuYrbH@dtor-glaptop>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORB3VGZKSAKGQEJRM5VTY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1918972.jFlKNuYrbH@dtor-glaptop>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 17-12-14 18:32, Dmitry Torokhov wrote:
> On Wednesday, December 17, 2014 03:43:31 PM Hans de Goede wrote:
>> +       /*
>> +        * lradc supports only one keypress at a time, release does not give
>> +        * any info as to which key was released, so we cache the keycode.
>> +        */
>> +       if ((ints & CHAN0_KEYDOWN_IRQ) && lradc->chan0_keycode == 0) {
>> +               val = readl(lradc->base + LRADC_DATA0) & 0x3f;
>> +               voltage = val * lradc->vref / 63;
>> +
>> +               for (i = 0; i < lradc->chan0_map_count; i++) {
>> +                       diff = abs(lradc->chan0_map[i].voltage - voltage);
>> +                       if (diff < closest) {
>> +                               closest = diff;
>> +                               keycode = lradc->chan0_map[i].keycode;
>> +                       }
>> +               }
>> +
>> +               lradc->chan0_keycode = keycode;
>> +               input_report_key(lradc->input, lradc->chan0_keycode, 1);
>> +       }
>> +
>> +       if (ints & CHAN0_KEYUP_IRQ) {
>> +               input_report_key(lradc->input, lradc->chan0_keycode, 0);
>> +               lradc->chan0_keycode = 0;
>> +       }
>
> Can release and press be reported simultaneously? Should we process release
> first?

Good question, I guess if we are somehow really slow with processing the interrupt
that this may happen. So I'll do a v3 swapping the 2.

Regards,

Hans
