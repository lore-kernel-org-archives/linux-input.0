From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 04/15] HID: logitech-hidpp: battery: remove overloads
 and provide ONLINE
Date: Thu, 16 Mar 2017 10:20:37 +0100
Message-ID: <20170316092037.GM4378@mail.corp.redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
 <20170202141229.17322-5-benjamin.tissoires@redhat.com>
 <1486561733.7723.2.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdCPJUq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Mar 2017 05:20:46 -0400
Content-Disposition: inline
In-Reply-To: <1486561733.7723.2.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 08 2017 or thereabouts, Bastien Nocera wrote:
> On Thu, 2017-02-02 at 15:12 +0100, Benjamin Tissoires wrote:
> > When ONLINE isn't set, upower should ignore the battery capacity, so
> > there
> > is no need to overload it with some random values.
> 
> In usage, the capacity value will drop to "0":
> -(/sys/class/power_supply/hidpp_battery_1)-> cat capacity 
> 0
> -(/sys/class/power_supply/hidpp_battery_1)-> cat online 
> 1
> 

Heh, just found out what happened here: we were not checking on the
report ID, which means that hitting the 'f' key alone generated a report
that was interpreted by hid-logitech-hidpp as a battery event with a
null capacity :)

Anyway, fixed locally so does the full series that has seen a big clean
up. I'll ask Bastien for some tests and will post a v3 soon.

Cheers,
Benjamin

> And GNOME will popup a warning about the device.
