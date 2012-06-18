From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: uhid: silence gcc warning
Date: Mon, 18 Jun 2012 17:12:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206181711260.15308@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab2FRPMh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 11:12:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

gcc is giving me:

drivers/hid/uhid.c: In function =A1uhid_hid_get_raw=A2:
drivers/hid/uhid.c:157: warning: =A1len=A2 may be used uninitialized in=
 this function

which is clearly bogus, as

- when used as memcpy() argument, it's initialized properly
- the code is structured in a way that either 'ret' or 'len'
  is always initialized, so the return statement always has
  an initialized value.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
David,

I have applied this on top of your uhid series in my tree.

 drivers/hid/uhid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index ea560bf..119b7e6 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -154,7 +154,7 @@ static int uhid_hid_get_raw(struct hid_device *hid,=
 unsigned char rnum,
 	struct uhid_event *ev;
 	unsigned long flags;
 	int ret;
-	size_t len;
+	size_t uninitialized_var(len);
 	struct uhid_feature_answer_req *req;
=20
 	if (!uhid->running)

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
