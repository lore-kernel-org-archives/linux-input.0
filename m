From: Yanko Kaneti <yaneti@declera.com>
Subject: Re: 2.6.25-rc5.git4 regression PS/2 mouse not detected/working
Date: Wed, 02 Apr 2008 02:17:31 +0300
Message-ID: <1207091851.3306.6.camel@d2>
References: <1205775229.25146.11.camel@indigo.declera.com>
	 <20080317145429.ZZRA012@mailhub.coreip.homeip.net>
	 <1205780323.25146.13.camel@indigo.declera.com>
	 <20080318114711.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ldtJN03lnC0BXqtRYpov"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from indigo.declera.com ([212.116.131.21]:44012 "HELO
	indigo.declera.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754114AbYDAXRg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Apr 2008 19:17:36 -0400
In-Reply-To: <20080318114711.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--=-ldtJN03lnC0BXqtRYpov
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2008-03-18 at 11:54 -0400, Dmitry Torokhov wrote:
> On Mon, Mar 17, 2008 at 08:58:43PM +0200, Yanko Kaneti wrote:
> > On Mon, 2008-03-17 at 14:55 -0400, Dmitry Torokhov wrote:
> > > On Mon, Mar 17, 2008 at 07:33:49PM +0200, Yanko Kaneti wrote:
> > > >
> > > > My PS/2 mouse stops being detected between kernels 2.6.24.3-12.fc8 and
> > > > 2.6.25-0.121.rc5.git4.fc9 (which I believe do not carry any patches in
> > > > that area). Its an ASUS P5E-VM DO motherboard , bios revision 0506. The
> > > > PS/2 keyboard still works.
> > > > 
> > > > Attached are both dmesg logs with i8042.debug=1, dmidecode, lspci -vvnn
> > > > Tried i8042.noloop and both the mouse and keyboard stop working.
> > > > 
> > > 
> > > Could you please send me dmesg from booting with i8042.noloop. I would
> > > expect this option to help in your case so I am curious what went wrong.
> > 
> > Attached
> > 
> 
> Hmm, it looks the kernel does the right thing in case of i8042.noloop,
> except that it does not work :(. Kernel triest to query the mouse but
> it does not respond.
> 
> Can you try taking contents of drivers/input/serio from 2.6.25 and
> copy it in .24? It will most likely compile... If that works I'm
> afraid I will ahve to ask you to do git biscect to find the offending
> commit.

Hey again,

I finally did the bisecting. It found the cuplrit to be

commit e3f37a54f690d3e64995ea7ecea08c5ab3070faf
Author: Balaji Rao <balajirrao@gmail.com>
Date:   Wed Jan 30 13:30:03 2008 +0100

    x86: assign IRQs to HPET timers
    

I tried reverting the change on the latest git with the attached patch
and my mouse and keyboard appear to be detected and working fine now.
The patch had to be stiched by hand and due to my lack of understanding
of the code might be breaking random other stuff.

FWIW the bios on this board has no knobs for HPET that I could find.

What gives?



--=-ldtJN03lnC0BXqtRYpov
Content-Disposition: attachment; filename=linux-2.6-revert-hpet-irq.patch
Content-Type: text/x-patch; name=linux-2.6-revert-hpet-irq.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ur a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c	2008-04-01 23:43:46.000000000 +0300
+++ b/arch/x86/kernel/hpet.c	2008-04-02 00:20:46.000000000 +0300
@@ -117,8 +117,7 @@
 static void hpet_reserve_platform_timers(unsigned long id)
 {
 	struct hpet __iomem *hpet = hpet_virt_address;
-	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
-	unsigned int nrtimers, i;
+	unsigned int nrtimers;
 	struct hpet_data hd;
 
 	nrtimers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
@@ -136,9 +135,6 @@
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-       for (i = 2; i < nrtimers; timer++, i++)
-	       hd.hd_irq[i] = (timer->hpet_config & Tn_INT_ROUTE_CNF_MASK) >>
-		       Tn_INT_ROUTE_CNF_SHIFT;
 	hpet_alloc(&hd);
 }
 #else
diff -ur a/drivers/char/hpet.c b/drivers/char/hpet.c
--- a/drivers/char/hpet.c	2008-04-01 23:43:46.000000000 +0300
+++ b/drivers/char/hpet.c	2008-04-02 00:30:50.000000000 +0300
@@ -731,14 +731,14 @@
 
 int hpet_alloc(struct hpet_data *hdp)
 {
-	u64 cap, mcfg, hpet_config;
+	u64 cap, mcfg;
 	struct hpet_dev *devp;
-	u32 i, ntimer, irq;
+	u32 i, ntimer;
 	struct hpets *hpetp;
 	size_t siz;
 	struct hpet __iomem *hpet;
 	static struct hpets *last = NULL;
-	unsigned long period, irq_bitmap;
+	unsigned long period;
 	unsigned long long temp;
 
 	/*
@@ -767,45 +767,8 @@
 	hpetp->hp_ntimer = hdp->hd_nirqs;
 	hpet = hpetp->hp_hpet;
 
-	/* Assign IRQs statically for legacy devices */
-	hpetp->hp_dev[0].hd_hdwirq = hdp->hd_irq[0];
-	hpetp->hp_dev[1].hd_hdwirq = hdp->hd_irq[1];
-
-	/* Assign IRQs dynamically for the others */
-	for (i = 2, devp = &hpetp->hp_dev[2]; i < hdp->hd_nirqs; i++, devp++) {
-		struct hpet_timer __iomem *timer;
-
-		timer = &hpet->hpet_timers[devp - hpetp->hp_dev];
-
-		/* Check if there's already an IRQ assigned to the timer */
-		if (hdp->hd_irq[i]) {
-			hpetp->hp_dev[i].hd_hdwirq = hdp->hd_irq[i];
-			continue;
-		}
-
-		hpet_config = readq(&timer->hpet_config);
-		irq_bitmap = (hpet_config & Tn_INT_ROUTE_CAP_MASK)
-			>> Tn_INT_ROUTE_CAP_SHIFT;
-		if (!irq_bitmap)
-			irq = 0;        /* No valid IRQ Assignable */
-		else {
-			irq = find_first_bit(&irq_bitmap, 32);
-			do {
-				hpet_config |= irq << Tn_INT_ROUTE_CNF_SHIFT;
-				writeq(hpet_config, &timer->hpet_config);
-
-				/*
-				 * Verify whether we have written a valid
-				 * IRQ number by reading it back again
-				 */
-				hpet_config = readq(&timer->hpet_config);
-				if (irq == (hpet_config & Tn_INT_ROUTE_CNF_MASK)
-						>> Tn_INT_ROUTE_CNF_SHIFT)
-					break;  /* Success */
-			} while ((irq = (find_next_bit(&irq_bitmap, 32, irq))));
-		}
-		hpetp->hp_dev[i].hd_hdwirq = irq;
-	}
+	for (i = 0; i < hdp->hd_nirqs; i++)
+		hpetp->hp_dev[i].hd_hdwirq = hdp->hd_irq[i];
 
 	cap = readq(&hpet->hpet_cap);
 
@@ -836,8 +799,7 @@
 		hpetp->hp_which, hdp->hd_phys_address,
 		hpetp->hp_ntimer > 1 ? "s" : "");
 	for (i = 0; i < hpetp->hp_ntimer; i++)
-		printk("%s %d", i > 0 ? "," : "",
-				hpetp->hp_dev[i].hd_hdwirq);
+		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
 	printk("\n");
 
 	printk(KERN_INFO "hpet%u: %u %d-bit timers, %Lu Hz\n",

--=-ldtJN03lnC0BXqtRYpov--

