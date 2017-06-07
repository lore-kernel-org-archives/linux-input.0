From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] HID: Add driver Retrode2 joypad and adapter
Date: Wed, 07 Jun 2017 20:14:08 +0200
Message-ID: <1496859248.11482.14.camel@hadess.net>
References: <1496850178.11482.8.camel@hadess.net>
         <20170607174512.GG13116@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48115 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdFGSOM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 14:14:12 -0400
In-Reply-To: <20170607174512.GG13116@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, 2017-06-07 at 10:45 -0700, Dmitry Torokhov wrote:
> > +     len = strlen(CONTROLLER_NAME_BASE) + strlen(suffix) +
> > +                     number ? 5 : 2;
> > +     name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
> 
> Please use dev_kasprintf() here.

Took me a while to find it was dev*m*_... :)

> > +     if (name) {
> > +             if (number)
> > +                     sprintf(name, "%s %s #%d",
> > CONTROLLER_NAME_BASE,
> > +                             suffix, number);
> > +             else
> > +                     sprintf(name, "%s %s", CONTROLLER_NAME_BASE,
> > +                             suffix);
> > +             hi->input->name = name;
> > +     }
> 
> else return -ENOMEM ?

Done.
