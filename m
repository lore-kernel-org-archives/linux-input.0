From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 8/8] V4L/DVB: ir-core: move subsystem internal calls to
 ir-core-priv.h
Date: Thu, 08 Apr 2010 18:34:22 -0300
Message-ID: <4BBE4BDE.80500@redhat.com>
References: <cover.1270754989.git.mchehab@redhat.com> <20100408163716.70862743@pedra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408163716.70862743@pedra>
Sender: linux-media-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Mauro Carvalho Chehab wrote:
> ir-core.h has the kABI to be used by the bridge drivers, when needing=
 to register
> IR protocols and pass IR events. However, the same file also contains=
 IR subsystem
> internal calls, meant to be used inside ir-core and between ir-core a=
nd the raw
> decoders.
>=20
> Better to move those functions to an internal header, for some reason=
s:
>=20
> 1) Header will be a little more cleaner;
>=20
> 2) It avoids the need of recompile everything (bridge/hardware driver=
s, etc),
>    just because a new decoder were added, or some other internal chan=
ge were needed;
>=20
> 3) Better organize the ir-core API, splitting the functions that are =
internal to
>    IR core and the ancillary drivers (decoders, lirc_dev) from the fe=
atures that
>    should be exported to IR subsystem clients.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
>=20
>  create mode 100644 drivers/media/IR/ir-core-priv.h

This cleanup were too aggressive:

drivers/media/dvb/ttpci/budget-ci.c: In function =E2=80=98msp430_ir_int=
errupt=E2=80=99:
drivers/media/dvb/ttpci/budget-ci.c:163: error: implicit declaration of=
 function =E2=80=98ir_keydown=E2=80=99

We need ir_keydown() / ir_repeat() for in-hardware decoders. I'm foldin=
g it
with this patch:

diff --git a/drivers/media/IR/ir-core-priv.h b/drivers/media/IR/ir-core=
-priv.h
index ab785bc..8d97d6c 100644
--- a/drivers/media/IR/ir-core-priv.h
+++ b/drivers/media/IR/ir-core-priv.h
@@ -62,8 +62,6 @@ struct ir_raw_event_ctrl {
=20
 u32 ir_g_keycode_from_table(struct input_dev *input_dev,
                            u32 scancode);
-void ir_repeat(struct input_dev *dev);
-void ir_keydown(struct input_dev *dev, int scancode, u8 toggle);
=20
 /*
  * Routines from ir-sysfs.c - Meant to be called only internally insid=
e
diff --git a/include/media/ir-core.h b/include/media/ir-core.h
index 40b6250..ab3bd30 100644
--- a/include/media/ir-core.h
+++ b/include/media/ir-core.h
@@ -122,6 +122,9 @@ static inline int ir_input_register(struct input_de=
v *dev,
=20
 void ir_input_unregister(struct input_dev *input_dev);
=20
+void ir_repeat(struct input_dev *dev);
+void ir_keydown(struct input_dev *dev, int scancode, u8 toggle);
+
 /* From ir-raw-event.c */
=20
 void ir_raw_event_handle(struct input_dev *input_dev);



--=20

Cheers,
Mauro
