From: Dirk Hohndel <hohndel@linux.intel.com>
Subject: [PATCH] INPUT: fix hidinput_connect ignoring retval from input_register_device
Date: Sun, 28 Oct 2007 23:51:53 -0700
Message-ID: <20071029065153.GA9490@bigserver.hohndel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

[INPUT] hidinput_connect incorrectly ignored return value from input_register_device

Signed-off-by: Dirk Hohndel <hohndel@linux.intel.com>

---
 drivers/hid/hid-input.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index dd332f2..c8640e7 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1186,13 +1186,19 @@ int hidinput_connect(struct hid_device *hid)
 				 * UGCI) cram a lot of unrelated inputs into the
 				 * same interface. */
 				hidinput->report = report;
-				input_register_device(hidinput->input);
+				if (input_register_device(hidinput->input)) {
+					input_free_device(hidinput->input);
+					return -1;
+				}
 				hidinput = NULL;
 			}
 		}
 
 	if (hidinput)
-		input_register_device(hidinput->input);
+		if (input_register_device(hidinput->input)) {
+			input_free_device(hidinput->input);
+			return -1;
+		}
 
 	return 0;
 }
-- 
gitgui.0.8.4.g8d863
