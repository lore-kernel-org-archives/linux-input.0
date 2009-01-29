From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/6] input: Allow certain EV_ABS events to bypass all
 filtering
Date: Thu, 29 Jan 2009 00:29:23 -0800
Message-ID: <20090129002923.7dc6c6ec.akpm@linux-foundation.org>
References: <1233138229-12489-1-git-send-email-rydberg@euromail.se>
	<1233138229-12489-2-git-send-email-rydberg@euromail.se>
	<1233138229-12489-3-git-send-email-rydberg@euromail.se>
	<1233138229-12489-4-git-send-email-rydberg@euromail.se>
	<1233138229-12489-5-git-send-email-rydberg@euromail.se>
	<1233138229-12489-6-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46698 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753607AbZA2IaD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2009 03:30:03 -0500
In-Reply-To: <1233138229-12489-6-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 28 Jan 2009 11:23:48 +0100 "Henrik Rydberg" <rydberg@euromail.se> wrote:

> With the upcoming multi-touch interface as an example, there is
> a need to make certain that all reported events actually get passed
> to the event handler. This patch equips the input core with the
> ability to bypass all filtering for certain EV_ABS events.

This patch doesn't include Randy's fix, below.

It's unchanged from v1, so I did nothing with this one.


From: Randy Dunlap <randy.dunlap@oracle.com>

Fix function args build warning:

mmotm-2008-1230-1605/drivers/input/input.c:1661: warning: function declaration isn't a prototype

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/input/input.c~es-input-allow-certain-ev_abs-events-to-bypass-all-filtering-fix drivers/input/input.c
--- a/drivers/input/input.c~es-input-allow-certain-ev_abs-events-to-bypass-all-filtering-fix
+++ a/drivers/input/input.c
@@ -1644,7 +1644,7 @@ static const struct file_operations inpu
 	.open = input_open_file,
 };
 
-static void __init input_init_abs_bypass()
+static void __init input_init_abs_bypass(void)
 {
 	const unsigned int *p;
 	for (p = input_abs_bypass_init_data; *p; p++)
_

