From: Justin Waters <justin.waters@timesys.com>
Subject: [PATCH 0/2] Atmel AT91SAM9RL Touchscreen Driver
Date: Fri, 25 Apr 2008 14:56:36 -0400
Message-ID: <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <>
References: <>
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

The following patches are for touchscreen support on the AT91SAM9RL SoC from
Atmel.  It contains an integrated touchscreen/adc controller (tsadcc).  These
patches initialize it an configure it purely as a touchscreen driver.

The first patch adds the driver to the kernel tree.

The second patch adds board and cpu specific functionality pertaining to the
AT91SAM9RL SoC and AT91SAM9RL-EK board.

These both apply to a mainline 2.6.25 kernel.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
