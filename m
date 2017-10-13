From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] Input: goodix - Poll the 'buffer status' bit before
 reading data
Date: Fri, 13 Oct 2017 19:59:00 +0200
Message-ID: <1507917540.5910.40.camel@hadess.net>
References: <20171013174139.32125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54511 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbdJMR7E (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 13:59:04 -0400
In-Reply-To: <20171013174139.32125-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, russianneuromancer@ya.ru

On Fri, 2017-10-13 at 19:41 +0200, Hans de Goede wrote:
> +       const int timeout = 20;

I meant rather something like:
#define GOODIX_BUFFER_STATUS_TIMEOUT 20

Feel free to add my Reviewed-by after this change is made.

Thanks!
