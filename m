From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 0/9] HID: spring cleanup v2
Date: Mon, 17 Feb 2014 14:19:35 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171419180.1192@pobox.suse.cz>
References: <1391636004-29354-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391636004-29354-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 5 Feb 2014, Benjamin Tissoires wrote:

> Hi guys,
> 
> well, here comes the promised v2 of the ll_transport cleanup.
> 
> As I said, I removed patches which need some more work, and kept only the
> trivial ones. I also added David's documentation, which gives us a net
> difference of +210 lines of code :(
> Let's say that we still have a net worth of -106 lines of actual code :)
> 
> Cheers,
> Benjamin
> 
> Changes since v1:
> - removed uhid, i2c-hid patches
> - removed the previous 11/11 (move hid_output_raw_report to hid_ll_driver)
> - hid-logitech-dj: use hid_hw_raw_request instead of hid_output_report (2/9)
> - add documentation - I removed the hid_input_event() doc (9/9)

Good job, thanks! Now applied.

-- 
Jiri Kosina
SUSE Labs
