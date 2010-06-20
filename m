From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Introduce buflock, a one-to-many circular buffer mechanism
 (rev2)
Date: Sun, 20 Jun 2010 22:13:11 +0200
Message-ID: <4C1E7657.9070606@bitmath.org>
References: <1277060705-3363-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:43408 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757004Ab0FTUNO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jun 2010 16:13:14 -0400
In-Reply-To: <1277060705-3363-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Jonathan Cameron <jic23@cam.ac.uk>

...

diff --git a/include/linux/buflock.h b/include/linux/buflock.h
index 3d5df22..05996d5 100644
--- a/include/linux/buflock.h
+++ b/include/linux/buflock.h
@@ -125,8 +125,8 @@ static inline unsigned int bufwrite_at(const struct buflock_
writer *bw)
  */
 static inline void bufwrite_unlock(struct buflock_writer *bw)
 {
-	++bw->head;
 	smp_wmb();
+	++bw->head;
 }

