From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 04/15] HID: logitech-hidpp: battery: remove overloads
 and provide ONLINE
Date: Wed, 08 Feb 2017 14:48:53 +0100
Message-ID: <1486561733.7723.2.camel@hadess.net>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
         <20170202141229.17322-5-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60817 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbdBHOA7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Feb 2017 09:00:59 -0500
In-Reply-To: <20170202141229.17322-5-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-02-02 at 15:12 +0100, Benjamin Tissoires wrote:
> When ONLINE isn't set, upower should ignore the battery capacity, so
> there
> is no need to overload it with some random values.

In usage, the capacity value will drop to "0":
-(/sys/class/power_supply/hidpp_battery_1)-> cat capacity 
0
-(/sys/class/power_supply/hidpp_battery_1)-> cat online 
1

And GNOME will popup a warning about the device.
