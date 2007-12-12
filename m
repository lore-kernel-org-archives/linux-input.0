From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fujitsu application panel driver
Date: Wed, 12 Dec 2007 09:10:31 -0500
Message-ID: <d120d5000712120610m30c054f5w596c29a1700211f@mail.gmail.com>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
	 <200709140130.59732.dtor@insightbb.com>
	 <20070916215516.2934abad@oldman.hemminger.net>
	 <200709161623.00286.dtor@insightbb.com>
	 <20071023125555.38d63567@shemminger-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754138AbXLLOKr@vger.kernel.org>
In-Reply-To: <20071023125555.38d63567@shemminger-laptop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Oct 23, 2007 2:55 PM, Stephen Hemminger
<shemminger@linux-foundation.org> wrote:
> +static void mail_led_set(struct led_classdev *led,
> +                        enum led_brightness value)
> +{
> +       struct apanel *ap = container_of(led, struct apanel, mail_led);
> +       if (value)
> +               ap->led_bits |= 0x8000;
> +       else
> +               ap->led_bits &= ~0x8000;
> +       ap->led_bits = value;
> +       schedule_work(&ap->led_work);
> +}

I was just about to apply the driver (and I folded in the other 4
patches you sent to me) but then I noticed the code above. It looks
like the conditional does not have any effect, ap->led_bits will be
overwritten with the raw value anyway. Please advise.

Thank you.

-- 
Dmitry
