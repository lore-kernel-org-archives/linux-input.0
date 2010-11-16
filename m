From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: [PATCH v2 3/4] da850-evm: extract defines for SEL{A, B,
	C} pins in UI expander
Date: Tue, 16 Nov 2010 14:39:36 -0500
Message-ID: <aa85c5d83111add3a2ed3495ac13bffe5e6b885d.1289935504.git.bengardiner@nanometrics.ca>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <cover.1289935504.git.bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Chris Cordahi <christophercordahi-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The setup and teardown methods of the UI expander reference the SEL_{A,B,C}
pins by 'magic number' in each function. This patch extracts common #defines
for their offsets in the expander and uses them.

Signed-off-by: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Reviewed-by: Chris Cordahi <christophercordahi-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>

---

No changes since v1
---
 arch/arm/mach-davinci/board-da850-evm.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index ff71ffd..dcf21e5 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -292,6 +292,9 @@ static const char const *ui_expander_names[] = {
 	"pb7", "pb6", "pb5", "pb4", "pb3", "pb2", "pb1"
 };
 
+#define DA850_SEL_A_OFFSET	7
+#define DA850_SEL_B_OFFSET	6
+#define DA850_SEL_C_OFFSET	5
 #define DA850_UI_PB8_OFFSET	8
 #define DA850_N_UI_PB		8
 
@@ -336,23 +339,23 @@ static int da850_evm_ui_expander_setup(struct i2c_client *client, unsigned gpio,
 {
 	int sel_a, sel_b, sel_c, ret;
 
-	sel_a = gpio + 7;
-	sel_b = gpio + 6;
-	sel_c = gpio + 5;
+	sel_a = gpio + DA850_SEL_A_OFFSET;
+	sel_b = gpio + DA850_SEL_B_OFFSET;
+	sel_c = gpio + DA850_SEL_C_OFFSET;
 
-	ret = gpio_request(sel_a, "sel_a");
+	ret = gpio_request(sel_a, ui_expander_names[DA850_SEL_A_OFFSET]);
 	if (ret) {
 		pr_warning("Cannot open UI expander pin %d\n", sel_a);
 		goto exp_setup_sela_fail;
 	}
 
-	ret = gpio_request(sel_b, "sel_b");
+	ret = gpio_request(sel_b, ui_expander_names[DA850_SEL_B_OFFSET]);
 	if (ret) {
 		pr_warning("Cannot open UI expander pin %d\n", sel_b);
 		goto exp_setup_selb_fail;
 	}
 
-	ret = gpio_request(sel_c, "sel_c");
+	ret = gpio_request(sel_c, ui_expander_names[DA850_SEL_C_OFFSET]);
 	if (ret) {
 		pr_warning("Cannot open UI expander pin %d\n", sel_c);
 		goto exp_setup_selc_fail;
@@ -396,13 +399,13 @@ static int da850_evm_ui_expander_teardown(struct i2c_client *client,
 	platform_device_unregister(&user_ui_pb_gpio_key_device);
 
 	/* deselect all functionalities */
-	gpio_set_value(gpio + 5, 1);
-	gpio_set_value(gpio + 6, 1);
-	gpio_set_value(gpio + 7, 1);
+	gpio_set_value(gpio + DA850_SEL_C_OFFSET, 1);
+	gpio_set_value(gpio + DA850_SEL_B_OFFSET, 1);
+	gpio_set_value(gpio + DA850_SEL_A_OFFSET, 1);
 
-	gpio_free(gpio + 5);
-	gpio_free(gpio + 6);
-	gpio_free(gpio + 7);
+	gpio_free(gpio + DA850_SEL_C_OFFSET);
+	gpio_free(gpio + DA850_SEL_B_OFFSET);
+	gpio_free(gpio + DA850_SEL_A_OFFSET);
 
 	return 0;
 }
-- 
1.7.0.4
