From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] Make PNP IDs all uppercase
Date: Tue, 20 Jan 2009 17:42:08 -0700
Message-ID: <200901201742.10155.bjorn.helgaas@hp.com>
References: <49733678.40006@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:36841 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbZAUAoI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2009 19:44:08 -0500
In-Reply-To: <49733678.40006@gmx.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Kohlbecher <xt28@gmx.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Vojtech Pavlik <vojtech@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, Hans Verkuil <hverkuil@xs4all.nl>, "David S. Miller" <davem@davemloft.net>, Jaroslav Kysela <perex@perex.cz>, Adam Belay <abelay@mit.edu>, Len Brown <lenb@kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org

On Sunday 18 January 2009 07:02:32 am Philipp Kohlbecher wrote:
> If I understand correctly, ACPI _HIDs (including PNP IDs) should be a=
ll=20
> uppercase, including the hex digits, cf. ACPI Specification 3.0b [1],=
=20
> pp. 162-3

Section 6.1.4, "_HID (Hardware ID)" says:

    A valid PNP ID must be of the form =E2=80=9CAAA####=E2=80=9D where =
A is an uppercase
    letter and # is a hex digit.  A valid ACPI ID must be of the form
    =E2=80=9CACPI####=E2=80=9D where # is a hex digit.

I don't see the part about requiring the hex digits to be uppercase.
Did I miss it, or is it somewhere else?

> and acpi_glb_hex_to_ascii[] in drivers/acpi/utilities/utglobal.c.=20
>=20
> Since compare_pnp_id() in drivers/pnp/driver.c is case-insensitive, t=
he=20
> case should only matter for the MODULE_DEVICE_TABLE and thus for modu=
le=20
> aliases, as modprobe uses fnmatch() to match aliases, which is=20
> case-sensitive. Therefore, using uppercase letters in PNP IDs can lea=
d=20
> to non-functional module aliases.

Your patch converts PNP IDs to uppercase, so you must mean that using
*lowercase* letters can lead to non-functional module aliases.

There are definitely some inconsistencies that it would be nice to
fix, if we can do it safely.  For example, for ISAPNP and PNPBIOS
devices, I think we always generate lowercase hex digits in the PNP
IDs.  For PNPACPI, we generate uppercase digits for numeric _HIDs,
but we use string _HIDs unchanged.

Did you trip over an actual problem that is fixed by this patch?  If
so, can you give any more details?

Bjorn


