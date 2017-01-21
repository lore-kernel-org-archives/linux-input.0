From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: gpio-keys - Add support for setkeycode
Date: Sat, 21 Jan 2017 11:49:09 -0800
Message-ID: <20170121194909.GE36944@dtor-ws>
References: <20170109175700.12811-1-hdegoede@redhat.com>
 <20170109175700.12811-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36613 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdAUTtp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 14:49:45 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so7490131pfo.3
        for <linux-input@vger.kernel.org>; Sat, 21 Jan 2017 11:49:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170109175700.12811-2-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Mon, Jan 09, 2017 at 06:57:00PM +0100, Hans de Goede wrote:
> gpio-keys input devices created by the soc_button_array driver are
> configured with key-codes based on ACPI provided information.
> 
> Unfortunately on some tablets this info is wrong, and we need to have
> a quirk to fix things up.
> 
> Add support for input_setkeycode to the gpio-keys driver, so that
> the existing udev hwdb mechanism can be used to fix things up on these
> tablets.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied with minor edits:

>  
> +	ddata->keymap = devm_kzalloc(dev,
> +				     pdata->nbuttons * sizeof(unsigned short),
> +				     GFP_KERNEL);

Changed to devm_kcalloc().

> +		bdata->code = &ddata->keymap[i];

Pushed into gpio_keys_setup_key().

Thanks.

-- 
Dmitry
