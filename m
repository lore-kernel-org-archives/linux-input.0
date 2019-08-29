From: Denis Efremov <efremov@linux.com>
Subject: [PATCH v3 01/11] checkpatch: check for nested (un)?likely() calls
Date: Thu, 29 Aug 2019 19:50:15 +0300
Message-ID: <20190829165025.15750-1-efremov@linux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anton Altaparmakov <anton@tuxera.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Boris Pismenny <borisp@mellanox.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, "David S. Miller" <davem@davemloft.net>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>, Juergen Gross <jgross@suse.com>, Leon Romanovsky <leon@kernel.org>, Mike Marciniszyn <mike.marciniszyn@intel.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rob Clark <robdclark@gmail.com>, Saeed Mahameed <saeedm@mellanox.com>, Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kern
List-Id: linux-input@vger.kernel.org

IS_ERR(), IS_ERR_OR_NULL(), IS_ERR_VALUE() and WARN*() already contain
unlikely() optimization internally. Thus, there is no point in calling
these functions and defines under likely()/unlikely().

This check is based on the coccinelle rule developed by Enrico Weigelt
https://lore.kernel.org/lkml/1559767582-11081-1-git-send-email-info@metux.net/

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..56969ce06df4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6480,6 +6480,12 @@ sub process {
 			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
 		}
 
+# nested likely/unlikely calls
+		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
+			WARN("LIKELY_MISUSE",
+			     "nested (un)?likely() calls, $1 already uses unlikely() internally\n" . $herecurr);
+		}
+
 # whine mightly about in_atomic
 		if ($line =~ /\bin_atomic\s*\(/) {
 			if ($realfile =~ m@^drivers/@) {
-- 
2.21.0
