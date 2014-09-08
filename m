From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: EVIOCSFF macro inconsistency
Date: Mon, 8 Sep 2014 11:31:57 -0700
Message-ID: <20140908183157.GA36623@core.coreip.homeip.net>
References: <CADbOyBRcKFntUAruYTGcqzt2Vi=MHJDFoZK5v4fE8WLFjT0viw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47591 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaIHScC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Sep 2014 14:32:02 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so7320984pdj.20
        for <linux-input@vger.kernel.org>; Mon, 08 Sep 2014 11:32:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADbOyBRcKFntUAruYTGcqzt2Vi=MHJDFoZK5v4fE8WLFjT0viw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi ELias,

On Mon, Sep 08, 2014 at 08:14:13PM +0200, Elias Vanderstuyft wrote:
> Hi everyone,
> 
> After inspecting the <linux/input.h> header file, I found that there
> is one single ioctl value macro that is inconsistent w.r.t. the other
> macros that do an IOC_WRITE :
>     EVIOCSFF   _IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))
> Why not define it as follows? :
>     EVIOCSFF   _IOW('E', 0x80, struct ff_effect)
> Apart from having a more readable definition, it also explicitly
> reveals type info ("struct ff_effect").

I think it is just historical.

> Is it worth to create a patch to fix it?

Sure, why not.

Thanks.

-- 
Dmitry
