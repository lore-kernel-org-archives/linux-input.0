From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 22:03:48 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702212159510.24579@cbobk.fhfr.pm>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm> <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com> <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com> <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com>
 <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm> <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com> <alpine.LSU.2.20.1702211644090.24579@cbobk.fhfr.pm> <CA+55aFyBkUWy+Qpm6XxyEUi-FU_YSj-r01aRLuh0qoTm_vSq9g@mail.gmail.com>
 <20170221174226.GB21560@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41315 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdBUVDv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 16:03:51 -0500
In-Reply-To: <20170221174226.GB21560@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 21 Feb 2017, Benjamin Tissoires wrote:

> Well, Wacom devices use to need a special driver, but the latest 
> generation should somewhat be able to work without a driver (IIRC). 

I vaguely recall this wasn't the case at all for the older generations 
I've had my hands on, and it wasn't just the matter of 
HID_QUIRK_NO_INIT_REPORTS quirk.

But anyway ... that wasn't reported as a regression for quite some time, 
so let's defer to what Ping and Jason have to say regarding 
protocol/driver compatibility.

I'll be pushing the RMI fix to Linus soon.

Thanks,

-- 
Jiri Kosina
SUSE Labs

