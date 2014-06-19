From: Hans de Goede <hdegoede@redhat.com>
Subject: Mapping of F11 and F12 on new lenovo laptops and Lenovo Compact Keyboard
Date: Thu, 19 Jun 2014 10:41:21 +0200
Message-ID: <53A2A231.4030700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757862AbaFSIlj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 04:41:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>, Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ao2@ao2.it>
Cc: linux-usb <linux-input@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>

Hi Jamie,

I saw your patch-set for the Lenovo Compact Keyboard on the lwn.net
kernel page.

This spiked my interest as I'm the author of this patch:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/thinkpad_acpi.c?id=8b9dd4fab26a0f328420cbda0845a325f45bcd92

Which adds mapping for the F9 - F12 on the Lenovo *40 series
laptops, which have the same weird symbols on F11 and F12 as the
Lenovo Compact Keyboard, the ones which you describe as:

/* Fn-F11: View open applications (3 boxes) */
/* Fn-F12: Open My computer (6 boxes) USB-only */

You map these to:
KEY_FN_F11
KEY_FILE

Where as my (already merged into Linus tree) patch maps these to:

KEY_SCALE
KEY_COMPUTER

Which are defined in linux/uapi/input.h as:

#define KEY_SCALE               120     /* AL Compiz Scale (Expose) */
#define KEY_COMPUTER            157

Which I believe maps closes to View open applications (which to me
sounds like expose mode) and Open My computer.

Note that on the laptops the keys have their special meaning by
default and using Fn turns them back into normal F11 keys, so
KEY_FN_F11 seems like a particular bad match as that suggests
a key combo which it is not on the laptops.

Anyways lets discuss and coordinate, so that we end up with the
same mappings for the weird symbols on F11 and F12 for the laptops
and for the Lenovo Compact Keyboard.

Regards,

Hans

