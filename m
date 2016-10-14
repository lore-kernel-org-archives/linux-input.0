From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] Tiny modification of i2c-hid
Date: Fri, 14 Oct 2016 16:02:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610141602200.31629@cbobk.fhfr.pm>
References: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58669 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752730AbcJNOCl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Oct 2016 10:02:41 -0400
In-Reply-To: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2016, Benjamin Tissoires wrote:

> Hi Jiri,
> 
> David and I are facing an issue in RHEL with the HP Zbook 15 Studio mWS.
> This laptops uses the pinctrl-sunrisepoint controller for the GPIOs and
> it failed on RHEL. We found out what the issue was, but in the meantime
> realized that part of the code we have in i2c-hid is not required anymore.
> 
> The actual issue is fixed here: https://lkml.org/lkml/2016/10/12/493
> but it would be more convenient (for us) and cleaner (fo everybody) to just
> remove the extra boiler-plate in i2c-hid and let i2c-core handling the
> attributions of the IRQ.

Both applied to hid.git#for-4.10/i2c-hid.

-- 
Jiri Kosina
SUSE Labs

