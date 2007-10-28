From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Fujitsu application panel driver
Date: Sun, 28 Oct 2007 01:30:15 -0400
Message-ID: <200710280130.16002.dtor@insightbb.com>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net> <200709161623.00286.dtor@insightbb.com> <20071023125555.38d63567@shemminger-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071023125555.38d63567@shemminger-laptop>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Tuesday 23 October 2007 15:55, Stephen Hemminger wrote:
> +
> +static int apanel_setkeycode(struct input_dev *idev, int scancode, int keycode)
> +{
> +	struct apanel *ap = idev->private;
> +
> +	if (keycode < 0 || keycode > KEY_MAX)
> +		return -EINVAL;
> +
> +	if (scancode < 0 || scancode >= MAX_PANEL_KEYS)
> +		return -EINVAL;

scancode >= idev->keycodemax is prbably better here - we don't want to
allow setting keycode for unsupported buttons.

> +
> +	clear_bit(ap->keymap[scancode], idev->keybit);

This will not work if one has same code assigned to 2 buttons. Pretty
degenerate case, I know...

> +	ap->keymap[scancode] = keycode;
> +	set_bit(keycode, idev->keybit);
> +	return 0;
> +}

-- 
Dmitry
