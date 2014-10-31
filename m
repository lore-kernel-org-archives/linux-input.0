From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: driver for the Goodix touchpanel
Date: Fri, 31 Oct 2014 09:29:43 -0700
Message-ID: <20141031162943.GB36996@dtor-ws>
References: <1414544056.2406.25.camel@hadess.net>
 <CAN+gG=EQDzkR3BjeJxx89ugoc2X4r0dMs4qQrmL6fjifT=zpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44551 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaJaQ3w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 12:29:52 -0400
Received: by mail-ie0-f170.google.com with SMTP id tp5so1644571ieb.15
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 09:29:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN+gG=EQDzkR3BjeJxx89ugoc2X4r0dMs4qQrmL6fjifT=zpgw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Wed, Oct 29, 2014 at 10:49:50AM -0400, Benjamin Tissoires wrote:
> On Tue, Oct 28, 2014 at 8:54 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Add a driver for the Goodix touchscreen panel found in Onda v975w
> > tablets. The driver is based off the Android driver gt9xx.c found
> > in some Android code dumps, but now bears no resemblance to the original
> > driver.
> >
> > The driver was tested on the aforementioned tablet.
> >
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > Tested-by: Bastien Nocera <hadess@hadess.net>
> > ---
> 
> Seems good to me:
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

-- 
Dmitry
