From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/8] HID: Consolidate serializing ope/close in transport
 drivers
Date: Thu, 8 Jun 2017 13:56:44 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706081356340.30709@cbobk.fhfr.pm>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41821 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbdFHL4t (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 8 Jun 2017 07:56:49 -0400
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, 6 Jun 2017, Dmitry Torokhov wrote:

> This originally came about as report of uhid sending duplicate open and
> premature close when hidraw was used alongside of input. After looking at
> the drivers I think we should consolidate user tracking inside of the HID
> core. While implementing this, there were a few cleanups as well.
> 
> V2:
> 
> - added greybus hid changes
> - added error handling in hiddev around hid_hw_open which is __much_check

I've applied the series, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs

