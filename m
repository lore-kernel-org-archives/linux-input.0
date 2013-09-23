From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 23 Sep 2013 17:25:58 +0200
Message-ID: <201309231725.58996.marex@denx.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dear Juergen Beisert,

> The following series replaces the current busy loop touchscreen
> implementation for i.MX28/i.MX23 SoCs by a fully interrupt driven
> implementation.
> 
> Since i.MX23 and i.MX28 silicon differs, the existing implementation can
> be used for the i.MX28 SoC only.
> 
> The first patch adds proper clock handling. Various platforms seems to
> disable the internal 2 kHz clock which is used by the LRADC delay units.
> 
> The next two patches of this series move the i.MX28 specific definitions
> out of the way. The forth patch simplifies the register access to make it
> easier to add the i.MX23 support. Then the i.MX23 specific definitions are
> added, also the code to distinguish both SoCs at run-time.
> Up to here the existing touchscreen driver will now run on an i.MX23 Soc as
> well.
> 
> When these i.MX SoCs are running from battery it seems not to be a good
> idea to run a busy loop to detect touches and their location. The 6th
> patch adds a fully interrupt driven implementation which makes use of the
> built-in delay and multiple sample features of the touchscreen controller.
> This will reduce the interrupt load to a minimum.
> 
> The remaining patches in this series just removes the existing busy loop
> implementation, add a proposal for devicetree binding and a reminder what
> has still to be done with the LRADC driver.
> 
> Changes since v5:
> 
> - add missing clock handling which prevents the delay units from work (this
>   should make it work on the MX28EVK and M28EVK as well)
> 
> Changes since v4:
> 
> - honor Jonathan's comments about function names
> - honor Dmitry's comments about workqueue canceling and interrupts
> - adding devicetree bindings proposal
> 
> Changes since v3:
> 
> - split adding register access functions and i.MX23 support into two
> patches
> 
> Changes since v2:
> 
> - useless debug output removed
> 
> Changes since v1:
> 
> - adding register access functions to make the existing code more readable
> - adding some functions to distinguish the SoCs at run-time to avoid
> if-else contructs whenever differences in the register layout between
> i.MX23 and i.MX28 must be handled
> 
> Comments are welcome.

On M28EVK:

Tested-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Thanks!

Best regards,
Marek Vasut
