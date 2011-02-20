From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/2] Fix sending Output reports to the Sony Sixaxis
Date: Sun, 20 Feb 2011 18:26:44 +0100
Message-ID: <1298222806-19433-1-git-send-email-ospite@studenti.unina.it>
References: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:47352 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab1BTR1L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Feb 2011 12:27:11 -0500
In-Reply-To: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-bluetooth@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>, Bastien Nocera <hadess@hadess.net>, Alan Ott <alan@signal11.us>, Jim Paris <jim@jtan.com>, "pascal@pabr.org" <pascal@pabr.org>

Hi,

an Output report is used to set LEDs on the Sony Sixaxis controller, but
the device is quite picky about how it wants the Output report to be
sent, so these patches attempt to overcome the Sixaxis deficiencies.

The first patch is OK to apply, even for 2.6.38 I think.

For the second one I'd really like an actual test with other devices
supporting HID Output reports over BT, I don't want to break anything
even if the change looks sane as per the BT HID specification.

Something equivalent to the second patch should be implemented as an
override in hid-sony.c as well, in order to be protected from future
improvements to hidp_output_raw_report(), but for that to work I need to
make hidp_send_ctrl_message() public and I don't know if you'll like
that, we'll see in a patch to come.

Antonio Ospite (2):
  hid-sony.c: Fix sending Output reports to the Sixaxis
  bt hidp: send Output reports using SET_REPORT on the Control channel

 drivers/hid/hid-sony.c    |   20 ++++++++++++++++++++
 net/bluetooth/hidp/core.c |    2 +-
 2 files changed, 21 insertions(+), 1 deletions(-)


FYI, this is how I am setting leds on the Sixaxis, the same code works
with hidraw via usb and bluetooth after the patches above are applied:

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define LED_1 (0x01 << 1)
#define LED_2 (0x01 << 2)
#define LED_3 (0x01 << 3)
#define LED_4 (0x01 << 4)

void set_leds(int fd, unsigned char led_status[4])
{
	int ret;
	unsigned char change_leds[] = {
		0x01,
		0x00, 0x00, 0x00, 0x00, 0x00, // rumble values TBD.
		0x00, 0x00, 0x00, 0x00, 0x1e,
		0xff, 0x27, 0x10, 0x00, 0x32, // LED 4
		0xff, 0x27, 0x10, 0x00, 0x32, // LED 3
		0xff, 0x27, 0x10, 0x00, 0x32, // LED 2
		0xff, 0x27, 0x10, 0x00, 0x32, // LED 1
		0x00, 0x00, 0x00, 0x00, 0x00,
	};


	int led = 0;
	if (led_status[0])
		led |= LED_1;
	if (led_status[1])
		led |= LED_2;
	if (led_status[2])
		led |= LED_3;
	if (led_status[3])
		led |= LED_4;

	printf("led: 0x%02x\n", led);

	change_leds[10] = led;

	ret = write(fd, change_leds, sizeof(change_leds));
	if (ret < (ssize_t) sizeof(change_leds)) {
		close(fd);
		perror("Unable to write to hidraw device");
		exit(EXIT_FAILURE);
	}
}

int main(int argc, char *argv[])
{
	int fd;
	unsigned char led_status[4] = { 1, 0, 0, 0 };

	if (argc != 2) {
		fprintf(stderr, "usage: %s </dev/hidrawX>\n", argv[0]);
		exit(1);
	}

	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		perror("open");
		exit(1);
	}

	set_leds(fd, led_status);

	return 0;
}

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
