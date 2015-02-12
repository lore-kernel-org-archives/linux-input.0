From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Input: cyapa - Remove superfluous type check in cyapa_gen5_read_idac_data()
Date: Thu, 12 Feb 2015 15:16:13 +0100
Message-ID: <1423750573-30263-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dudley Du <dudl@cypress.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

drivers/input/mouse/cyapa_gen5.c: In function =E2=80=98cyapa_gen5_read_=
idac_data=E2=80=99:
drivers/input/mouse/cyapa_gen5.c:1876: warning: =E2=80=98max_element_cn=
t=E2=80=99 may be used uninitialized in this function
drivers/input/mouse/cyapa_gen5.c:1873: warning: =E2=80=98offset=E2=80=99=
 may be used uninitialized in this function

If *data_size is non-zero, and idac_data_type contains an unknown type,
max_element_cnt and offset will be uninitialized, and the loop will
process non-existing data.

However, this cannot happen (for now), as there's a test for unknown
types at the top of cyapa_gen5_read_idac_data().

As no "if ... else if ..." is used in other places, remove the
superfluous "if" to silence the compiler warning.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Alternatively, we can pre-initialize max_element_cnt and offset to zero=
,
and add "if (!max_element_cnt) goto out;" before the loop.

 drivers/input/mouse/cyapa_gen5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cya=
pa_gen5.c
index ddf5393a118098fc..88c465b70e9d8776 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -1926,7 +1926,7 @@ static int cyapa_gen5_read_idac_data(struct cyapa=
 *cyapa,
 				electrodes_tx =3D cyapa->electrodes_x;
 			max_element_cnt =3D ((cyapa->aligned_electrodes_rx + 7) &
 						~7u) * electrodes_tx;
-		} else if (idac_data_type =3D=3D GEN5_RETRIEVE_SELF_CAP_PWC_DATA) {
+		} else {
 			offset =3D 2;
 			max_element_cnt =3D cyapa->electrodes_x +
 						cyapa->electrodes_y;
--=20
1.9.1
