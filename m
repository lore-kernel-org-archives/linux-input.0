From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Sat, 30 Oct 2010 10:28:54 -0600
Message-ID: <4CCCE2760200002300022EE9@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi all,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 09:49 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Tue, Oct 19, 2010 at 06:03:09PM +0200, Corentin Chary wrote:
> > On Tue, Oct 19, 2010 at 5:49 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Tue, Oct 19, 2010 at 03:28:43PM +0200, Corentin Chary wrote:
> > >> On Tue, Oct 19, 2010 at 3:25 PM, Joey Lee <jlee@novell.com> wrot=
e:
> > >> > Hi Corentin,
> > >> >
> > >> > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 05:15 -0600=EF=
=BC=8CJoey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> > >> >> Hi Corentin,
> > >> >>
> > >> >> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=
=BC=8CCorentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> > >> >> > >> Most of users will want the key to just toggle wlan/blue=
tooth. But some of them
> > >> >> > >> will be happy if they can configure the behavior of the =
key (cycle, only toggle
> > >> >> > >> WLAN, etc...)
> > >> >> > >>
> > >> >> > >
> > >> >> > > I thought just direct disable the default EC behavior the=
n leave a
> > >> >> > > userland daemon to control the behavior, it will grab the=
 wifi key event
> > >> >> > > then control rfkill state by follow user's customization =
rules.
> > >> >> >
> > >> >> > What I'm saying is: I don't really care what's the default =
behavior is,
> > >> >> > but if the EC provide a somewhat reliable way to make the k=
ey work
> > >> >> > without any userspace daemon involved, I think we should al=
low
> > >> >> > the user to use this mode (even if it's with an obscure mod=
ule
> > >> >> > parameter or sysfs file).
> > >
> > > But we already have the in-kernel solution that provides this beh=
avior.
> > > It is called rfkill-input and it is the in-kernel bridge between =
input
> > > devices that emit KEY_WLAN etc. and rfkill switches. There is no =
need to
> > > have yet another mechanism (most likely fighting with default in-=
kernel
> > > one) doing the same thing. So for boxes tat do support this launc=
her
> > > mode we should simply enable it. _Always_.
> > >
> > > And once the userspace manager[s] become standard we can just rel=
y on
> > > their presence. Like right now you can't really live without udev=
, dbus,
> > > etc. if you want to have reasonably behaving box (embedded setups=
 out of
> > > scope here).
> > >
> > >> >> >
> > >> >> > But .. maybe if someone want this default "raw" behavior,
> > >> >> > he should just not load this module.
> > >> >> >
> > >> >>
> > >> >> Fully understood, now.
> > >> >>
> > >> >> Like you siad, we need define a policy for:
> > >> >>
> > >> >>  - If user want the default "raw" behavior, what do they need=
 to do?
> > >> >>       I thought if the wmi driver doesn't load by default, th=
en user
> > >> >>        will get a "raw" behavior.
> > >> >>
> > >> > But...
> > >> > The wmi driver doesn't just provide the RF switch function, it=
's also
> > >> > have other functions like transfer wmi event to key code.
> > >> >
> > >> > User doesn't load wmi driver will have "raw" RF switch behavio=
r, but
> > >> > lost other more functions.
> > >> >
> > >> >>  - If any distro want provide userland solution, how can they=
 disable
> > >> >>    the default "raw" behavior?
> > >> >>       If anybody want to disable the "raw" behavior, just loa=
d the wmi
> > >> >>        driver.
> > >> > Maybe we still add kernel module parameter?
> > >> >
> > >>
> > >> Indeed, I think it would be a good idea to let the user do that.
> > >>
> > >
> > > And I do not think so for the reasons outlined. We have chosen th=
e
> > > direction already (dictated by the existence of keys not directly
> > > connected withg RF switches) and we should follow through with it=
, so
> > > all boxes and drivers behave as uniformly as possible.
> > >
> >=20
> > Then, let's not add this parameter. Anyway the potential user base =
who
> > may acer-wmi without this mode is probably very low.
> >=20
> > But I still think that having a parameter to enable this "raw" mode
> > would be helpful in some case, for example, "the keycode changed an=
d
> > is not yet mapped to KEY_WLAN", or "wimax is not yet supported by
> > acer-wmi and there is not (yet) a rfkill interface for it". This wo=
ul> > be a quirk mode, only enabled for some very special cases, like
> > acpi_osi=3D"Linux" or acpi_backlight=3D"vendor".
>=20
> I see. I guess I'd rather people reported the issue and we provided t=
he
> fix that have them work around the issue (maybe) and we never hearing
> about it. This way fix hapepns quicker and work for everyone instead =
of
> only the person discovered the magic option.
>=20
> I think we discussed it enough, I'll defer to Matthew whether to take
> the patch with the switch or the one enabling the mode unconditionall=
y.
>=20

I will send 4 patches again...

=46ollow our conclusion, I modified the launch manager patch to enabled=
 it
by default and provide a kernel module option for enable ec raw
behavior:

>From d590461aa239b6db646fe5bd9e10e5ebeba63df7 Mon Sep 17 00:00:00 2001
=46rom: Lee, Chun-Yi <jlee@novell.com>
Date: Sun, 31 Oct 2010 00:03:36 -0400
Subject: [PATCH 2/4] Enabled Acer Launch Manager mode

