From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 05/15] HID: logitech-hidpp: forward device info in
 power_supply
Date: Fri, 03 Feb 2017 16:08:11 +0100
Message-ID: <1486134491.2316.11.camel@hadess.net>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
         <20170202141229.17322-6-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52767 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdBCPIT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Feb 2017 10:08:19 -0500
In-Reply-To: <20170202141229.17322-6-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-02-02 at 15:12 +0100, Benjamin Tissoires wrote:
> +               case POWER_SUPPLY_PROP_MANUFACTURER:
> +                       val->strval = "Logitech, Inc.";

I don't like this change. I'd prefer the concatenated manufacturer and
model strings leading to user-friendly strings, and "Logitech T650" is
better than "Logitech, Inc. T650".
