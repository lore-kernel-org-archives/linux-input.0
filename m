From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: [PATCH] input - Add Euro and Dollar keys
Date: Thu, 25 Oct 2007 13:56:21 +0100
Message-ID: <200710251356.21758.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

From: Carlos Corbacho <cathectic@gmail.com>

Most newer Acer laptops (from 2005 onwards) now ship with an extra Dollar
and Euro key either side of the 'Up' arrow. These cannot be mapped in the 
traditional way, since they are not combination keys.

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
Dimitry,

1) This patch is based against Linus' tree, since your 
include/linux/input.h is out of date.

2) I am aware that there was some discussion over whether KEY_EURO should
become KEY_CURRENCY, due to concerns that Acer may one day release a laptop
with a different currency key instead of the Euro.

If you would prefer this patch to be redone with KEY_CURRENCY instead, then
I am happy to do so, if it means this will go upstream.

diff --git a/include/linux/input.h b/include/linux/input.h
index 6226892..b45f240 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -527,6 +527,9 @@ struct input_absinfo {
 #define KEY_SPELLCHECK		0x1b0   /* AL Spell Check */
 #define KEY_LOGOFF		0x1b1   /* AL Logoff */
 
+#define KEY_DOLLAR		0x1b2
+#define KEY_EURO		0x1b3
+
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
 #define KEY_INS_LINE		0x1c2
