From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: prodikeys: make array keys static const, makes object smaller
Date: Thu,  5 Sep 2019 17:54:06 +0100
Message-ID: <20190905165406.24641-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array keys on the stack but instead make it
static const. Makes the object code smaller by 166 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  18931	   5872	    480	  25283	   62c3	drivers/hid/hid-prodikeys.o

After:
   text	   data	    bss	    dec	    hex	filename
  18669	   5968	    480	  25117	   621d	drivers/hid/hid-prodikeys.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 21544ebff855..fb6841ebe4d9 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -516,7 +516,7 @@ static void pcmidi_setup_extra_keys(
 		MY PICTURES =>	KEY_WORDPROCESSOR
 		MY MUSIC=>	KEY_SPREADSHEET
 	*/
-	unsigned int keys[] = {
+	static const unsigned int keys[] = {
 		KEY_FN,
 		KEY_MESSENGER, KEY_CALENDAR,
 		KEY_ADDRESSBOOK, KEY_DOCUMENTS,
@@ -532,7 +532,7 @@ static void pcmidi_setup_extra_keys(
 		0
 	};
 
-	unsigned int *pkeys = &keys[0];
+	const unsigned int *pkeys = &keys[0];
 	unsigned short i;
 
 	if (pm->ifnum != 1)  /* only set up ONCE for interace 1 */
-- 
2.20.1
