From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Fri, 10 Mar 2017 12:35:05 +0200
Message-ID: <20170310103505.GZ2957@lahna.fi.intel.com>
References: <1488969002.20145.119.camel@linux.intel.com>
 <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
 <1488973582.20145.125.camel@linux.intel.com>
 <654981a1-2493-01d6-13e6-1287b70e22f2@redhat.com>
 <1488997525.20145.161.camel@linux.intel.com>
 <114fa24e-b726-28e1-66c7-aa90bcf5c966@redhat.com>
 <1489068196.20145.169.camel@linux.intel.com>
 <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
 <97099577-181d-ac94-4d9e-ab5ca64f9ff6@redhat.com>
 <20170309213200.GF20077@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934974AbdCJKfL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 05:35:11 -0500
Content-Disposition: inline
In-Reply-To: <20170309213200.GF20077@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Thu, Mar 09, 2017 at 01:32:00PM -0800, Dmitry Torokhov wrote:
> It looks like IoRestriction enforcement should be optional and it is
> another thing to be tweaked in drivers/platform/x86/whatever.c

If the firmware says the pin is only to be used as output, I don't think
it is really good idea to make that kind of enforcement optional.
