From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: Quirk a AMI virtual mouse and keyboard with
 ALWAYS_POLL
Date: Thu, 26 Jan 2017 21:54:27 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701262154180.25515@cbobk.fhfr.pm>
References: <20170126173440.3653-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43953 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdAZUzT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 15:55:19 -0500
In-Reply-To: <20170126173440.3653-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 26 Jan 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Quirking the following AMI USB device with ALWAYS_POLL fixes an AMI
> virtual keyboard and mouse from not responding and timing out when
> it is attached to a ppc64el Power 8 system and when we have some
> rapid open/closes on the mouse device.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

