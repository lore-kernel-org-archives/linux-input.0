From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching
 modes
Date: Tue, 23 Aug 2011 10:53:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108231052220.13644@pobox.suse.cz>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com> <4E4D3CFC.7000700@canonical.com> <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com> <4E4D426F.607@canonical.com> <4E4D68B0.8000703@canonical.com>
 <CAA8bQNgOZTqGMZhHF0MOm25ZUD5_G0i9F=rMsCOdiD3DYAWhTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53561 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab1HWIxI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 04:53:08 -0400
In-Reply-To: <CAA8bQNgOZTqGMZhHF0MOm25ZUD5_G0i9F=rMsCOdiD3DYAWhTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaikumar Ganesh <jaikumarg@android.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org

On Thu, 18 Aug 2011, Jaikumar Ganesh wrote:

> I also tracked down two Apple magic trackpads - both with the same
> Bluetooth version.
> One which needs this patch (as it returns an invalid report id) and
> the other which doesn't need this patch.
> Both use the same device id.

Gotta love hardware vendors indeed.

So how about the patch below?



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching modes, v2

This is basically a more generic respin of 23746a6 ("HID: magicmouse: ignore
'ivalid report id' while switching modes") which got reverted later by
c3a492.

It turns out that on some configurations, this is actually still the case
and we are not able to detect in runtime.

The device reponds with 'invalid report id' when feature report switching it
into multitouch mode is sent to it.

This has been silently ignored before 0825411ade ("HID: bt: Wait for ACK
on Sent Reports"), but since this commit, it propagates -EIO from the _raw
callback .

So let the driver ignore -EIO as response to 0xd7,0x01 report, as that's
how the device reacts in normal mode.

Sad, but following reality.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=35022

Reported-by: Chase Douglas <chase.douglas@canonical.com>
Reported-by: Jaikumar Ganesh <jaikumarg@android.com>
Tested-by: Chase Douglas <chase.douglas@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-magicmouse.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index b5bdab3..f0fbd7b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -537,9 +537,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 	report->size = 6;
 
+	/*
+	 * Some devices repond with 'invalid report id' when feature
+	 * report switching it into multitouch mode is sent to it.
+	 *
+	 * This results in -EIO from the _raw low-level transport callback,
+	 * but there seems to be no other way of switching the mode.
+	 * Thus the super-ugly hacky success check below.
+	 */
 	ret = hdev->hid_output_raw_report(hdev, feature, sizeof(feature),
 			HID_FEATURE_REPORT);
-	if (ret != sizeof(feature)) {
+	if (ret != -EIO && ret != sizeof(feature)) {
 		hid_err(hdev, "unable to request touch data (%d)\n", ret);
 		goto err_stop_hw;
 	}
-- 
1.7.3.1

