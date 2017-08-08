From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH resend 0/1] HID: asus: Add T100CHI bluetooth keyboard
 dock touchpad support
Date: Tue, 8 Aug 2017 10:07:49 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708081007390.30597@cbobk.fhfr.pm>
References: <20170804133104.19685-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750818AbdHHIHv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 8 Aug 2017 04:07:51 -0400
In-Reply-To: <20170804133104.19685-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 4 Aug 2017, Hans de Goede wrote:

> The libinput touchpad-code changes for dealing with bluetooth event 
> timestamps being unreliable have been merged in upstream libinput, so 
> this patch which switches the touchpad from mouse-emulation to 
> touchpad-mt mode can be merged now.

Applied to for-4.14/asus. Thanks,

-- 
Jiri Kosina
SUSE Labs

