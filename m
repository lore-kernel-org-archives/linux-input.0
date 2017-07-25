From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Tue, 25 Jul 2017 15:58:46 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707251558240.4705@cbobk.fhfr.pm>
References: <20170722185537.12696-1-hdegoede@redhat.com> <20170722185537.12696-2-hdegoede@redhat.com> <20170724081928.GB18097@mail.corp.redhat.com> <alpine.LSU.2.20.1707251457190.4705@cbobk.fhfr.pm> <20170725134658.GB5777@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57971 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751940AbdGYN6t (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Jul 2017 09:58:49 -0400
In-Reply-To: <20170725134658.GB5777@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Tue, 25 Jul 2017, Wolfram Sang wrote:

> > Either I can take it through hid.git with your Ack for the first patch, or 
> > vice versa. Please let me know what you'd prefer.
> 
> I'd like use the i2c tree for it. The changes to i2c core are an API
> addition while the changes to the HID driver are basically boilerplate.
> 
> Makes sense?

Absolutely.

Please feel free to add

	Reviewed-by: Jiri Kosina <jkosina@suse.cz>

to patch 2/2.

Thanks,

-- 
Jiri Kosina
SUSE Labs

