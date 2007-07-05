From: Jason Uhlenkott <jasonuhl@jasonuhl.org>
Subject: Re: [PATCH] fujtisu application panel driver
Date: Wed, 4 Jul 2007 18:29:29 -0700
Message-ID: <20070705012929.GA4728@aurum.uhlenkott.net>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 02, 2007 at 11:17:24 -0700, Stephen Hemminger wrote:
> +static int __init apanel_init(void)
> +{
> +	void __iomem *bios;
> +	u8 devno;
> +	int found = 0;
> +
> +	if (!dmi_check_system(apanel_dmi_table)) {
> +		printk(KERN_WARNING "apanel: DMI information does not match\n");
> +		if (!force)
> +			return -ENODEV;
> +	}
> +	BUG_ON(!keymap);

If force=1 and there's no DMI match, we're guaranteed to pop this BUG_ON.


> +
> +			device_chip[devno] = (enum apanel_chip) chip;
> +			++found;
> +		}
> +	}
> +	iounmap(bios);

This isn't the address we got from ioremap (although it happens to
work, since iounmap internally masks it against PAGE_MASK).
