From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] input/keyboard: new driver for
	ADP5520 MFD PMICs
Date: Sat, 19 Sep 2009 23:30:44 -0700
Message-ID: <20090919233044.8361a912.akpm@linux-foundation.org>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1253211850-29309-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 17 Sep 2009 14:24:10 -0400 Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org> wrote:

> ...
> +struct adp5520_keys {
> +	struct input_dev *input;
> +	struct notifier_block notifier;
> +	struct device *master;
> +	unsigned short keycode[ADP5520_KEYMAPSIZE];

Where is ADP5520_KEYMAPSIZE defined?

I can find a single instance in the tree:

./arch/blackfin/mach-bf537/boards/stamp.c:static const unsigned short adp5520_keymap[ADP5520_KEYMAPSIZE] = {
	
is it runtime-generated or something?

> +};
> +
> +static void adp5520_keys_report_event(struct adp5520_keys *dev,
> +					unsigned short keymask, int value)
> +{
> +	int i;
> +
> +	for (i = 0; i < ADP5520_MAXKEYS; i++)

Where is ADP5520_MAXKEYS defined?

> +		if (keymask & (1 << i))
> +			input_report_key(dev->input, dev->keycode[i], value);

It seems odd that keycode is dimensioned with ADP5520_KEYMAPSIZE but
here we iterate up to ADP5520_MAXKEYS.

> +
> +	input_sync(dev->input);
> +}
> +
> ...
