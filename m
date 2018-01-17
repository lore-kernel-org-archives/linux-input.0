From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Tue, 16 Jan 2018 16:41:14 -0800
Message-ID: <20180117004114.gpy552mfz2jo4fay@dtor-ws>
References: <20171117141720.GB17880@kroah.com>
 <CAOFm3uG9QVCTEvV-_pjBGgKoHOWi6ps2tp=NABuHinOQi+QeTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36207 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeAQAlS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jan 2018 19:41:18 -0500
Content-Disposition: inline
In-Reply-To: <CAOFm3uG9QVCTEvV-_pjBGgKoHOWi6ps2tp=NABuHinOQi+QeTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, Nov 17, 2017 at 03:51:31PM +0100, Philippe Ombredanne wrote:
> On Fri, Nov 17, 2017 at 3:17 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > There is no need to #define the license of the driver, just put it in
> > the MODULE_LICENSE() line directly as a text string.
> >
> > This allows tools that check that the module license matches the source
> > code license to work properly, as there is no need to unwind the
> > unneeded dereference.  For some of these drivers, the #define is just a
> > few lines above the MODULE_LICENSE() line, which is extra pointless.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>

Applied, thank you.

-- 
Dmitry
