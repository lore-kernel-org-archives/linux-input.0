From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/3] input: pixcir_i2c: Remove text about writing to Free Software Foundation
Date: Wed, 17 Aug 2016 15:22:13 +0200
Message-ID: <1471440134-23896-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>
List-Id: linux-input@vger.kernel.org

Checkpatch complains about the text suggesting writing to
Free Software Foundation for GPLv2 license copy.
This patch remove that text.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index b0a2dc2..d8b8889 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -11,10 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
 #include <linux/delay.h>
-- 
2.7.3
