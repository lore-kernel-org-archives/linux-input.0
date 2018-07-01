From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/3] cast sizeof to int for comparison
Date: Sun,  1 Jul 2018 19:32:02 +0200
Message-ID: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, joe@perches.com, Chengguang Xu <cgxu519@gmx.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@safe disable not_int2@
int x;
position p;
binary operator op = {<,<=};
expression e;
@@

(
x < 0 || (x@p op e)
|
x <= 0 || (x@p op e)
|
x > 0 && (x@p op e)
|
x >= 0 && (x@p op e)
)

@@
int x;
type t;
expression e,e1;
identifier f != {strlen,resource_size};
position p != safe.p;
binary operator op = {<,<=};
@@

*x = f(...);
... when != x = e1
    when != if (x < 0 || ...) { ... return ...; }
(
*x@p op sizeof(e)
|
*x@p op sizeof(t)
)
// </smpl>

---

 drivers/input/mouse/elan_i2c_smbus.c |    2 +-
 drivers/media/usb/gspca/kinect.c     |    2 +-
 drivers/usb/wusbcore/security.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
