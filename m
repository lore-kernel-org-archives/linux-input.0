From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Sat, 14 Oct 2017 10:08:32 -0700
Message-ID: <20171014170832.eykxrf4eaxlah75e@dtor-ws>
References: <20171011094606.6455-1-hdegoede@redhat.com>
 <20171013234846.35vwp5m7qc3biamd@dtor-ws>
 <a2efc457-5c23-2327-948a-e85e780b7e03@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:53391 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdJNRIg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 14 Oct 2017 13:08:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id t188so10210422pfd.10
        for <linux-input@vger.kernel.org>; Sat, 14 Oct 2017 10:08:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a2efc457-5c23-2327-948a-e85e780b7e03@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Sat, Oct 14, 2017 at 10:34:23AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 14-10-17 01:48, Dmitry Torokhov wrote:
> > On Wed, Oct 11, 2017 at 11:46:06AM +0200, Hans de Goede wrote:
> > > On some x86 tablets with a silead touchscreen the windows logo on the
> > > front is a capacitive home button. Touching this button results in a touch
> > > with bits 12-15 of the Y coordinates set, while normally only the lower 12
> > > are used.
> > 
> > Do we know which ones?
> 
> Not really, but since we need to pass resolution info, etc. through
> device-properties (set in drivers/platform/x86/silead_dmi.c) we
> could add a device-property for this, this should also work for
> devicetree based models (although I've only seen the capacitive
> home button as the Windows logo on X86 hardware so far).
> 
> > Can we only set it in capabilities for devices
> > that actually have it?
> 
> If we add a device property for it, yes. I guess that is how
> you want me to handle this, so you will want a v2 which
> keys the enabling of the home button from a device-prop ?

Yes, please.

-- 
Dmitry
