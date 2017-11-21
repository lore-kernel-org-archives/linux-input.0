From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: Ignore Jabra HID interface based on firmware
 version
Date: Tue, 21 Nov 2017 12:57:52 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711211257360.11505@cbobk.fhfr.pm>
References: <1507112997-31588-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34951 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbdKUL5y (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Nov 2017 06:57:54 -0500
In-Reply-To: <1507112997-31588-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, vpalatin@chromium.org

On Wed, 4 Oct 2017, nolsen@jabra.com wrote:

> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Two Jabra speakerphone devices were added to the ignore list in 2013,
> because the device HID interfaces didn't work well with kernel usbhid
> driver, and could cause volume key event storm.
> 
> See the original commit:
> Commit 31b9779cb292 ("HID: ignore Jabra speakerphones HID interface")
> 
> Modify hid_lookup_quirk() to consider the firmware version of these two
> devices, so that only versions older than a known good version are
> ignored.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> ---
> v2: Rebase on patch set "Quirks cleanup and hid-generic niceness", v2
>     (http://www.spinics.net/lists/linux-input/msg53428.html)
>     Simplify with review suggestions by Benjamin Tissoires

Applied to for-4.16/hid-quirks-cleanup/jabra.

-- 
Jiri Kosina
SUSE Labs

