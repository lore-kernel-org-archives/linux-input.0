From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 13/14] input: touchscreen: sama5d2_rts: SAMA5D2 Resistive
 touchscreen driver
Date: Tue, 26 Dec 2017 16:41:35 -0600
Message-ID: <20171226224135.qzh45mnl3a7ghbfs@rob-hp-laptop>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-14-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513955241-10985-14-git-send-email-eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 22, 2017 at 05:07:20PM +0200, Eugen Hristev wrote:
> This is the implementation of the Microchip SAMA5D2 SOC resistive
> touchscreen driver.
> The driver registers an input device and connects to the give IIO device
> from devicetree. It requires an IIO trigger (acting as a consumer) and
> three IIO channels : one for X position, one for Y position and one
> for pressure.
> It the reports the values to the input subsystem.
> 
> Some parts of this driver are based on the initial original work by
> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy

This doesn't appear to have anything specific to SAMA5D2 SoC, but is 
rather just a generic ADC (IIO based) resistive touchscreen driver.

Perhaps the binding can also be just an "adc-resistive-touchscreen".

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
