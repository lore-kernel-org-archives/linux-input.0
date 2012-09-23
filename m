From: Josip Rodin <joy@debbugs.entuzijast.net>
Subject: Bug#685360: [PATCH 1/1] HID: Fix missing Unifying device issue
Date: Sun, 23 Sep 2012 12:23:18 +0200
Message-ID: <20120923102318.GA12946@entuzijast.net>
References: <1348222894-6767-1-git-send-email-nlopezcasad@logitech.com>
Reply-To: Josip Rodin <joy@debbugs.entuzijast.net>, 685360@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Sender: Josip Rodin <joy@entuzijast.net>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.685360.B685360.134839580628873@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <1348222894-6767-1-git-send-email-nlopezcasad@logitech.com>
Sender: Josip Rodin <joy@entuzijast.net>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 685360@bugs.debian.org, john.ettedgui@gmail.com, barz621@gmail.com, dh.herrmann@googlemail.com
List-Id: linux-input@vger.kernel.org

On Fri, Sep 21, 2012 at 12:21:34PM +0200, Nestor Lopez Casado wrote:
> This patch fixes an issue introduced after commit 4ea5454203d991ec
> 
> After that commit, hid-core silently discards any incoming packet
> that arrives while any hid driver's probe function is being executed.

I managed to test this now, on top of Linux 3.5, but it didn't fix my
keyboard. I still get the same sequence of messages with hid.debug=1:

+usb 5-2: new full-speed USB device number 3 using ohci_hcd
+drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
+drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 0
+drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 0
+drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
+drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 1
+drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 1
+drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 2
+drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 2
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0110 wIndex=0x0002 wLength=7
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0111 wIndex=0x0002 wLength=20
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0120 wIndex=0x0002 wLength=15
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0121 wIndex=0x0002 wLength=32
+logitech-djreceiver 0003:046D:C52B.0005: claimed by neither input, hiddev nor hidraw
+logitech-djreceiver 0003:046D:C52B.0005: logi_dj_probe:hid_hw_start returned error

-- 
     2. That which causes joy or happiness.
