From: Jeff Smith <lkml.sepix@code.wastedcycles.net>
Subject: Re: [kmemcheck] WARNING: kmemcheck: Caught 32-bit read from uninitialized
 memory, in  hid_output_report
Date: Sun, 30 Aug 2009 22:38:34 +0100
Message-ID: <4A9AF15A.5080402@code.wastedcycles.net>
References: <4A9833D3.3040202@code.wastedcycles.net>
Reply-To: lkml.sepix@code.wastedcycles.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010507010408030909080403"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from thinkula.hx3.notconnected.net ([192.207.141.44]:60976 "EHLO
	sardonic.codimension.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZH3VoF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2009 17:44:05 -0400
In-Reply-To: <4A9833D3.3040202@code.wastedcycles.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Vegard Nossum <vegardno@ifi.uio.no>

This is a multi-part message in MIME format.
--------------010507010408030909080403
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jeff Smith wrote (on lkml):
> A kmemcheck warning on booting my 2.6.31-rc8 (I haven't tried previous versions -- this was 
> actually not the problem I set out to fix).
> 
> I can send Jiri (Bcc'ed) or the list a .config if it will help.

I looked at this a bit more and it seems that hid-core.c:implement() does a 64-bit read
even when it is not necessary. Admittedly it writes back the same bits
(modulo the ones it is trying to change), so in theory no harm should
be done provided the "extra" read neither runs off allocated memory nor 
the end of the current page boundary, nor ... 

A patch follows. It corrects a typo in the comment, changes the function name "implement" to
"set_into_le_bitstream", changes the parameter name "n" to "bitfield_size", printk's
unsigned using %u not %d, and only does a 32-bit read-modify-write when a 64-bit one 
is not necessary.

A patch that writes only the bytes that need to be changed, rather
than 32 or 64-bit quantities that potentially access irrelevant memory locations -- and
that therefore require more complicated verification logic -- would be a better approach.
However, as we are at -rc8 already and I don't fully understand the structures that are
being changed, or the reasons the code is as it is, I didn't feel confident about 
presenting such a restructuring here.

Could someone from the list give the attached patch a quick look please, and check
I have not made any elementary endian errors or otherwise (although it does appear to 
work for me).

Thanks
Jeff

PS. I am not on the list, so please Bcc: me direct on lkml.sepix <at> code.wastedcycles.net
 
> Jeff
> 
> WARNING: kmemcheck: Caught 32-bit read from uninitialized memory (f6626624)
> 0100000001000000000000000000000000000000000000000000000000000000
>  i u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u
>          ^
> 
> Pid: 1, comm: swapper Not tainted (2.6.31-rc8-MOAT51 #2) ProLiant ML110 G5
> EIP: 0060:[<c16e8d31>] EFLAGS: 00010046 CPU: 0
> EIP is at hid_output_report+0x181/0x310
> EAX: 00000001 EBX: ffffffff ECX: 00000000 EDX: 00000001
> ESI: f6626620 EDI: 00000000 EBP: f711fc4c ESP: c1db160c
>  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> CR0: 8005003b CR2: f676d4fc CR3: 01da4000 CR4: 00002650
> DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> DR6: ffff4ff0 DR7: 00000400
>  [<c16f39cd>] __usbhid_submit_report+0x12d/0x290
>  [<c16f3b68>] usbhid_submit_report+0x38/0x50
>  [<c16f3d1c>] usbhid_set_leds+0x9c/0xd0
>  [<c16f44a7>] usbhid_start+0x627/0x670
>  [<c16e93c2>] hid_device_probe+0x82/0xd0
>  [<c14ca5dd>] driver_probe_device+0x6d/0x180
>  [<c14ca7d1>] __device_attach+0x41/0x50
>  [<c14c9bbb>] bus_for_each_drv+0x5b/0x80
>  [<c14ca873>] device_attach+0x63/0x70
>  [<c14c9997>] bus_attach_device+0x47/0x70
>  [<c14c8219>] device_add+0x539/0x680
>  [<c16e9025>] hid_add_device+0x165/0x1d0
>  [<c16f2cd9>] hid_probe+0x269/0x3d0
>  [<c165b006>] usb_probe_interface+0x86/0x140
>  [<c14ca5dd>] driver_probe_device+0x6d/0x180
>  [<c14ca781>] __driver_attach+0x91/0xa0
>  [<c14c9e9b>] bus_for_each_dev+0x5b/0x80
>  [<c14ca479>] driver_attach+0x19/0x20
>  [<c14c97d7>] bus_add_driver+0x247/0x300
>  [<c14caa15>] driver_register+0x75/0x170
>  [<c165ae07>] usb_register_driver+0x87/0x110
>  [<c1d42fbf>] hid_init+0x9f/0xc2
>  [<c1001033>] do_one_initcall+0x23/0x190
>  [<c1d0d345>] kernel_init+0x144/0x19d
>  [<c1025cc7>] kernel_thread_helper+0x7/0x10
>  [<ffffffff>] 0xffffffff


--------------010507010408030909080403
Content-Type: text/plain;
 name="hid-core.c-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hid-core.c-patch"

--- hid-core.c	2009-08-30 16:48:32.000000000 +0100
+++ hid-core.c-dist	2009-08-28 01:59:04.000000000 +0100
@@ -767,14 +767,19 @@
  * The data mangled in the bit stream remains in little endian
  * order the whole time. It make more sense to talk about
  * endianness of register values by considering a register
- * a "cached" copy of the little endian bit stream.
+ * a "cached" copy of the little endiad bit stream.
  */
-static __inline__ void set_into_le_bitstream(__u8 *report, unsigned offset, unsigned bitfield_size, __u32 value)
+static __inline__ void implement(__u8 *report, unsigned offset, unsigned n, __u32 value)
 {
-	u64 m = (1ULL << bitfield_size) - 1;
+	u64 x;
+	u64 m = (1ULL << n) - 1;
+
+	if (n > 32)
+		printk(KERN_WARNING "HID: implement() called with n (%d) > 32! (%s)\n",
+				n, current->comm);
 
 	if (value > m)
-		printk(KERN_WARNING "HID: set_into_le_bitstream() value (%u) too big for bitfield for %s\n",
+		printk(KERN_WARNING "HID: implement() called with too large value %d! (%s)\n",
 				value, current->comm);
 	WARN_ON(value > m);
 	value &= m;
@@ -782,23 +787,10 @@
 	report += offset >> 3;
 	offset &= 7;
 
-        if (bitfield_size > 32) {
-            u64 x;
-
-            printk(KERN_WARNING "HID: set_into_le_bitstream() called with bitfield_size %u > 32 for %s\n",
-                   bitfield_size, current->comm);
-            x = get_unaligned_le64(report);
-            x &= ~(m << offset);
-            x |= ((u64)value) << offset;
-            put_unaligned_le64(x, report);
-        } else {
-            u32 x;
-
-            x = get_unaligned_le32(report);
-            x &= ~(m << offset);
-            x |= value << offset;
-            put_unaligned_le32(x, report);
-        }
+	x = get_unaligned_le64(report);
+	x &= ~(m << offset);
+	x |= ((u64)value) << offset;
+	put_unaligned_le64(x, report);
 }
 
 /*
@@ -959,9 +951,9 @@
 
 	for (n = 0; n < count; n++) {
 		if (field->logical_minimum < 0)	/* signed values */
-			set_into_le_bitstream(data, offset + n * size, size, s32ton(field->value[n], size));
+			implement(data, offset + n * size, size, s32ton(field->value[n], size));
 		else				/* unsigned values */
-			set_into_le_bitstream(data, offset + n * size, size, field->value[n]);
+			implement(data, offset + n * size, size, field->value[n]);
 	}
 }
 

--------------010507010408030909080403--
