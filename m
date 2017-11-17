From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Fri, 17 Nov 2017 15:51:31 +0100
Message-ID: <CAOFm3uG9QVCTEvV-_pjBGgKoHOWi6ps2tp=NABuHinOQi+QeTw@mail.gmail.com>
References: <20171117141720.GB17880@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36152 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757222AbdKQOwN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 09:52:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so6998852wmr.1
        for <linux-input@vger.kernel.org>; Fri, 17 Nov 2017 06:52:12 -0800 (PST)
In-Reply-To: <20171117141720.GB17880@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, Nov 17, 2017 at 3:17 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> There is no need to #define the license of the driver, just put it in
> the MODULE_LICENSE() line directly as a text string.
>
> This allows tools that check that the module license matches the source
> code license to work properly, as there is no need to unwind the
> unneeded dereference.  For some of these drivers, the #define is just a
> few lines above the MODULE_LICENSE() line, which is extra pointless.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
-- 
Cordially
Philippe Ombredanne
