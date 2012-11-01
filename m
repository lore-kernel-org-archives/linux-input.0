From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG v3.6.2, 3.7-rc1] Unable to rmmod any hid special driver
Date: Thu, 1 Nov 2012 11:14:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211011114150.6606@pobox.suse.cz>
References: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60579 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932613Ab2KAKOz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Nov 2012 06:14:55 -0400
In-Reply-To: <CAN+gG=HFGMP8yU0PD6Ci-9ppVy4n3wp=SwymzAtp8KTg9Ewa=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Ratan Nalumasu <ratan@google.com>, linux-input <linux-input@vger.kernel.org>

On Thu, 18 Oct 2012, Benjamin Tissoires wrote:

> Hi Guys,
> 
> Commit 4fe9f8e203fdad1524c04beb390f3c6099781ed9 upstream
> Commit 57a38d925e665fcd729cd9ad4a75c84e11bd95c9 linux-stable
> 
> This commit "HID: hidraw: don't deallocate memory when it is in use"
> prevents users to rmmod then insmod  any hid special driver without
> either physically unplugging the device or without rmmod-ing the hid
> bus itself.
> 
> When the user does a rmmod, hidinput_disconnect is called before
> hidraw_disconnect, thus, the hidraw device is still there, but the
> input one not. It leads to the fact that the device is not working
> anymore even if you call modprobe.
> 
> Any idea to solve that?

Guys, how about this?


---
 drivers/hid/hidraw.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 17d15bb..fce4256 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -560,10 +560,11 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
 {
 	mutex_lock(&minors_lock);
 	if (exists_bit) {
-		hid_hw_close(hidraw->hid);
 		hidraw->exist = 0;
-		if (hidraw->open)
+		if (hidraw->open) {
+			hid_hw_close(hidraw->hid);
 			wake_up_interruptible(&hidraw->wait);
+		}
 	} else {
 		--hidraw->open;
 	}

-- 
Jiri Kosina
SUSE Labs
