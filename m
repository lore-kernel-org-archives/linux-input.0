From: "Liang, Dan" <Dan.Liang@atmel.com>
Subject: [PATCH 0/2] Atmel Touchscreen Driver
Date: Mon, 14 Jul 2008 04:04:08 +0200
Message-ID: <0F5F73E36031FD46AD3F2E6948F0C0A020866B@frimb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: dmitry.torokhov@gmail.com, linux@maxim.org.za
List-Id: linux-input@vger.kernel.org

Support internal Touch Screen Controller on AT91SAM9RL SoC of Atmel
(probably be used on AVR32 in the future).

Thank Justin for his work:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/40961

The main difference between the new driver and the old one is using the
integrated timer instead of the hrtimer.

The first patch adds the driver to the kernel tree.

The second patch adds board and cpu specific functionality pertaining to
the
AT91SAM9RL SoC and AT91SAM9RL-EK board.

Best Regards

Dan Liang

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
