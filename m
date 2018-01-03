From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input
 device
Date: Wed, 03 Jan 2018 02:38:36 +0100
Message-ID: <1514943516.2523.19.camel@hadess.net>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
         <1483370825.2420.8.camel@hadess.net> <201701021809.58943@pali>
         <1483442481.2420.12.camel@hadess.net>
         <20170117110711.GA26116@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44553 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeACBil (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 20:38:41 -0500
In-Reply-To: <20170117110711.GA26116@xo-6d-61-c0.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2017-01-17 at 12:07 +0100, Pavel Machek wrote:
> 
<snip>
> We'd really like it to work on plain old text console, too, because
> that's what
> I'm using on n900, and with old maemo userspace, because that's what
> everyone
> else uses.
> 
> You mentioned you think X.org can do this kind of device disabling
> (and powersave).
> Would you have an idea how to activate that? I'd like to disable
> touchscreen
> and most of the buttons when the device is "in the pocket".

You need to change the "Device Enabled" property in X. What this does
depends on which Xorg driver it uses.
