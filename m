From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 09/11] iio: orientation: hid-sensor-rotation: Drop unnecessary static
Date: Sat, 15 Jul 2017 22:07:44 +0200
Message-ID: <1500149266-32357-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Drop static on a local variable, when the variable is initialized before
any possible use.  Thus, the static has no benefit.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@
static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@
-static
 T x@p;
 ... when != x
     when strict
?x = e;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
These patches are all independent of each other.

 drivers/iio/orientation/hid-sensor-rotation.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -238,7 +238,7 @@ static int dev_rot_parse_report(struct p
 static int hid_dev_rot_probe(struct platform_device *pdev)
 {
 	int ret;
-	static char *name;
+	char *name;
 	struct iio_dev *indio_dev;
 	struct dev_rot_state *rot_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
