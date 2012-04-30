From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 5/6] hid-multitouch: Switch to device groups
Date: Mon, 30 Apr 2012 16:58:44 +0200
Message-ID: <CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
	<1335175627-2270-6-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38262 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab2D3O6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 10:58:45 -0400
In-Reply-To: <1335175627-2270-6-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <Benjamin_Tissoires@logitech.com>, Stephane Chatty <chatty@enac.fr>

Hi Henrik,

though I was not able to test it with the devices we have, I remarked
a small regression in this patch: the detection of the serial protocol
is not handled anymore. I was indeed relying on the fact that the
parameter "id" in mt_probe was null to know that the device was not
already in the list of known devices. I think that this small pitfall
can be assessed in a separate commit later (after more testing) to
keep the patch clear.

By looking at the whole code of the patch set, Acked-by: Benjamin
Tissoires <benjamin.tissoires@gmail.com>

I'll tell you by the end of the week if anything goes wrong with our
multitouch devices, but I don't see any reasons why it could fail.

Thanks for the work Henrik,
Benjamin

On Mon, Apr 23, 2012 at 12:07, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Switch the driver over to device group handling. =A0By adding the
> HID_GROUP_MULTITOUCH group to hid-core, hid-generic will no longer
> match multitouch devices. =A0By adding the HID_GROUP_MULTITOUCH entry=
 to
> the device list, hid-multitouch will match all unknown multitouch
> devices, and udev will automatically load the module.
>
> Since HID_QUIRK_MULTITOUCH never gets set, the special quirks handlin=
g
> can be removed. =A0Since all HID MT devices have HID_DG_CONTACTID, th=
ey
> can be removed from the hid_have_special_driver list.
>
> Cc: Benjamin Tissoires <Benjamin_Tissoires@logitech.com>
> Cc: Stephane Chatty <chatty@lii-enac.fr>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 75 +++-------------------=
--------------------
> =A0drivers/hid/hid-input.c =A0 =A0 =A0| =A0 11 -------
> =A0drivers/hid/hid-multitouch.c | =A0 =A03 +-
> =A0include/linux/hid.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A04 files changed, 7 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cb5a103..0a107fe 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -660,6 +660,8 @@ static u8 *fetch_item(__u8 *start, __u8 *end, str=
uct hid_item *item)
>
> =A0static void hid_scan_usage(struct hid_device *hid, u32 usage)
> =A0{
> + =A0 =A0 =A0 if (usage =3D=3D HID_DG_CONTACTID)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid->group =3D HID_GROUP_MULTITOUCH;
> =A0}
>
> =A0/*
> @@ -1350,10 +1352,6 @@ int hid_connect(struct hid_device *hdev, unsig=
ned int connect_mask)
> =A0 =A0 =A0 =A0if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput=
_connect(hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0connec=
t_mask & HID_CONNECT_HIDINPUT_FORCE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev->claimed |=3D HID_CLAIMED_INPUT;
> - =A0 =A0 =A0 if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this device should be handled by hid=
-multitouch, skip it */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hidde=
v_connect &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!hdev->hiddev_connect(=
hdev,
> @@ -1430,13 +1428,10 @@ EXPORT_SYMBOL_GPL(hid_disconnect);
>
> =A0/* a list of devices for which there is a specialized driver on HI=
D bus */
> =A0static const struct hid_device_id hid_have_special_driver[] =3D {
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M1968=
) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_3M, USB_DEVICE_ID_3M2256=
) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A=
4TECH_WCP32PU) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A=
4TECH_X5_005D) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A=
4TECH_RP_649) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ACTIONSTAR, USB_DEVICE_I=
D_ACTIONSTAR_1011) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_AP=
PLE_ATV_IRCONTROL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_AP=
PLE_IRCONTROL4) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_AP=
PLE_MIGHTYMOUSE) },
> @@ -1501,60 +1496,32 @@ static const struct hid_device_id hid_have_sp=
ecial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE=
_ID_APPLE_ALU_WIRELESS_2011_ISO) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_AP=
PLE_FOUNTAIN_TP_ONLY) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_AP=
PLE_GEYSER1_TP_ONLY) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS=
_T91MT) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS=
TEK_MULTITOUCH_YFO) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_F=
LIP_KVM) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_=
EMPREX_REMOTE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, USB_DEVICE_ID_BTC_=
EMPREX_REMOTE_2) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAN=
DO_PIXCIR_MULTI_TOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAN=
DO_MULTI_TOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAN=
DO_MULTI_TOUCH_10_1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAN=
DO_MULTI_TOUCH_11_6) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CANDO, USB_DEVICE_ID_CAN=
DO_MULTI_TOUCH_15_6) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_C=
HERRY_CYMOTION) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_C=
HERRY_CYMOTION_SOLAR) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_=
CHICONY_TACTICAL_PAD) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_=
CHICONY_WIRELESS) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_=
CHICONY_WIRELESS2) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT, USB_DEVICE_ID=
_CHUNGHWAT_MULTITOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVIC=
E_ID_PRODIKEYS_PCMIDI) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CVTOUCH, USB_DEVICE_ID_C=
VTOUCH_SCREEN) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_=
CYPRESS_BARCODE_1) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_=
CYPRESS_BARCODE_2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_=
CYPRESS_BARCODE_3) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_=
CYPRESS_MOUSE) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_C=
YPRESS_TRUETOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_480D) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_480E) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_720C) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_7224) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_725E) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_726B) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_72A1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_7302) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH_A001) },
> =A0 =A0 =A0 =A0{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVIC=
E_ID_ELECOM_BM084) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_T=
S2515) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_=
TRIO_LINKER_PLUS_II) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BT=
C_8193) },
> - =A0 =A0 =A0 { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_FRUCTEL, USB_DEVIC=
E_ID_GAMETEL_MT_MODE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_=
GAMERON_DUAL_PSX_ADAPTOR) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_=
GAMERON_DUAL_PCS_ADAPTOR) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, USB_DEVIC=
E_ID_GENERAL_TOUCH_WIN7_TWOFINGERS) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH, USB_DEVICE_ID=
_GOODTOUCH_000f) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID=
_GYRATION_REMOTE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID=
_GYRATION_REMOTE_2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID=
_GYRATION_REMOTE_3) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_HANVON, USB_DEVICE_ID_HA=
NVON_MULTITOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT, USB_DEVICE_I=
D_HANVON_ALT_MULTITOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_I=
DEACOM_IDC6650) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_H=
OLTEK_ON_LINE_GRIP) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ILITEK, USB_DEVICE_ID_IL=
ITEK_MULTITOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS, USB_DEVI=
CE_ID_IRTOUCH_INFRARED_USB) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_=
ID_KS_SLIMBLADE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID=
_KEYTOUCH_IEC) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_=
ERGO_525V) },
> @@ -1563,7 +1530,6 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_=
EASYPEN_M610X) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_L=
ABTEC_WIRELESS_KEYBOARD) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_=
LCPOWER_LC1000 ) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MUL=
TITOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_MX3000_RECEIVER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_S510_RECEIVER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_S510_RECEIVER_2) },
> @@ -1596,8 +1562,6 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_RUMBLEPAD2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_SPACETRAVELLER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_SPACENAVIGATOR) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LUMIO, USB_DEVICE_ID_CRY=
STALTOUCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LUMIO, USB_DEVICE_ID_CRY=
STALTOUCH_DUAL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_I=
D_PICOLCD) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_I=
D_PICOLCD_BOOTLOADER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_I=
D_MS_COMFORT_MOUSE_4500) },
> @@ -1629,15 +1593,8 @@ static const struct hid_device_id hid_have_spe=
cial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NT=
RIG_TOUCH_SCREEN_18) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_OR=
TEK_PKB1700) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_OR=
TEK_WKB2000) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PANASONIC, USB_DEVICE_ID=
_PANABOARD_UBT780) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PANASONIC, USB_DEVICE_ID=
_PANABOARD_UBT880) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_=
PENMOUNT_PCI) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID=
_PETALYNX_MAXTER_REMOTE) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PI=
XART_OPTICAL_TOUCH_SCREEN) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PI=
XART_OPTICAL_TOUCH_SCREEN1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PI=
XART_OPTICAL_TOUCH_SCREEN2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_P=
RIMAX_KEYBOARD) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QU=
ANTA_OPTICAL_TOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_P=
IXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_R=
OCCAT_KONE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_R=
OCCAT_ARVO) },
> @@ -1654,9 +1611,6 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SON=
Y_NAVIGATION_CONTROLLER) },
> =A0 =A0 =A0 =A0{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_=
ID_SONY_PS3_CONTROLLER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SON=
Y_VAIO_VGX_MOUSE) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_STANTUM, USB_DEVICE_ID_M=
TP) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_=
ID_MTP_STM) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SITRONIX, USB_DE=
VICE_ID_MTP_SITRONIX) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_=
SUNPLUS_WDESKTOP) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) }=
,
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) }=
,
> @@ -1670,16 +1624,12 @@ static const struct hid_device_id hid_have_sp=
ecial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIV=
O_SLIDE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_=
TOPSEED_CYBERLINK) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2, USB_DEVICE_ID=
_TOPSEED2_RF_COMBO) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_TOUCH_INTL, USB_DEVICE_I=
D_TOUCH_INTL_MULTI_TOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_=
TWINHAN_IR_REMOTE) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TU=
RBOX_TOUCHSCREEN_MOSART) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_=
UCLOGIC_TABLET_PF1209) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_=
UCLOGIC_TABLET_WP4030U) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_=
UCLOGIC_TABLET_WP5540U) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_=
UCLOGIC_TABLET_WP8060U) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_=
UCLOGIC_TABLET_WP1062) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UN=
ITEC_USB_TOUCH_0709) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UN=
ITEC_USB_TOUCH_0A19) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_I=
D_SMARTJOY_PLUS) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_I=
D_SUPER_JOY_BOX_3) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_I=
D_DUAL_USB_JOYPAD) },
> @@ -1694,16 +1644,6 @@ static const struct hid_device_id hid_have_spe=
cial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_W=
ALTOP_PID_0038) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_W=
ALTOP_MEDIA_TABLET_10_6_INCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_W=
ALTOP_MEDIA_TABLET_14_1_INCH) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XAT, USB_DEVICE_ID_XAT_C=
SR) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_SPX) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_MPX) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_CSR) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_SPX1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_MPX1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_CSR1) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_SPX2) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_MPX2) },
> - =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XI=
ROKU_CSR2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_=
ID_SPEEDLINK_VAD_CEZANNE) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
> @@ -1796,10 +1736,6 @@ static int hid_bus_match(struct device *dev, s=
truct device_driver *drv)
> =A0 =A0 =A0 =A0struct hid_driver *hdrv =3D container_of(drv, struct h=
id_driver, driver);
> =A0 =A0 =A0 =A0struct hid_device *hdev =3D container_of(dev, struct h=
id_device, dev);
>
> - =A0 =A0 =A0 if ((hdev->quirks & HID_QUIRK_MULTITOUCH) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 !strncmp(hdrv->name, "hid-multitouch", =
14))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> -
> =A0 =A0 =A0 =A0return hid_match_device(hdev, hdrv) !=3D NULL;
> =A0}
>
> @@ -1817,11 +1753,8 @@ static int hid_device_probe(struct device *dev=
)
> =A0 =A0 =A0 =A0if (!hdev->driver) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0id =3D hid_match_device(hdev, hdrv);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (id =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!((hdev->quirks & H=
ID_QUIRK_MULTITOUCH) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !strncm=
p(hdrv->name, "hid-multitouch", 14))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto un=
lock;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev->driver =3D hdrv;
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 002781c..7b43186 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -638,10 +638,6 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map_key_clear(BTN_STYL=
US2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x51: /* ContactID */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->quirks |=3D HID=
_QUIRK_MULTITOUCH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unknown;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default: =A0goto unknown;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -1208,13 +1204,6 @@ int hidinput_connect(struct hid_device *hid, u=
nsigned int force)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (hid->quirks & HID_QUIRK_MULTITOUCH) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* generic hid does not know how to han=
dle multitouch devices */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hidinput)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_cleanup;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unwind;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (hidinput && input_register_device(hidinput->input)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_cleanup;
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 1d5b941..125c1e7 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -654,7 +654,6 @@ static int mt_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
> =A0 =A0 =A0 =A0 * that emit events over several HID messages.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
> - =A0 =A0 =A0 hdev->quirks &=3D ~HID_QUIRK_MULTITOUCH;
>
> =A0 =A0 =A0 =A0td =3D kzalloc(sizeof(struct mt_device), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!td) {
> @@ -999,6 +998,8 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_XIROKU,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_XIROKU_C=
SR2) },
>
> + =A0 =A0 =A0 /* Generic MT device */
> + =A0 =A0 =A0 { HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY=
_ID, HID_ANY_ID) },
> =A0 =A0 =A0 =A0{ }
> =A0};
> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index dd694fb..2c7a195 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -317,7 +317,6 @@ struct hid_item {
> =A0#define HID_QUIRK_BADPAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x00000020
> =A0#define HID_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00000040
> =A0#define HID_QUIRK_HIDINPUT_FORCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00080
> -#define HID_QUIRK_MULTITOUCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000100
> =A0#define HID_QUIRK_SKIP_OUTPUT_REPORTS =A0 =A0 =A0 =A0 =A00x0001000=
0
> =A0#define HID_QUIRK_FULLSPEED_INTERVAL =A0 =A0 =A0 =A0 =A0 0x1000000=
0
> =A0#define HID_QUIRK_NO_INIT_REPORTS =A0 =A0 =A0 =A0 =A0 =A0 =A00x200=
00000
> @@ -328,6 +327,7 @@ struct hid_item {
> =A0* HID device groups
> =A0*/
> =A0#define HID_GROUP_GENERIC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x0001
> +#define HID_GROUP_MULTITOUCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
002
>
> =A0/*
> =A0* This is the global environment of the parser. This information i=
s
> --
> 1.7.10
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
