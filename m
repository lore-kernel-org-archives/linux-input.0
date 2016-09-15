From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] hid: Misc tablet fixes and improvements
Date: Thu, 15 Sep 2016 09:14:32 +0200
Message-ID: <20160915071432.GA15777@mail.corp.redhat.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754112AbcIOHOh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 03:14:37 -0400
Content-Disposition: inline
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Sep 14 2016 or thereabouts, Nikolai Kondrashov wrote:
> On 09/14/2016 01:15 PM, Benjamin Tissoires wrote:
> > For this one and 7/9, I think you forgot the hid-core.c changes to not
> > bind hid-generic on those.
> 
> Thanks, Benjamin! Yes, I forgot those. Perhaps I could have just sent the two
> patches fixed, but I respun the whole set with the hid-core changes added,
> just in case. Hope that's not bothersome.
> 

As replied in v1, the series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

BTW, patch 5/9 seems to be required for the Huion DWH69 which directly
reports the buttons and not the keycode emulation:
https://bugs.freedesktop.org/show_bug.cgi?id=97771

Cheers,
Benjamin

> Nick
