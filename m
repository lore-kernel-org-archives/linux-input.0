From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Fri, 13 Oct 2017 16:48:46 -0700
Message-ID: <20171013234846.35vwp5m7qc3biamd@dtor-ws>
References: <20171011094606.6455-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:52561 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbdJMXst (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 19:48:49 -0400
Received: by mail-pg0-f43.google.com with SMTP id a192so931734pge.9
        for <linux-input@vger.kernel.org>; Fri, 13 Oct 2017 16:48:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171011094606.6455-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Wed, Oct 11, 2017 at 11:46:06AM +0200, Hans de Goede wrote:
> On some x86 tablets with a silead touchscreen the windows logo on the
> front is a capacitive home button. Touching this button results in a touch
> with bits 12-15 of the Y coordinates set, while normally only the lower 12
> are used.

Do we know which ones? Can we only set it in capabilities for devices
that actually have it?

Thanks.

-- 
Dmitry
