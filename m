From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH v2] hid: Misc tablet fixes and improvements
Date: Wed, 14 Sep 2016 21:38:11 +0300
Message-ID: <20160914183820.20737-1-spbnick@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36420 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756218AbcINSih (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:38:37 -0400
Received: by mail-wm0-f44.google.com with SMTP id b187so60807581wme.1
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 11:38:36 -0700 (PDT)
In-Reply-To: <20160914101531.GJ25951@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

On 09/14/2016 01:15 PM, Benjamin Tissoires wrote:
> For this one and 7/9, I think you forgot the hid-core.c changes to not
> bind hid-generic on those.

Thanks, Benjamin! Yes, I forgot those. Perhaps I could have just sent the two
patches fixed, but I respun the whole set with the hid-core changes added,
just in case. Hope that's not bothersome.

Nick
