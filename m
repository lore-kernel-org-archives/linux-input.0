From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Fri, 4 Dec 2009 15:06:21 +0100
Message-ID: <20091204150621.16e4036e@destiny.ordissimo>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
	<20091204061158.28288.17664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091204061158.28288.17664.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 03 Dec 2009 22:11:58 -0800, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote :

> +
> +/**
> + * sparse_keymap_report_event - report event corresponding to given key entry
You meant _report_entry ?

> + * @dev: Input device for which event should be reported
> + * @ke: key entry describing event
> + * @value: Value that should be reported (ignored by %KE_SW entries)
> + * @autorelease: Signals whether release event should be emitted for %KE_KEY
> + *	entries right after reporting press event, ignored by all other
> + *	entries
> + *
> + * This function is used to report input event described by given
> + * &struct key_entry.
> + */
> +void sparse_keymap_report_entry(struct input_dev *dev, const struct key_entry *ke,
> +				unsigned int value, bool autorelease)
> +{
> +	switch (ke->type) {
> +	case KE_KEY:
> +		input_report_key(dev, ke->keycode, value);
> +		input_sync(dev);
> +		if (value && autorelease) {
> +			input_report_key(dev, ke->keycode, 0);
> +			input_sync(dev);
> +		}
> +		break;
> +
> +	case KE_SW:
> +		value = ke->sw.value;
> +		/* fall through */
> +
> +	case KE_VSW:
> +		input_report_switch(dev, ke->sw.code, value);
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL(sparse_keymap_report_entry);
> +
> +/**
> + * sparse_keymap_report_event - report event corresponding to given scancode
> + * @dev: Input device using sparse keymap
> + * @code: Scan code
> + * @value: Value that should be reported (ignored by %KE_SW entries)
> + * @autorelease: Signals whether release event should be emitted for %KE_KEY
> + *	entries right after reporting press event, ignored by all other
> + *	entries
> + *
> + * This function is used to perform lookup in an input device using sparse
> + * keymap and report corresponding event. Returns %true if lookup was
> + * successful and %false otherwise.
> + */
> +bool sparse_keymap_report_event(struct input_dev *dev, unsigned int code,
> +				unsigned int value, bool autorelease)
> +{
> +	const struct key_entry *ke =
> +		sparse_keymap_entry_from_scancode(dev, code);
> +
> +	if (ke) {
> +		sparse_keymap_report_entry(dev, ke, value, autorelease);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(sparse_keymap_report_event);
> +

