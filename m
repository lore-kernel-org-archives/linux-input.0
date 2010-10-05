From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
Date: Tue, 5 Oct 2010 08:47:37 -0700
Message-ID: <20101005154737.GA19730@core.coreip.homeip.net>
References: <cover.1285933331.git.viresh.kumar@st.com>
 <584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56930 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab0JEPrt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 11:47:49 -0400
Content-Disposition: inline
In-Reply-To: <584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh KUMAR <viresh.kumar@st.com>
Cc: linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, a.zummo@towertech.it, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, shiraz.hashim@st.com, vipin.kumar@st.com, deepak.sikri@st.com, armando.visconti@st.com, vipulkumar.samar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com

Hi Rajeev,

On Fri, Oct 01, 2010 at 05:25:41PM +0530, Viresh KUMAR wrote:
> +
> +#define KEY_MASK	0xFF000000
> +#define KEY_VALUE	0x00FFFFFF
> +#define ROW_MASK	0xF0
> +#define COLUMN_MASK	0x0F
> +#define ROW_SHIFT	4
> +
> +struct spear_kbd {
> +	struct input_dev *input;
> +	void __iomem *io_base;		/* Keyboard Base Address */
> +	struct clk *clk;
> +	u8 last_key ;
> +	u8 last_event;
> +	int *keymap;
> +	int keymapsize;
> +};
> +/* TODO: Need to optimize this function */
> +static inline int get_key_value(struct spear_kbd *dev, int row, int col)
> +{
> +	int i, key;
> +
> +	key = KEY(row, col, 0);
> +	for (i = 0; i < dev->keymapsize; i++)
> +		if ((dev->keymap[i] & KEY_MASK) == key)
> +			return dev->keymap[i] & KEY_VALUE;
> +	return -ENOKEY;
> +}

As discussed previously I'd like to see the driver using as much of
matrix_keypad infrastructure as practical and also to see the initial
keypad copied into the spear_kbd structure to ensure that the board code
could be made const and bind/rebind of the device would restore the
original keymap.

Thanks.

-- 
Dmitry
