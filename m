From: Johannes Berg <johannes@sipsolutions.net>
Subject: bug in evdev_disconnect
Date: Fri, 27 Apr 2007 16:26:30 +0200
Message-ID: <1177683991.3565.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

I'm getting the following when I remove ohci_hcd under some
circumstances on current kernels:

Apr 27 15:48:42 johannes kernel: [26859.791480] Unable to handle kernel paging request for data at address 0x6b6b6b6b
Apr 27 15:48:42 johannes kernel: [26859.791602] Faulting instruction address: 0xf1020e10
Apr 27 15:48:42 johannes kernel: [26859.791655] Oops: Kernel access of bad area, sig: 11 [#1]
Apr 27 15:48:42 johannes kernel: [26859.791660] PREEMPT 
Apr 27 15:48:42 johannes kernel: [26859.791665] Modules linked in: usbmon tun mol af_packet binfmt_misc hci_usb radeon drm rfcomm
 l2cap bluetooth snd_powermac configfs nls_utf8 hfsplus nls_base fuse dm_snapshot dm_mirror sha256 joydev eth1394 snd_aoa_codec_t
as snd_aoa_fabric_layout snd_aoa usbhid pcmcia snd_aoa_i2sbus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc bcm43xx 
ieee80211softmac ieee80211 ieee80211_crypt arc4 snd rc80211_simple soundcore snd_aoa_soundbus ohci1394 ieee1394 bcm43xx_mac80211 
ehci_hcd yenta_socket rsrc_nonstatic ohci_hcd firmware_class pcmcia_core ssb usbcore mac80211 uninorth_agp agpgart cfg80211 evdev
 unix
Apr 27 15:48:42 johannes kernel: [26859.791755] NIP: F1020E10 LR: F1020E08 CTR: 00000000
Apr 27 15:48:42 johannes kernel: [26859.791762] REGS: e9fabbd0 TRAP: 0300   Not tainted  (2.6.21-rc7-g45dd8a7f-dirty)
Apr 27 15:48:42 johannes kernel: [26859.791769] MSR: 00009032 <EE,ME,IR,DR>  CR: 24008288  XER: 00000000
Apr 27 15:48:42 johannes kernel: [26859.791782] DAR: 6B6B6B6B, DSISR: 40000000
Apr 27 15:48:42 johannes kernel: [26859.791788] TASK = ee88b240[26008] 'rmmod' THREAD: e9faa000
Apr 27 15:48:42 johannes kernel: [26859.791794] GPR00: F1020E08 E9FABC80 EE88B240 EEB552A0 C00096BC 00000011 89989F80 0000186D 
Apr 27 15:48:42 johannes kernel: [26859.791809] GPR08: C8522140 6B6B6B6B 24008444 10000000 00000000 1001A2A8 22204422 00000000 
Apr 27 15:48:42 johannes kernel: [26859.791825] GPR16: 1025DE08 100D0000 100B0000 100D0000 00000000 100B0000 10013008 00000000 
Apr 27 15:48:42 johannes kernel: [26859.791840] GPR24: 7F943CC0 FFFFFFED EDBDF30C EF4A52A0 F25613A8 6B6B675B ED718D74 ED718DA4 
Apr 27 15:48:42 johannes kernel: [26859.791857] NIP [F1020E10] evdev_disconnect+0x98/0xf0 [evdev]
Apr 27 15:48:42 johannes kernel: [26859.791878] LR [F1020E08] evdev_disconnect+0x90/0xf0 [evdev]
Apr 27 15:48:42 johannes kernel: [26859.791889] Call Trace:
Apr 27 15:48:42 johannes kernel: [26859.791894] [E9FABC80] [F1020E08] evdev_disconnect+0x90/0xf0 [evdev] (unreliable)
Apr 27 15:48:42 johannes kernel: [26859.791908] [E9FABCA0] [C022A4CC] input_unregister_device+0xf0/0x198
Apr 27 15:48:42 johannes kernel: [26859.791929] [E9FABCC0] [C02415C4] hidinput_disconnect+0x38/0x6c
Apr 27 15:48:42 johannes kernel: [26859.791944] [E9FABCE0] [F25614A0] hid_disconnect+0xf8/0x118 [usbhid]
Apr 27 15:48:42 johannes kernel: [26859.791963] [E9FABCF0] [F22163D0] usb_unbind_interface+0x5c/0xb4 [usbcore]
Apr 27 15:48:42 johannes kernel: [26859.792028] [E9FABD20] [C01EEE0C] __device_release_driver+0x88/0xc8
Apr 27 15:48:42 johannes kernel: [26859.792042] [E9FABD30] [C01EF47C] device_release_driver+0x4c/0x8c
Apr 27 15:48:42 johannes kernel: [26859.792052] [E9FABD40] [C01EE634] bus_remove_device+0x90/0xbc
Apr 27 15:48:42 johannes kernel: [26859.792062] [E9FABD50] [C01EC260] device_del+0x180/0x228
Apr 27 15:48:42 johannes kernel: [26859.792071] [E9FABD70] [F2213230] usb_disable_device+0xa8/0x148 [usbcore]
Apr 27 15:48:42 johannes kernel: [26859.792099] [E9FABD90] [F220EAF8] usb_disconnect+0xbc/0x1a4 [usbcore]
Apr 27 15:48:42 johannes kernel: [26859.792124] [E9FABDC0] [F220EAE0] usb_disconnect+0xa4/0x1a4 [usbcore]
Apr 27 15:48:42 johannes kernel: [26859.792149] [E9FABDF0] [F2211B44] usb_remove_hcd+0xb4/0x12c [usbcore]
Apr 27 15:48:42 johannes kernel: [26859.792174] [E9FABE10] [F221D5A0] usb_hcd_pci_remove+0x28/0x90 [usbcore]
Apr 27 15:48:42 johannes kernel: [26859.792203] [E9FABE20] [C0199C40] pci_device_remove+0x38/0x74
Apr 27 15:48:42 johannes kernel: [26859.792215] [E9FABE30] [C01EEE0C] __device_release_driver+0x88/0xc8
Apr 27 15:48:42 johannes kernel: [26859.792226] [E9FABE40] [C01EF618] driver_detach+0x15c/0x19c
Apr 27 15:48:42 johannes kernel: [26859.792235] [E9FABE60] [C01EE8A0] bus_remove_driver+0x8c/0xc8
Apr 27 15:48:42 johannes kernel: [26859.792245] [E9FABE80] [C01EF6B0] driver_unregister+0x18/0x40
Apr 27 15:48:42 johannes kernel: [26859.792255] [E9FABEA0] [C0199EF0] pci_unregister_driver+0x20/0x9c
Apr 27 15:48:42 johannes kernel: [26859.792265] [E9FABEC0] [F20AED20] ohci_hcd_mod_exit+0x18/0x9c8 [ohci_hcd]
Apr 27 15:48:42 johannes kernel: [26859.792286] [E9FABED0] [C00532D4] sys_delete_module+0x1ac/0x210
Apr 27 15:48:42 johannes kernel: [26859.792298] [E9FABF40] [C0011534] ret_from_syscall+0x0/0x38
Apr 27 15:48:42 johannes kernel: [26859.792311] --- Exception: c01 at 0xff6e1b8
Apr 27 15:48:42 johannes kernel: [26859.792321]     LR = 0x10001214
Apr 27 15:48:42 johannes kernel: [26859.792325] Instruction dump:
Apr 27 15:48:42 johannes kernel: [26859.792333] 387f0040 38800001 38a00001 38c00000 480008a9 813f004c 3bff004c 3ba9fbf0 
Apr 27 15:48:42 johannes kernel: [26859.792358] 48000010 480008a5 813d0410 3ba9fbf0 <801d0410> 2f800000 419e0008 7c00022c 


Obviously there's a use-after-free condition, but I can't really make
out where it is. The disassembly seems to point to
                list_for_each_entry(list, &evdev->list, node)
                        kill_fasync(&list->fasync, SIGIO, POLL_HUP);
in evdev_disconnect.

Has somebody seen this before? It seems to happen only if userspace has
the device open or so.

johannes
