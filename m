From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Notification when a new device is added or removed
Date: Sun, 1 Mar 2009 02:23:19 -0800
Message-ID: <20090301022212.ZZRA012@mailhub.coreip.homeip.net>
References: <49A8BEF7.9060602@manoweb.com> <20090228183917.ZZRA012@mailhub.coreip.homeip.net> <49A9F9BD.2090604@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:51381 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZCAKXd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Mar 2009 05:23:33 -0500
Received: by gxk22 with SMTP id 22so3952932gxk.13
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2009 02:23:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <49A9F9BD.2090604@manoweb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

On Sat, Feb 28, 2009 at 06:58:05PM -0800, Alessio Sangalli wrote:
> Dmitry Torokhov wrote:
> 
> > You should be able to poll (select) /proc/bus/input/devices.
> 
> Yeah that would be great; anyway, I tried and... well nothing happens. I
> am obviously missing something here:
> 

Hmm, it turns out poll is completely busted. The patch below should
help.

-- 
Dmitry

Input: fix polling of /proc/bus/input/devices

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/input/input.c b/drivers/input/input.c
index 46e9ce1..913392f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -744,11 +744,11 @@ static inline void input_wakeup_procfs_readers(void)
 
 static unsigned int input_proc_devices_poll(struct file *file, poll_table *wait)
 {
-	int state = input_devices_state;
-
 	poll_wait(file, &input_devices_poll_wait, wait);
-	if (state != input_devices_state)
+	if (file->f_version != input_devices_state) {
+		file->f_version = input_devices_state;
 		return POLLIN | POLLRDNORM;
+	}
 
 	return 0;
 }
