From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: do not bail out when the sixaxis refuses the
 output report
Date: Mon, 18 Jan 2016 23:11:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601182310490.21446@cbobk.fhfr.pm>
References: <1452272329-8744-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452272329-8744-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org, Max Fedotov <thesourcehim@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 8 Jan 2016, Benjamin Tissoires wrote:

> When setting the operational mode, some third party (Speedlink Strike-FX)
> gamepads refuse the output report. Failing here means we refuse to
> initialize the gamepad while this should be harmless.
> 
> The weird part is that the initial commit that added this: a7de9b8
> ("HID: sony: Enable Gasia third-party PS3 controllers") mentions this
> very same controller as one requiring this output report.
> Anyway, it's broken for one user at least, so let's change it.
> We will report an error, but at least the controller should work.
> 
> And no, these devices present themselves as legacy Sony controllers
> (VID:PID of 054C:0268, as in the official ones) so there are no ways
> of discriminating them from the official ones.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1255325
> 
> Reported-and-tested-by: Max Fedotov <thesourcehim@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
