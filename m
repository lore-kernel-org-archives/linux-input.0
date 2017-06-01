From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Thu, 01 Jun 2017 21:26:25 +0200
Message-ID: <1496345185.2570.3.camel@hadess.net>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
         <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:53863 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFATfo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Jun 2017 15:35:44 -0400
In-Reply-To: <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-06-01 at 11:06 -0700, Dave Hansen wrote:
> On 03/27/2017 07:59 AM, Benjamin Tissoires wrote:
> > this is finally a rework of the series that provides kernel
> > power_supply
> > for hidpp devices.
> > 
> > This will allow upower to not handle those devices anymore and to
> > have more
> > immediate reportng of the device to the system.
> 
> FWIW, I'm on Ubuntu 14.04, and upower *is* reporting my mouse battery
> as
> if it were a laptop battery.  It's mostly garbage, and always reports
> 0%, which makes upower always tell me my laptop is 2/3 charged (I
> have 2
> real batteries).
> 
> Is this expected?

You need to either disable the feature for the kernel, or upgrade to
the latest git master of UPower. Mixing both won't work. Use the devkit
mailing-list if you need a release of UPower.

Cheers
