From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] Input: goodix - Poll the 'buffer status' bit before
 reading data
Date: Fri, 13 Oct 2017 20:30:23 +0200
Message-ID: <1507919423.5910.42.camel@hadess.net>
References: <20171013174139.32125-1-hdegoede@redhat.com>
         <1507917540.5910.40.camel@hadess.net>
         <20171013182056.ktgrsofuwu2powo5@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:32885 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdJMSa0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 14:30:26 -0400
In-Reply-To: <20171013182056.ktgrsofuwu2powo5@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, russianneuromancer@ya.ru

On Fri, 2017-10-13 at 11:20 -0700, Dmitry Torokhov wrote:
> On Fri, Oct 13, 2017 at 07:59:00PM +0200, Bastien Nocera wrote:
> > On Fri, 2017-10-13 at 19:41 +0200, Hans de Goede wrote:
> > > +       const int timeout = 20;
> > 
> > I meant rather something like:
> > #define GOODIX_BUFFER_STATUS_TIMEOUT 20
> > 
> > Feel free to add my Reviewed-by after this change is made.
> > 
> 
> How about below?

Looks good to me:

Reviewed-by: Bastien Nocera <hadess@hadess.net>
