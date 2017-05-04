From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 7/9] iio: hid-sensor-accel-3d: Drop unnecessary static
Date: Thu,  4 May 2017 22:10:52 +0200
Message-ID: <1493928654-18768-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Drop static on a local variable, when the variable is initialized before
use, on every possible execution path through the function.  The static has
no benefit, and dropping it reduces the code size.

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

The change in code size is indicates by the following output from the size
command.

before:
   text    data     bss     dec     hex filename
   3879     512       8    4399    112f drivers/iio/accel/hid-sensor-accel-3d.o

after:
   text    data     bss     dec     hex filename
   3863     512       0    4375    1117 drivers/iio/accel/hid-sensor-accel-3d.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 43a6cb0..2238a26 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -347,7 +347,7 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 static int hid_accel_3d_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	static const char *name;
+	const char *name;
 	struct iio_dev *indio_dev;
 	struct accel_3d_state *accel_state;
 	const struct iio_chan_spec *channel_spec;
