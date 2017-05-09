From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] Input: elan_i2c - check if device is there before
 really probing
Date: Mon, 8 May 2017 22:43:36 -0300
Message-ID: <CAOMZO5BjGVU3N1YZVo9JiTaKzWcvq1GA_dskXtA4LvNGKG8kNw@mail.gmail.com>
References: <20170509004553.GA21295@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34869 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdEIBnh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 21:43:37 -0400
In-Reply-To: <20170509004553.GA21295@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, KT Liao <ktalex.liao@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, May 8, 2017 at 9:45 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> +       /* Make sure there is something at this address */
> +       error = i2c_smbus_read_byte(client);
> +       if (error < 0) {
> +               dev_dbg(&client->dev, "nothing at this address: %d\n", error);
> +               return -ENXIO;

You could return the real error code here: 'return error'