Enabled Acer Launch Manager mode to disable the EC raw behavior for
communication devices when WMID3 method available. And, we also add a
ec_raw_mode kernel module option for enable The EC raw behavior mode
when anyone what reset it back.
When Acer Launch Manager mode enabled, EC will stop to touch any
communication devices' RF state or power state that causes conflict
with rfkill_input or any userland daemon to charge the rfkill rules.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |  113
+++++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index 930df56..0b870d3 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -85,6 +85,7 @@ MODULE_LICENSE("GPL");
 #define AMW0_GUID2		"431F16ED-0C2B-444C-B267-27DEB140CF9C"
 #define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2		"95764E09-FB56-4e83-B31A-37761F60994A"
+#define WMID_GUID3		"61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
=20
 /*
  * Acer ACPI event GUIDs
@@ -120,6 +121,20 @@ struct event_return_value {
 	u32 reserved;
 } __attribute__((packed));
=20
+struct lm_input_params {
+	u8 function_num;	/* Function Number */
+	u16 commun_devices;	/* Communication type devices default status */
+	u16 devices;		/* Other type devices default status */
+	u8 lm_status;		/* Launch Manager Status */
+	u16 reserved;
+} __attribute__((packed));
+
+struct lm_return_value {
+	u8 error_code;		/* Error Code */
+	u8 ec_return_value;	/* EC Return Value */
+	u16 reserved;
+} __attribute__((packed));
+
 /*
  * Interface capability flags
  */
@@ -150,15 +165,18 @@ static int mailled =3D -1;
 static int brightness =3D -1;
 static int threeg =3D -1;
 static int force_series;
+static bool ec_raw_mode;
=20
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
 module_param(threeg, int, 0444);
 module_param(force_series, int, 0444);
+module_param(ec_raw_mode, bool, 0444);
 MODULE_PARM_DESC(mailled, "Set initial state of Mail LED");
 MODULE_PARM_DESC(brightness, "Set initial LCD backlight brightness");
 MODULE_PARM_DESC(threeg, "Set initial state of 3G hardware");
 MODULE_PARM_DESC(force_series, "Force a different laptop series");
+MODULE_PARM_DESC(ec_raw_mode, "Enable EC raw mode");
=20
 struct acer_data {
 	int mailled;
@@ -1393,6 +1411,87 @@ error_debugfs:
 	return -ENOMEM;
 }
=20
+static acpi_status
+wmid3_set_lm_mode(struct lm_input_params *params,
+			struct lm_return_value *return_value)
+{
+	acpi_status status;
+	union acpi_object *obj;
+
+	struct acpi_buffer input =3D { sizeof(struct lm_input_params), params=
 };
+	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status =3D wmi_evaluate_method(WMID_GUID3, 0, 0x1, &input, &output);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj =3D output.pointer;
+
+	if (!obj)
+		return -EINVAL;
+	else if (obj->type !=3D ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return -EINVAL;
+	}
+	if (obj->buffer.length !=3D 4) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	*return_value =3D *((struct lm_return_value *)obj->buffer.pointer);
+	kfree(obj);
+
+	return status;
+}
+
+static int acer_wmi_enable_ec_raw(void)
+{
+	struct lm_return_value return_value;
+	acpi_status status;
+	struct lm_input_params params =3D {
+		.function_num =3D 0x1,
+		.commun_devices =3D 0xFFFF,
+		.devices =3D 0xFFFF,
+		.lm_status =3D 0x00,		/* Launch Manager Deactive */
+	};
+
+	status =3D wmid3_set_lm_mode(&params, &return_value);
+
+	if (return_value.error_code || return_value.ec_return_value)
+		printk(ACER_WARNING "Enabling EC raw mode failed: "
+			"0x%x - 0x%x\n", return_value.error_code,
+			return_value.ec_return_value);
+	else
+		printk(ACER_INFO "Enabled EC raw mode");
+
+	return status;
+}
+
+static int acer_wmi_enable_lm(void)
+{
+	struct lm_return_value return_value;
+	acpi_status status;
+	struct lm_input_params params =3D {
+		.function_num =3D 0x1,
+		.commun_devices =3D 0x0041,	/* WiFi on, 3G on, BT off */
+		.devices =3D 0xFFFF,
+		.lm_status =3D 0x41,		/* Launch Manager Active */
+	};
+
+	status =3D wmid3_set_lm_mode(&params, &return_value);
+
+	if (return_value.error_code || return_value.ec_return_value)
+		printk(ACER_WARNING "Enabling Launch Manager failed: "
+			"0x%x - 0x%x\n", return_value.error_code,
+			return_value.ec_return_value);
+	else
+		printk(ACER_INFO "Enabled Launch Manager");
+
+	return status;
+}
+
 static int __init acer_wmi_init(void)
 {
 	int err;
@@ -1454,6 +1553,20 @@ static int __init acer_wmi_init(void)
 		       "generic video driver\n");
 	}
=20
+	if (wmi_has_guid(WMID_GUID3)) {
+		if (ec_raw_mode) {
+			if (ACPI_FAILURE(acer_wmi_enable_ec_raw())) {
+				printk(ACER_ERR "Cannot enable EC raw mode\n");
+				return -ENODEV;
+			}
+		} else if (ACPI_FAILURE(acer_wmi_enable_lm())) {
+			printk(ACER_ERR "Cannot enable Launch Manager mode\n");
+			return -ENODEV;
+		}
+	} else if (!wmi_has_guid(WMID_GUID3) && ec_raw_mode) {
+		printk(ACER_INFO "No WMID EC raw mode enable method\n");
+	}
+
 	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
 		err =3D acer_wmi_input_setup();
 		if (err)
--=20
1.6.0.2



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
