From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: hid-led: fix issue with transfer buffer not
 being dma capable
Date: Mon, 10 Oct 2016 10:47:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610101047160.31629@cbobk.fhfr.pm>
References: <fca778a4-9a20-f0a9-b20e-ccb335fc0b0c@gmail.com> <237d1c6f-933a-e218-bbda-04920bbf3a2a@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbcJJItK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Oct 2016 04:49:10 -0400
In-Reply-To: <237d1c6f-933a-e218-bbda-04920bbf3a2a@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On Mon, 3 Oct 2016, Heiner Kallweit wrote:

> The hid-led driver works fine under 4.8.0, however with the next
> kernel from today I get this:

Queued in hid.git for 4.9-rc. Thanks,

-- 
Jiri Kosina
SUSE Labs

