From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 2/2] HID: wacom: Improve generic name generation
Date: Thu, 27 Jul 2017 15:15:20 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707271515060.4705@cbobk.fhfr.pm>
References: <alpine.LSU.2.20.1707201540560.4705@cbobk.fhfr.pm> <20170724164619.29228-1-killertofu@gmail.com> <20170724164619.29228-2-killertofu@gmail.com> <20170726110256.GA24543@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751653AbdG0NPW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Jul 2017 09:15:22 -0400
In-Reply-To: <20170726110256.GA24543@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 26 Jul 2017, Benjamin Tissoires wrote:

> On Jul 24 2017 or thereabouts, Jason Gerecke wrote:
> > The 'wacom_update_name' function is responsible for producing names for
> > the input device nodes based on the hardware device name. Commit f2209d4
> > added the ability to strip off prefixes like "Wacom Co.,Ltd." where the
> > prefix was immediately (and redundantly) followed by "Wacom". The
> > 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
> > (the period and comma are swapped) that prevents the existing code from
> > matching it. We're loath to extend the number of cases out endlessly and
> > so instead try to be smarter about name generation.
> > 
> > We observe that the cause of the redundant prefixes is HID combining the
> > manufacturer and product strings of USB devices together. By using the
> > original product name (with "Wacom" prefixed, if it does not already
> > exist in the string) we can bypass the gyrations to find and remove
> > redundant prefixes. Other devices either don't have a manufacturer string
> > that needs to be removed (Bluetooth, uhid) or should have their name
> > generated from scratch (I2C).
> > 
> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> > ---
> 
> For the series:
> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Now in for-4.14/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs

