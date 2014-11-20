From: Anders Kaseorg <andersk@mit.edu>
Subject: Bisected two-finger scrolling regression on Lenovo Y50 (Re: [PATCH
 1/5] Input: elantech - use elantech_report_trackpoint for hardware v4 too)
Date: Thu, 20 Nov 2014 01:58:40 -0500
Message-ID: <546D9120.1040703@mit.edu>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org> <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:53358 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751932AbaKTHDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 02:03:53 -0500
In-Reply-To: <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On 08/30/2014 10:10 AM, Ulrik De Bie wrote:
> The Fujitsu H730 has hardware v4 with a trackpoint. This enables
> the elantech_report_trackpoint for v4.

Kernel 3.18-rc5 has made two-finger scrolling unusably glitchy on my=20
Lenovo Y50-70 Touch, and caused an associated kernel warning.  I=20
bisected the regression to this commit (caeb0d37).

This may be the same as https://bugzilla.redhat.com/1165390, although=20
that only reports the warning, not the glitchy scrolling.

Anders

psmouse serio1: elantech: assuming hardware version 4 (with firmware=20
version 0x495f01)
psmouse serio1: elantech: Synaptics capabilities query result 0x70,=20
0x15, 0x0e.
input: ETPS/2 Elantech Touchpad as=20
/devices/platform/i8042/serio1/input/input6

[=E2=80=A6]

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/input/mouse/elantech.c:433=20
elantech_report_trackpoint.isra.5+0x199/0x1b0 [psmouse]()
psmouse serio1: elantech: Unexpected trackpoint message
Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_na=
t=20
nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack=20
nf_conntrack ipt_REJECT xt_tcpudp iptable_filter ip_tables x_tables=20
bridge stp llc ctr ccm binfmt_misc bbswitch(OE) arc4 nls_iso8859_1=20
iwlmvm snd_hda_codec_hdmi mac80211 snd_hda_codec_realtek=20
snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec=20
intel_rapl uvcvideo snd_hwdep x86_pkg_temp_thermal videobuf2_vmalloc=20
intel_powerclamp snd_pcm videobuf2_memops videobuf2_core coretemp=20
v4l2_common snd_seq_midi videodev kvm_intel snd_seq_midi_event iwlwifi=20
media kvm joydev btusb snd_rawmidi serio_raw bluetooth cfg80211=20
hid_multitouch rtsx_pci_ms memstick snd_seq snd_seq_device snd_timer=20
ideapad_laptop mei_me sparse_keymap mei snd ie31200_edac
  lpc_ich mac_hid edac_core soundcore shpchp parport_pc ppdev lp parpor=
t=20
autofs4 btrfs xor raid6_pq dm_crypt hid_generic usbhid hid=20
rtsx_pci_sdmmc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel=20
aesni_intel i915 aes_x86_64 lrw gf128mul i2c_algo_bit glue_helper=20
ablk_helper drm_kms_helper cryptd psmouse ahci r8169 drm rtsx_pci=20
libahci mii wmi video
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE  3.17.0+ #2
Hardware name: LENOVO 20349/Lenovo Y50-70 Touch, BIOS 9ECN30WW(V1.13)=20
07/16/2014
  0000000000000009 ffff88045f203cb0 ffffffff8277a436 ffff88045f203cf8
  ffff88045f203ce8 ffffffff8207144d ffff88044352ea00 ffff880448b044f0
  ffff880035da6400 0000000000000002 ffff88044352ea00 ffff88045f203d48
Call Trace:
  <IRQ>  [<ffffffff8277a436>] dump_stack+0x45/0x56
  [<ffffffff8207144d>] warn_slowpath_common+0x7d/0xa0
  [<ffffffff820714bc>] warn_slowpath_fmt+0x4c/0x50
  [<ffffffffc0185309>] elantech_report_trackpoint.isra.5+0x199/0x1b0=20
[psmouse]
  [<ffffffffc0185af8>] elantech_process_byte+0x6e8/0xf90 [psmouse]
  [<ffffffffc017bd45>] psmouse_handle_byte+0x15/0x150 [psmouse]
  [<ffffffffc017bf1f>] psmouse_interrupt+0x9f/0x360 [psmouse]
  [<ffffffff825c2d06>] serio_interrupt+0x46/0x90
  [<ffffffff825c44f7>] i8042_interrupt+0x197/0x3a0
  [<ffffffff820c8477>] handle_irq_event_percpu+0x77/0x1a0
  [<ffffffff820c85dd>] handle_irq_event+0x3d/0x60
  [<ffffffff820cb316>] handle_edge_irq+0x66/0x130
  [<ffffffff8201576e>] handle_irq+0x1e/0x40
  [<ffffffff8278522d>] do_IRQ+0x4d/0xe0
  [<ffffffff827830ad>] common_interrupt+0x6d/0x6d
  <EOI>  [<ffffffff82614965>] ? cpuidle_enter_state+0x65/0x160
  [<ffffffff82614b47>] cpuidle_enter+0x17/0x20
  [<ffffffff820b1dc7>] cpu_startup_entry+0x387/0x3c0
  [<ffffffff8276f5f7>] rest_init+0x77/0x80
  [<ffffffff82d45f9b>] start_kernel+0x461/0x46e
  [<ffffffff82d45120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff82d454d7>] x86_64_start_reservations+0x2a/0x2c
  [<ffffffff82d4561c>] x86_64_start_kernel+0x143/0x152
---[ end trace b67972f4dffebd79 ]---
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x06 , 0xe3 , 0x26 , 0x01 , 0xf3 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x09 , 0xbd , 0x26 , 0x00 , 0xe5 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0b , 0x90 , 0x36 , 0xfb , 0xb7 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0c , 0x84 , 0x36 , 0xfe , 0x9e ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x0c , 0x94 , 0x26 , 0x00 , 0x99 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x05 , 0x98 , 0x26 , 0x00 , 0x99 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0d , 0xba , 0x36 , 0xfd , 0xb3 ]
psmouse serio1: elantech: PS/2 packet [
  0x50 , 0x00 , 0x19 , 0x26 , 0x00 , 0x1c ]
psmouse serio1: elantech: PS/2 packet [
  0x50 , 0x04 , 0x1b , 0x26 , 0x00 , 0x19 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x11 , 0x46 , 0x36 , 0x01 , 0x53 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x09 , 0x48 , 0x36 , 0x0d , 0x39 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0b , 0x30 , 0x36 , 0x06 , 0x30 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0d , 0x2e , 0x36 , 0x06 , 0x2c ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0a , 0x1c , 0x36 , 0x01 , 0x18 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x07 , 0x17 , 0x36 , 0x06 , 0x11 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x01 , 0x0b , 0x36 , 0x04 , 0x07 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x02 , 0x03 , 0x36 , 0x02 , 0x02 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x03 , 0xfe , 0x26 , 0x02 , 0xfd ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x00 , 0xf8 , 0x26 , 0x01 , 0xfb ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x00 , 0x02 , 0x36 , 0x00 , 0x01 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x01 , 0x09 , 0x26 , 0xff , 0x02 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x07 , 0x18 , 0x36 , 0x00 , 0x07 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x0e , 0x3d , 0x36 , 0x0b , 0x29 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x1d , 0x6f , 0x36 , 0x19 , 0x5f ]
psmouse serio1: elantech: PS/2 packet [
  0x50 , 0x06 , 0x19 , 0x26 , 0x05 , 0x1a ]
psmouse serio1: elantech: PS/2 packet [
  0x50 , 0x07 , 0x1a , 0x26 , 0x06 , 0x18 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x26 , 0x6d , 0x36 , 0x1e , 0x6f ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x27 , 0x5f , 0x36 , 0x1f , 0x62 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x18 , 0x36 , 0x36 , 0x1c , 0x38 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x19 , 0x2a , 0x36 , 0x1b , 0x27 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x13 , 0x19 , 0x36 , 0x11 , 0x14 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x09 , 0x06 , 0x36 , 0x09 , 0x06 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x01 , 0xfd , 0x26 , 0x07 , 0xf5 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x00 , 0xf9 , 0x26 , 0x0a , 0xf1 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x03 , 0xd1 , 0x26 , 0x07 , 0xd0 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x06 , 0xe5 , 0x26 , 0x08 , 0xd6 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x04 , 0xf6 , 0x26 , 0x06 , 0xe8 ]
psmouse serio1: elantech: PS/2 packet [
  0x44 , 0x02 , 0xfd , 0x26 , 0x04 , 0xf1 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x11 , 0x1d , 0x36 , 0x0e , 0x0b ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x16 , 0x2b , 0x36 , 0x18 , 0x18 ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x24 , 0x5a , 0x36 , 0x25 , 0x3c ]
psmouse serio1: elantech: PS/2 packet [
  0x40 , 0x28 , 0x53 , 0x36 , 0x1d , 0x4e ]

> Reported-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Stefan Valouch <stefan@valouch.com>
> Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> ---
>   drivers/input/mouse/elantech.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index da51738..f0a55b4d 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -792,6 +792,9 @@ static int elantech_packet_check_v4(struct psmous=
e *psmouse)
>   	unsigned char packet_type =3D packet[3] & 0x03;
>   	bool sanity_check;
>
> +	if ((packet[3]&0x0f) =3D=3D 0x06)
> +		return PACKET_TRACKPOINT;
> +
>   	/*
>   	 * Sanity check based on the constant bits of a packet.
>   	 * The constant bits change depending on the value of
> @@ -877,10 +880,19 @@ static psmouse_ret_t elantech_process_byte(stru=
ct psmouse *psmouse)
>
>   	case 4:
>   		packet_type =3D elantech_packet_check_v4(psmouse);
> -		if (packet_type =3D=3D PACKET_UNKNOWN)
> +		switch (packet_type) {
> +		case PACKET_UNKNOWN:
>   			return PSMOUSE_BAD_DATA;
>
> -		elantech_report_absolute_v4(psmouse, packet_type);
> +		case PACKET_TRACKPOINT:
> +			elantech_report_trackpoint(psmouse, packet_type);
> +			break;
> +
> +		default:
> +			elantech_report_absolute_v4(psmouse, packet_type);
> +			break;
> +		}
> +
>   		break;
>   	}
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
