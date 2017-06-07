From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/8] HID: hiddev: use hid_hw_power instead of usbhid_get/put_power
Date: Wed, 7 Jun 2017 11:40:17 +0300
Message-ID: <CAHp75VeTy7Ap+53YHsjAdYbQE_R54AFrRxog9jqwZbWufEty+g@mail.gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com> <20170607065938.33332-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35054 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdFGIkS (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 04:40:18 -0400
In-Reply-To: <20170607065938.33332-3-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Jun 7, 2017 at 9:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Instead of calling into usbhid code directly, let's use the standard
> accessors for the transport HID drivers, and stop clobbering their error
> codes with -EIO.
>
> This also allows us to remove usbhid_get/put_power(), leaving only
> usbhid_power().

>                 break;
> +
>         case PM_HINT_NORMAL:

>         }
> +
>         return r;

I think you can drop above changes.

-- 
With Best Regards,
Andy Shevchenko
