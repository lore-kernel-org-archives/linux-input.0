From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 3/3] HID: i2c-hid: Add support for ACPI GPIO interrupts
Date: Tue, 24 Feb 2015 22:27:05 +0100
Message-ID: <20150224222705.82e955632f6677067ab1fa46@ao2.it>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
	<1424699565-138045-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:41287 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbbBXV1Z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 16:27:25 -0500
In-Reply-To: <1424699565-138045-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 Feb 2015 15:52:45 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> The HID over I2C specification allows to have the interrupt for a HID
> device to be GPIO instead of directly connected to the IO-APIC.
> 
> Add support for this so that when the driver does not find proper interrupt
> number from the I2C client structure we check if it has ACPI GpioInt()
> resource listed in _CRS. If it is found we convert it to an interrupt
> number and use it instead.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 68 +++++++++++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 404ccde49acd..c6cad72f6296 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -37,6 +37,7 @@
>  #include <linux/mutex.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <linux/i2c/i2c-hid.h>
>  
> @@ -144,6 +145,8 @@ struct i2c_hid {
>  	unsigned long		flags;		/* device flags */
>  
>  	wait_queue_head_t	wait;		/* For waiting the interrupt */
> +	struct gpio_desc	*desc;

Just curious: can't the gpio_desc be local in the probe function?
I take that the gpio descriptor needs to be alive even after the irq
number has been derived from it in order for the gpio chip to remember
that the gpio has been requested by someone. Is that correct?

Thanks,
   Antonio

[...]

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
