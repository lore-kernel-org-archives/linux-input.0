From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: elan_i2c - check if device is there before
 really probing
Date: Tue, 9 May 2017 17:46:54 -0700
Message-ID: <20170510004654.GC32584@dtor-ws>
References: <20170509004553.GA21295@dtor-ws>
 <CAOMZO5BjGVU3N1YZVo9JiTaKzWcvq1GA_dskXtA4LvNGKG8kNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34797 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdEJAq6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 20:46:58 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5BjGVU3N1YZVo9JiTaKzWcvq1GA_dskXtA4LvNGKG8kNw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, KT Liao <ktalex.liao@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, May 08, 2017 at 10:43:36PM -0300, Fabio Estevam wrote:
> On Mon, May 8, 2017 at 9:45 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > +       /* Make sure there is something at this address */
> > +       error = i2c_smbus_read_byte(client);
> > +       if (error < 0) {
> > +               dev_dbg(&client->dev, "nothing at this address: %d\n", error);
> > +               return -ENXIO;
> 
> You could return the real error code here: 'return error'

That is the point of the patch - we want to fail silently if the device
is not actually there and fails even the simplest communication. Driver
core treats ENXIO and ENODEV as special and does not log errors.

Thanks.

-- 
Dmitry
