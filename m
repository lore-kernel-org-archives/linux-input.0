From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix: Add support for capacitive home button
 found on some x86 tablets
Date: Tue, 20 Jun 2017 10:36:38 +0200
Message-ID: <1497947798.2559.10.camel@hadess.net>
References: <1725443.Vzhj3lzWjD@z12> <1497911523.2559.4.camel@hadess.net>
         <20170620025146.GD21379@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42978 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdFTIgp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 04:36:45 -0400
In-Reply-To: <20170620025146.GD21379@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru, linux-input@vger.kernel.org

On Mon, 2017-06-19 at 19:51 -0700, Dmitry Torokhov wrote:
> > General question though, should we not only export and advertise
> > the
> > button if it exists on the device?
> 
> Yes, this is preferred behavior.

So we'll want a dmi match table for the devices that need this feature,
and only export the button for those.

Cheers
