From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 37/37] hid-logitech-hidpp: add support for ratchet switch
Date: Tue,  4 Apr 2017 09:22:37 -0300
Message-ID: <cf6b712d59f180857a2df80984ef236bc60e1788.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491308444.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491308444.git.mchehab@s-opensource.com>
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
 <55d263f13237495276213de295ae1c6d67f0588b.1491308444.git.mchehab@s-opensource.com>
 <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491308444.git.mchehab@s-opensource.com>
 <a6e09069e3a232652651c2aac6d0906e728422e2.1491308444.git.mchehab@s-opensource.com>
 <a016a7ed8bf8b5e9f292f188c0763a15937c28c5.1491308444.git.mchehab@s-opensource.com>
 <178fde32a3be0f5b05dc60787f6a96c704960bbb.1491308444.git.mchehab@s-opensource.com>
 <c0f94891efafd6b7c18766ce3e42b82cf805f813.1491308444.git.mchehab@s-opensource.com>
 <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
 <222928e1897ef65d377872a13f9225d8619302de.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <222928e1897ef65d377872a13f9225d8619302de.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Logitech Anywhere MX2 and MX master produce events for
the wheel ratchet/free wheel button. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/hid/hid-logitech-hidpp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c208a5107511..6177087ffaca 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1406,6 +1406,19 @@ static int hidpp_mouse_set_wheel_mode(struct hidpp_device *hidpp,
 			return ret;
 	}
 
+	ret = hidpp_send_fap_command_sync(hidpp, hrd->feature_index,
+					  CMD_MOUSE_GET_WHEEL_RATCHET,
+					  params, 16, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	hrd->ratchet = response.fap.params[0] & 0x01;
+
 	params[0] = invert     ? 0x4 : 0  |
 		    high_res   ? 0x2 : 0  |
 		    hidpp_mode ? 0x1 : 0;
@@ -1945,10 +1958,11 @@ static int high_res_raw_event(struct hid_device *hdev, u8 *data, int size)
 			input_report_rel(hrd->input, REL_HIRES_WHEEL, delta);
 		else
 			input_report_rel(hrd->input, REL_WHEEL, delta);
+	} else if (data[3] == 0x10) {
+		hrd->ratchet = data[4] & 0x01;
+		input_report_switch(hrd->input, SW_RATCHET, hrd->ratchet);
 	}
 
-	/* FIXME: also report ratchet events to userspace */
-
 	return 1;
 }
 
@@ -1961,6 +1975,11 @@ static void high_res_populate_input(struct hidpp_device *hidpp,
 
 	__set_bit(REL_WHEEL, hrd->input->relbit);
 	__set_bit(REL_HIRES_WHEEL, hrd->input->relbit);
+	__set_bit(EV_SW, hrd->input->evbit);
+	__set_bit(SW_RATCHET, hrd->input->swbit);
+
+	/* Report current state of the ratchet switch */
+	input_report_switch(hrd->input, SW_RATCHET, hrd->ratchet);
 }
 
 
-- 
2.9.3

