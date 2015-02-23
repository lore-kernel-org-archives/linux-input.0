From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/3] HID: i2c-hid: Read wMaxInputLength of input report instead of bufsize
Date: Mon, 23 Feb 2015 15:52:44 +0200
Message-ID: <1424699565-138045-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Wacom digitizer (WCOM0008) on Lenovo Thinkpad 10 seems to allow reading=
 of
subsequent reports (or part of them) if we read more than wMaxInputLeng=
th
of data at the time. This data is not always aligned so that the next
report would start right after another.

=46or example we might get following sequence:

 i2c_hid i2c-WCOM0008:00: input: 0a 00 02 21 20 17 ad 22 11 03
 i2c_hid i2c-WCOM0008:00: input: ad 22 11 03 0a 00 02 21 20 17
                                 ad 22 11 03 0a 00 02 21 20 17
                                 ad 22 11 03 0a 00 02 21 20 17
                                 ad 22 11 03 0a 00 02 21 20 17
                                 ad 22 11 03 0a 00 02 21 20 17
                                 ad 22 11 03 0a 00 02 21 20 17
                                 ad 22 11 03
 i2c_hid i2c-WCOM0008:00: input: 02 21 20 17 ad 22 11 03 0a 00
                                 02 21 20 17 ad 22 11 03 0a 00
                                 02 21 20 17 ad 22 11 03 0a 00
                                 02 21 20 17 ad 22 11 03 0a 00
                                 02 21 20 17 ad 22 11 03 0a 00
                                 02 21 20 17 ad 22 11 03 0a 00
                                 02 21 20 17
 i2c_hid i2c-WCOM0008:00: i2c_hid_get_input: incomplete report (76/8450=
)

The bufsize is 76 and wMaxInputLength is 10. In above example the first
read gets right amount of data. The second and third reads get full buf=
size
(76 bytes) but the report is missing a start already. This causes the
driver to reject the report because we got less than was expected by th=
e
report length (0x2102 =3D 8450).

If we read only wMaxInputLength at the time this does not happen at all=
 and
the digitizer works fine.

Based on this change the driver to read wMaxInputLength bytes instead o=
f
bufsize if the value looks sane.

Reported-by: S=C3=A9bastien Bourdeauducq <sb@m-labs.hk>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hi=
d.c
index 8f1dfc5c5d9c..404ccde49acd 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -369,9 +369,17 @@ static int i2c_hid_hwreset(struct i2c_client *clie=
nt)
=20
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
+	unsigned max_input_length =3D le16_to_cpu(ihid->hdesc.wMaxInputLength=
);
 	int ret, ret_size;
 	int size =3D ihid->bufsize;
=20
+	/*
+	 * Take the input length from HID descriptor if it is available and
+	 * looks reasonable.
+	 */
+	if (max_input_length > 0)
+		size =3D min_t(unsigned, ihid->bufsize, max_input_length);
+
 	ret =3D i2c_master_recv(ihid->client, ihid->inbuf, size);
 	if (ret !=3D size) {
 		if (ret < 0)
--=20
2.1.4
