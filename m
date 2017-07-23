From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] HID: rmi: Make sure the HID device is opened on resume
Date: Sun, 23 Jul 2017 12:54:40 +0300
Message-ID: <CAHp75VcZxAEr+ARw0U1nxtXR1fgWrQ1w=dhpZbm+DRiDbwajYA@mail.gmail.com>
References: <20170723011509.23651-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36615 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdGWJym (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 23 Jul 2017 05:54:42 -0400
In-Reply-To: <20170723011509.23651-1-lyude@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lyude <lyude@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jul 23, 2017 at 4:15 AM, Lyude <lyude@redhat.com> wrote:

> So, call hid_hw_open() in rmi_post_resume() so we make sure that the
> device is alive before we try talking to it.
>
> This fixes RMI device suspend/resume over HID.

> -       int ret;
> +       int ret = 0;

What's the point?

>
>         if (!(data->device_flags & RMI_DEVICE))
>                 return 0;
>
> -       ret = rmi_reset_attn_mode(hdev);
> +       /* Make sure the HID device is ready to receive events */
> +       ret = hid_hw_open(hdev);
>         if (ret)
>                 return ret;

-- 
With Best Regards,
Andy Shevchenko