> This patch converts all PNP IDs to uppercase.
>=20
> [1] http://www.acpi.info/spec.htm
>=20
> Signed-off-by: Philipp Kohlbecher <xt28@gmx.de>
>=20
> ---
>=20
> I have successfully tested this patch for drivers/rtc/rtc-cmos.c.
>=20
> If you would rather have this as a series of patches, one per file, l=
et=20
> me know.
>=20
> I hope I did not forget any recipients and that I didn't spam anyone=20
> unnecessarily. If I did, I apologize.
>=20
>   arch/x86/kernel/rtc.c                 |    2 +-
>   drivers/input/gameport/ns558.c        |    6 ++--
>   drivers/input/serio/i8042-x86ia64io.h |   16 ++++++------
>   drivers/input/touchscreen/htcpen.c    |    2 +-
>   drivers/media/radio/radio-cadet.c     |    2 +-
>   drivers/net/3c509.c                   |    4 +-
>   drivers/net/irda/smsc-ircc2.c         |    2 +-
>   drivers/platform/x86/fujitsu-laptop.c |    2 +-
>   drivers/platform/x86/wmi.c            |    2 +-
>   drivers/pnp/quirks.c                  |    4 +-
>   drivers/pnp/system.c                  |    4 +-
>   drivers/rtc/rtc-cmos.c                |    6 ++--
>   sound/drivers/mpu401/mpu401.c         |    2 +-
>   sound/isa/cs423x/cs4236.c             |   42=20
> ++++++++++++++++----------------
>   sound/isa/gus/interwave.c             |    8 +++---
>   sound/isa/sb/sb16.c                   |   36 ++++++++++++++--------=
------
>   sound/isa/wavefront/wavefront.c       |    4 +-
>   sound/oss/sb_card.h                   |   10 ++++----
>   18 files changed, 77 insertions(+), 77 deletions(-)
>=20
> diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> index dd6f2b7..e9a7cac 100644
> --- a/arch/x86/kernel/rtc.c
> +++ b/arch/x86/kernel/rtc.c
> @@ -224,7 +224,7 @@ static __init int add_rtc_cmos(void)
>   {
>   #ifdef CONFIG_PNP
>   	static const char *ids[] __initconst =3D
> -	    { "PNP0b00", "PNP0b01", "PNP0b02", };
> +	    { "PNP0B00", "PNP0B01", "PNP0B02", };
>   	struct pnp_dev *dev;
>   	struct pnp_id *id;
>   	int i;
> diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/=
ns558.c
> index db556b7..5bc2c57 100644
> --- a/drivers/input/gameport/ns558.c
> +++ b/drivers/input/gameport/ns558.c
> @@ -171,11 +171,11 @@ static struct pnp_device_id pnp_devids[] =3D {
>   	{ .id =3D "@P@0020", .driver_data =3D 0 }, /* ALS 200 */
>   	{ .id =3D "@P@1001", .driver_data =3D 0 }, /* ALS 100+ */
>   	{ .id =3D "@P@2001", .driver_data =3D 0 }, /* ALS 120 */
> -	{ .id =3D "ASB16fd", .driver_data =3D 0 }, /* AdLib NSC16 */
> +	{ .id =3D "ASB16FD", .driver_data =3D 0 }, /* AdLib NSC16 */
>   	{ .id =3D "AZT3001", .driver_data =3D 0 }, /* AZT1008 */
>   	{ .id =3D "CDC0001", .driver_data =3D 0 }, /* Opl3-SAx */
>   	{ .id =3D "CSC0001", .driver_data =3D 0 }, /* CS4232 */
> -	{ .id =3D "CSC000f", .driver_data =3D 0 }, /* CS4236 */
> +	{ .id =3D "CSC000F", .driver_data =3D 0 }, /* CS4236 */
>   	{ .id =3D "CSC0101", .driver_data =3D 0 }, /* CS4327 */
>   	{ .id =3D "CTL7001", .driver_data =3D 0 }, /* SB16 */
>   	{ .id =3D "CTL7002", .driver_data =3D 0 }, /* AWE64 */
> @@ -188,7 +188,7 @@ static struct pnp_device_id pnp_devids[] =3D {
>   	{ .id =3D "OPT0001", .driver_data =3D 0 }, /* OPTi Audio16 */
>   	{ .id =3D "YMH0006", .driver_data =3D 0 }, /* Opl3-SA */
>   	{ .id =3D "YMH0022", .driver_data =3D 0 }, /* Opl3-SAx */
> -	{ .id =3D "PNPb02f", .driver_data =3D 0 }, /* Generic */
> +	{ .id =3D "PNPB02F", .driver_data =3D 0 }, /* Generic */
>   	{ .id =3D "", },
>   };
>=20
> diff --git a/drivers/input/serio/i8042-x86ia64io.h=20
> b/drivers/input/serio/i8042-x86ia64io.h
> index 6fa2def..9f531ae 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -510,7 +510,7 @@ static int i8042_pnp_aux_probe(struct pnp_dev *de=
v,=20
> const struct pnp_device_id *
>=20
>   static struct pnp_device_id pnp_kbd_devids[] =3D {
>   	{ .id =3D "PNP0303", .driver_data =3D 0 },
> -	{ .id =3D "PNP030b", .driver_data =3D 0 },
> +	{ .id =3D "PNP030B", .driver_data =3D 0 },
>   	{ .id =3D "", },
>   };
>=20
> @@ -523,13 +523,13 @@ static struct pnp_driver i8042_pnp_kbd_driver =3D=
 {
>   static struct pnp_device_id pnp_aux_devids[] =3D {
>   	{ .id =3D "FJC6000", .driver_data =3D 0 },
>   	{ .id =3D "FJC6001", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f03", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f0b", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f0e", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f12", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f13", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f19", .driver_data =3D 0 },
> -	{ .id =3D "PNP0f1c", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F03", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F0B", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F0E", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F12", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F13", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F19", .driver_data =3D 0 },
> +	{ .id =3D "PNP0F1C", .driver_data =3D 0 },
>   	{ .id =3D "SYN0801", .driver_data =3D 0 },
>   	{ .id =3D "", },
>   };
> diff --git a/drivers/input/touchscreen/htcpen.c=20
> b/drivers/input/touchscreen/htcpen.c
> index 62811de..eddfdc1 100644
> --- a/drivers/input/touchscreen/htcpen.c
> +++ b/drivers/input/touchscreen/htcpen.c
> @@ -48,7 +48,7 @@ module_param(invert_y, bool, 0644);
>   MODULE_PARM_DESC(invert_y, "If set, Y axis is inverted");
>=20
>   static struct pnp_device_id pnp_ids[] =3D {
> -	{ .id =3D "PNP0cc0" },
> +	{ .id =3D "PNP0CC0" },
>   	{ .id =3D "" }
>   };
>   MODULE_DEVICE_TABLE(pnp, pnp_ids);
> diff --git a/drivers/media/radio/radio-cadet.c=20
> b/drivers/media/radio/radio-cadet.c
> index cb3075a..7d29958 100644
> --- a/drivers/media/radio/radio-cadet.c
> +++ b/drivers/media/radio/radio-cadet.c
> @@ -592,7 +592,7 @@ static struct video_device cadet_radio =3D {
>=20
>   static struct pnp_device_id cadet_pnp_devices[] =3D {
>   	/* ADS Cadet AM/FM Radio Card */
> -	{.id =3D "MSM0c24", .driver_data =3D 0},
> +	{.id =3D "MSM0C24", .driver_data =3D 0},
>   	{.id =3D ""}
>   };
>=20
> diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
> index 535c234..8c2e86d 100644
> --- a/drivers/net/3c509.c
> +++ b/drivers/net/3c509.c
> @@ -402,8 +402,8 @@ static struct pnp_device_id el3_pnp_ids[] =3D {
>   	{ .id =3D "TCM5094" }, /* 3Com Etherlink III (combo) */
>   	{ .id =3D "TCM5095" }, /* 3Com Etherlink III (TPO) */
>   	{ .id =3D "TCM5098" }, /* 3Com Etherlink III (TPC) */
> -	{ .id =3D "PNP80f7" }, /* 3Com Etherlink III compatible */
> -	{ .id =3D "PNP80f8" }, /* 3Com Etherlink III compatible */
> +	{ .id =3D "PNP80F7" }, /* 3Com Etherlink III compatible */
> +	{ .id =3D "PNP80F8" }, /* 3Com Etherlink III compatible */
>   	{ .id =3D "" }
>   };
>   MODULE_DEVICE_TABLE(pnp, el3_pnp_ids);
> diff --git a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ir=
cc2.c
> index dd73cce..028e9c5 100644
> --- a/drivers/net/irda/smsc-ircc2.c
> +++ b/drivers/net/irda/smsc-ircc2.c
> @@ -365,7 +365,7 @@ static inline void register_bank(int iobase, int =
bank)
>=20
>   /* PNP hotplug support */
>   static const struct pnp_device_id smsc_ircc_pnp_table[] =3D {
> -	{ .id =3D "SMCf010", .driver_data =3D 0 },
> +	{ .id =3D "SMCF010", .driver_data =3D 0 },
>   	/* and presumably others */
>   	{ }
>   };
> diff --git a/drivers/platform/x86/fujitsu-laptop.c=20
> b/drivers/platform/x86/fujitsu-laptop.c
> index 65dc415..ee14b57 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -1284,7 +1284,7 @@=20
> MODULE_ALIAS("dmi:*:svnFUJITSUSIEMENS:*:pvr:rvnFUJITSU:rnFJNB1E6:*:cv=
rS6420:*");
>   MODULE_ALIAS("dmi:*:svnFUJITSU:*:pvr:rvnFUJITSU:rnFJNB19C:*:cvrS702=
0:*");
>=20
>   static struct pnp_device_id pnp_ids[] =3D {
> -	{.id =3D "FUJ02bf"},
> +	{.id =3D "FUJ02BF"},
>   	{.id =3D "FUJ02B1"},
>   	{.id =3D "FUJ02E3"},
>   	{.id =3D ""}
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 8a8b377..79b8af7 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -84,7 +84,7 @@ static int acpi_wmi_add(struct acpi_device *device)=
;
>=20
>   static const struct acpi_device_id wmi_device_ids[] =3D {
>   	{"PNP0C14", 0},
> -	{"pnp0c14", 0},
> +	{"PNP0C14", 0},
>   	{"", 0},
>   };
>   MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index 8473fe5..18c9335 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -325,8 +325,8 @@ static struct pnp_fixup pnp_fixups[] =3D {
>   	{"ADS7181", quirk_add_irq_optional_dependent_sets},
>   	{"AZT0002", quirk_add_irq_optional_dependent_sets},
>   	/* PnP resources that might overlap PCI BARs */
> -	{"PNP0c01", quirk_system_pci_resources},
> -	{"PNP0c02", quirk_system_pci_resources},
> +	{"PNP0C01", quirk_system_pci_resources},
> +	{"PNP0C02", quirk_system_pci_resources},
>   	{""}
>   };
>=20
> diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
> index 59b9092..36720df 100644
> --- a/drivers/pnp/system.c
> +++ b/drivers/pnp/system.c
> @@ -16,9 +16,9 @@
>=20
>   static const struct pnp_device_id pnp_dev_table[] =3D {
>   	/* General ID for reserving resources */
> -	{"PNP0c02", 0},
> +	{"PNP0C02", 0},
>   	/* memory controller */
> -	{"PNP0c01", 0},
> +	{"PNP0C01", 0},
>   	{"", 0}
>   };
>=20
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index b6d35f5..f20e5ec 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -1110,9 +1110,9 @@ static void cmos_pnp_shutdown(struct device *pd=
ev)
>   }
>=20
>   static const struct pnp_device_id rtc_ids[] =3D {
> -	{ .id =3D "PNP0b00", },
> -	{ .id =3D "PNP0b01", },
> -	{ .id =3D "PNP0b02", },
> +	{ .id =3D "PNP0B00", },
> +	{ .id =3D "PNP0B01", },
> +	{ .id =3D "PNP0B02", },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(pnp, rtc_ids);
> diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu=
401.c
> index 5b996f3..9bdd96e 100644
> --- a/sound/drivers/mpu401/mpu401.c
> +++ b/sound/drivers/mpu401/mpu401.c
> @@ -150,7 +150,7 @@ static struct platform_driver snd_mpu401_driver =3D=
 {
>   #define IO_EXTENT 2
>=20
>   static struct pnp_device_id snd_mpu401_pnpids[] =3D {
> -	{ .id =3D "PNPb006" },
> +	{ .id =3D "PNPB006" },
>   	{ .id =3D "" }
>   };
>=20
> diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
> index 019c940..d7c0f3b 100644
> --- a/sound/isa/cs423x/cs4236.c
> +++ b/sound/isa/cs423x/cs4236.c
> @@ -164,21 +164,21 @@ MODULE_DEVICE_TABLE(pnp, snd_cs4232_pnpbiosids)=
;
>   #define CS423X_ISAPNP_DRIVER	"cs4232_isapnp"
>   static struct pnp_card_device_id snd_cs423x_pnpids[] =3D {
>   	/* Philips PCA70PS */
> -	{ .id =3D "CSC0d32", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
NPb006"=20
> } } },
> +	{ .id =3D "CSC0D32", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
NPB006"=20
> } } },
>   	/* TerraTec Maestro 32/96 (CS4232) */
> -	{ .id =3D "CSC1a32", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSC1A32", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* HP Omnibook 5500 onboard */
>   	{ .id =3D "CSC4232", .devs =3D { { "CSC0000" }, { "CSC0002" }, {=20
> "CSC0003" } } },
>   	/* Unnamed CS4236 card (Made in Taiwan) */
>   	{ .id =3D "CSC4236", .devs =3D { { "CSC0000" }, { "CSC0010" }, {=20
> "CSC0003" } } },
>   	/* Turtle Beach TBS-2000 (CS4232) */
> -	{ .id =3D "CSC7532", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SCb006"=20
> } } },
> +	{ .id =3D "CSC7532", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SCB006"=20
> } } },
>   	/* Turtle Beach Tropez Plus (CS4232) */
> -	{ .id =3D "CSC7632", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
NPb006"=20
> } } },
> +	{ .id =3D "CSC7632", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
NPB006"=20
> } } },
>   	/* SIC CrystalWave 32 (CS4232) */
> -	{ .id =3D "CSCf032", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCF032", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* Netfinity 3000 on-board soundcard */
> -	{ .id =3D "CSCe825", .devs =3D { { "CSC0100" }, { "CSC0110" }, { "C=
SC010f"=20
> } } },
> +	{ .id =3D "CSCE825", .devs =3D { { "CSC0100" }, { "CSC0110" }, { "C=
SC010F"=20
> } } },
>   	/* --- */
>   	{ .id =3D "" }	/* end */
>   };
> @@ -196,9 +196,9 @@ static struct pnp_card_device_id snd_cs423x_pnpid=
s[] =3D {
>   	/* Digital PC 5000 Onboard - CS4236B */
>   	{ .id =3D "CSC0735", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
>   	/* some uknown CS4236B */
> -	{ .id =3D "CSC0b35", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSC0B35", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* Intel PR440FX Onboard sound */
> -	{ .id =3D "CSC0b36", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSC0B36", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* CS4235 on mainboard without MPU */
>   	{ .id =3D "CSC1425", .devs =3D { { "CSC0100" }, { "CSC0110" } } },
>   	/* Gateway E1000 Onboard CS4236B */
> @@ -206,7 +206,7 @@ static struct pnp_card_device_id snd_cs423x_pnpid=
s[] =3D {
>   	/* HP 6330 Onboard sound */
>   	{ .id =3D "CSC1525", .devs =3D { { "CSC0100" }, { "CSC0110" }, {=20
> "CSC0103" } } },
>   	/* Crystal Computer TidalWave128 */
> -	{ .id =3D "CSC1e37", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSC1E37", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* ACER AW37 - CS4235 */
>   	{ .id =3D "CSC4236", .devs =3D { { "CSC0000" }, { "CSC0010" }, {=20
> "CSC0003" } } },
>   	/* build-in soundcard in EliteGroup P5TX-LA motherboard - CS4237B =
*/
> @@ -234,35 +234,35 @@ static struct pnp_card_device_id=20
> snd_cs423x_pnpids[] =3D {
>   	/* IBM Aptiva 2137 E24 Onboard - CS4237B */
>   	{ .id =3D "CSC8037", .devs =3D { { "CSC0000" }, { "CSC0010" }, {=20
> "CSC0003" } } },
>   	/* IBM IntelliStation M Pro motherboard */
> -	{ .id =3D "CSCc835", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
> +	{ .id =3D "CSCC835", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
>   	/* Guillemot MaxiSound 16 PnP - CS4236B */
>   	{ .id =3D "CSC9836", .devs =3D { { "CSC0000" }, { "CSC0010" }, {=20
> "CSC0003" } } },
>   	/* Gallant SC-70P */
>   	{ .id =3D "CSC9837", .devs =3D { { "CSC0000" }, { "CSC0010" }, {=20
> "CSC0003" } } },
>   	/* Techmakers MF-4236PW */
> -	{ .id =3D "CSCa736", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCA736", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* TerraTec AudioSystem EWS64XL - CS4236B */
> -	{ .id =3D "CSCa836", .devs =3D { { "CSCa800" }, { "CSCa810" }, { "C=
SCa803"=20
> } } },
> +	{ .id =3D "CSCA836", .devs =3D { { "CSCA800" }, { "CSCA810" }, { "C=
SCA803"=20
> } } },
>   	/* TerraTec AudioSystem EWS64XL - CS4236B */
> -	{ .id =3D "CSCa836", .devs =3D { { "CSCa800" }, { "CSCa810" } } },
> +	{ .id =3D "CSCA836", .devs =3D { { "CSCA800" }, { "CSCA810" } } },
>   	/* ACER AW37/Pro - CS4235 */
> -	{ .id =3D "CSCd925", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCD925", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* ACER AW35/Pro - CS4237B */
> -	{ .id =3D "CSCd937", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCD937", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* CS4235 without MPU401 */
> -	{ .id =3D "CSCe825", .devs =3D { { "CSC0100" }, { "CSC0110" } } },
> +	{ .id =3D "CSCE825", .devs =3D { { "CSC0100" }, { "CSC0110" } } },
>   	/* Unknown SiS530 - CS4235 */
>   	{ .id =3D "CSC4825", .devs =3D { { "CSC0100" }, { "CSC0110" } } },
>   	/* IBM IntelliStation M Pro 6898 11U - CS4236B */
> -	{ .id =3D "CSCe835", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
> +	{ .id =3D "CSCE835", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
>   	/* IBM PC 300PL Onboard - CS4236B */
> -	{ .id =3D "CSCe836", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
> +	{ .id =3D "CSCE836", .devs =3D { { "CSC0000" }, { "CSC0010" } } },
>   	/* Some noname CS4236 based card */
> -	{ .id =3D "CSCe936", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCE936", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* CS4236B */
> -	{ .id =3D "CSCf235", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCF235", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* CS4236B */
> -	{ .id =3D "CSCf238", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
> +	{ .id =3D "CSCF238", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "C=
SC0003"=20
> } } },
>   	/* --- */
>   	{ .id =3D "" }	/* end */
>   };
> diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
> index 5faecfb..6bbf6f2 100644
> --- a/sound/isa/gus/interwave.c
> +++ b/sound/isa/gus/interwave.c
> @@ -142,19 +142,19 @@ static struct pnp_card_device_id=20
> snd_interwave_pnpids[] =3D {
>   	/* Gravis UltraSound Plug & Play */
>   	{ .id =3D "GRV0001", .devs =3D { { .id =3D "GRV0000" } } },
>   	/* STB SoundRage32 */
> -	{ .id =3D "STB011a", .devs =3D { { .id =3D "STB0010" } } },
> +	{ .id =3D "STB011A", .devs =3D { { .id =3D "STB0010" } } },
>   	/* MED3210 */
>   	{ .id =3D "DXP3201", .devs =3D { { .id =3D "DXP0010" } } },
>   	/* Dynasonic Pro */
>   	/* This device also have CDC1117:DynaSonix Pro Audio Effects Proce=
ssor */
>   	{ .id =3D "CDC1111", .devs =3D { { .id =3D "CDC1112" } } },
>   	/* Panasonic PCA761AW Audio Card */
> -	{ .id =3D "ADV55ff", .devs =3D { { .id =3D "ADV0010" } } },
> +	{ .id =3D "ADV55FF", .devs =3D { { .id =3D "ADV0010" } } },
>   	/* InterWave STB without TEA6330T */
> -	{ .id =3D "ADV550a", .devs =3D { { .id =3D "ADV0010" } } },
> +	{ .id =3D "ADV550A", .devs =3D { { .id =3D "ADV0010" } } },
>   #else
>   	/* InterWave STB with TEA6330T */
> -	{ .id =3D "ADV550a", .devs =3D { { .id =3D "ADV0010" }, { .id =3D "=
ADV0015" } } },
> +	{ .id =3D "ADV550A", .devs =3D { { .id =3D "ADV0010" }, { .id =3D "=
ADV0015" } } },
>   #endif
>   	{ .id =3D "" }
>   };
> diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
> index 2c201f7..65430f6 100644
> --- a/sound/isa/sb/sb16.c
> +++ b/sound/isa/sb/sb16.c
> @@ -161,12 +161,12 @@ static struct pnp_card_device_id snd_sb16_pnpid=
s[] =3D {
>   	/* Sound Blaster 16 PnP */
>   	{ .id =3D "CTL0029", .devs =3D { { "CTL0031" } } },
>   	/* Sound Blaster 16 PnP */
> -	{ .id =3D "CTL002a", .devs =3D { { "CTL0031" } } },
> +	{ .id =3D "CTL002A", .devs =3D { { "CTL0031" } } },
>   	/* Sound Blaster 16 PnP */
>   	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
> -	{ .id =3D "CTL002b", .devs =3D { { "CTL0031" } } },
> +	{ .id =3D "CTL002B", .devs =3D { { "CTL0031" } } },
>   	/* Sound Blaster 16 PnP */
> -	{ .id =3D "CTL002c", .devs =3D { { "CTL0031" } } },
> +	{ .id =3D "CTL002C", .devs =3D { { "CTL0031" } } },
>   	/* Sound Blaster Vibra16S */
>   	{ .id =3D "CTL0051", .devs =3D { { "CTL0001" } } },
>   	/* Sound Blaster Vibra16C */
> @@ -177,9 +177,9 @@ static struct pnp_card_device_id snd_sb16_pnpids[=
] =3D {
>   	/* but ct4131 on a sticker on the board.. */
>   	{ .id =3D "CTL0086", .devs =3D { { "CTL0041" } } },
>   	/* Sound Blaster Vibra16X */
> -	{ .id =3D "CTL00f0", .devs =3D { { "CTL0043" } } },
> +	{ .id =3D "CTL00F0", .devs =3D { { "CTL0043" } } },
>   	/* Sound Blaster 16 (Virtual PC 2004) */
> -	{ .id =3D "tBA03b0", .devs =3D { {.id=3D"PNPb003" } } },
> +	{ .id =3D "TBA03B0", .devs =3D { {.id=3D"PNPB003" } } },
>   #else  /* SNDRV_SBAWE defined */
>   	/* Sound Blaster AWE 32 PnP */
>   	{ .id =3D "CTL0035", .devs =3D { { "CTL0031" }, { "CTL0021" } } },
> @@ -204,31 +204,31 @@ static struct pnp_card_device_id snd_sb16_pnpid=
s[] =3D {
>   	/* Sound Blaster AWE 32 PnP */
>   	{ .id =3D "CTL0054", .devs =3D { { "CTL0031" }, { "CTL0021" } } },
>   	/* Sound Blaster AWE 32 PnP */
> -	{ .id =3D "CTL009a", .devs =3D { { "CTL0041" }, { "CTL0021" } } },
> +	{ .id =3D "CTL009A", .devs =3D { { "CTL0041" }, { "CTL0021" } } },
>   	/* Sound Blaster AWE 32 PnP */
> -	{ .id =3D "CTL009c", .devs =3D { { "CTL0041" }, { "CTL0021" } } },
> +	{ .id =3D "CTL009C", .devs =3D { { "CTL0041" }, { "CTL0021" } } },
>   	/* Sound Blaster 32 PnP */
> -	{ .id =3D "CTL009f", .devs =3D { { "CTL0041" }, { "CTL0021" } } },
> +	{ .id =3D "CTL009F", .devs =3D { { "CTL0041" }, { "CTL0021" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL009d", .devs =3D { { "CTL0042" }, { "CTL0022" } } },
> +	{ .id =3D "CTL009D", .devs =3D { { "CTL0042" }, { "CTL0022" } } },
>   	/* Sound Blaster AWE 64 PnP Gold */
> -	{ .id =3D "CTL009e", .devs =3D { { "CTL0044" }, { "CTL0023" } } },
> +	{ .id =3D "CTL009E", .devs =3D { { "CTL0044" }, { "CTL0023" } } },
>   	/* Sound Blaster AWE 64 PnP Gold */
> -	{ .id =3D "CTL00b2", .devs =3D { { "CTL0044" }, { "CTL0023" } } },
> +	{ .id =3D "CTL00B2", .devs =3D { { "CTL0044" }, { "CTL0023" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL00c1", .devs =3D { { "CTL0042" }, { "CTL0022" } } },
> +	{ .id =3D "CTL00C1", .devs =3D { { "CTL0042" }, { "CTL0022" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL00c3", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
> +	{ .id =3D "CTL00C3", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL00c5", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
> +	{ .id =3D "CTL00C5", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL00c7", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
> +	{ .id =3D "CTL00C7", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL00e4", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
> +	{ .id =3D "CTL00E4", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
>   	/* Sound Blaster AWE 64 PnP */
> -	{ .id =3D "CTL00e9", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
> +	{ .id =3D "CTL00E9", .devs =3D { { "CTL0045" }, { "CTL0022" } } },
>   	/* Sound Blaster 16 PnP (AWE) */
> -	{ .id =3D "CTL00ed", .devs =3D { { "CTL0041" }, { "CTL0070" } } },
> +	{ .id =3D "CTL00ED", .devs =3D { { "CTL0041" }, { "CTL0070" } } },
>   	/* Generic entries */
>   	{ .id =3D "CTLXXXX" , .devs =3D { { "CTL0031" }, { "CTL0021" } } }=
,
>   	{ .id =3D "CTLXXXX" , .devs =3D { { "CTL0041" }, { "CTL0021" } } }=
,
> diff --git a/sound/isa/wavefront/wavefront.c=20
> b/sound/isa/wavefront/wavefront.c
> index 4c095bc..b303cc5 100644
> --- a/sound/isa/wavefront/wavefront.c
> +++ b/sound/isa/wavefront/wavefront.c
> @@ -91,9 +91,9 @@ static int pnp_registered;
>=20
>   static struct pnp_card_device_id snd_wavefront_pnpids[] =3D {
>   	/* Tropez */
> -	{ .id =3D "CSC7532", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
nPb006"=20
> }, { "CSC0004" } } },
> +	{ .id =3D "CSC7532", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
NPB006"=20
> }, { "CSC0004" } } },
>   	/* Tropez+ */
> -	{ .id =3D "CSC7632", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
nPb006"=20
> }, { "CSC0004" } } },
> +	{ .id =3D "CSC7632", .devs =3D { { "CSC0000" }, { "CSC0010" }, { "P=
NPB006"=20
> }, { "CSC0004" } } },
>   	{ .id =3D "" }
>   };
>=20
> diff --git a/sound/oss/sb_card.h b/sound/oss/sb_card.h
> index 5535cff..3f6fb43 100644
> --- a/sound/oss/sb_card.h
> +++ b/sound/oss/sb_card.h
> @@ -37,13 +37,13 @@ static struct pnp_card_device_id sb_pnp_card_tabl=
e[] =3D {
>   	/* Sound Blaster 16 */
>   	{.id =3D "CTL0029", .driver_data =3D 0, .devs =3D { {.id=3D"CTL003=
1"}, } },
>   	/* Sound Blaster 16 */
> -	{.id =3D "CTL002a", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0031=
"}, } },
> +	{.id =3D "CTL002A", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0031=
"}, } },
>   	/* Sound Blaster 16 */
> -	{.id =3D "CTL002b", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0031=
"}, } },
> +	{.id =3D "CTL002B", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0031=
"}, } },
>   	/* Sound Blaster 16 */
> -	{.id =3D "CTL002c", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0031=
"}, } },
> +	{.id =3D "CTL002C", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0031=
"}, } },
>   	/* Sound Blaster 16 */
> -	{.id =3D "CTL00ed", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0041=
"}, } },
> +	{.id =3D "CTL00ED", .driver_data =3D 0, .devs =3D { {.id=3D"CTL0041=
"}, } },
>   	/* Sound Blaster 16 */
>   	{.id =3D "CTL0086", .driver_data =3D 0, .devs =3D { {.id=3D"CTL004=
1"}, } },
>   	/* Sound Blaster Vibra16S */
> @@ -141,7 +141,7 @@ static struct pnp_card_device_id sb_pnp_card_tabl=
e[] =3D {
>   						     {.id=3D"@X@2001"},
>   						     {.id=3D"@H@0001"}, } },
>   	/* Sound Blaster 16 (Virtual PC 2004) */
> -	{.id =3D "tBA03b0", .driver_data =3D 0, .devs =3D { {.id=3D"PNPb003=
"}, } },
> +	{.id =3D "TBA03B0", .driver_data =3D 0, .devs =3D { {.id=3D"PNPB003=
"}, } },
>   	/* -end- */
>   	{.id =3D "", }
>   };
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
