From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Enabling "extra" scancodes on some Acer laptops
Date: Sun, 14 Oct 2007 18:03:08 +0100
Message-ID: <200710141803.09039.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dimitry,

Here's an interesting one for you. With a few newer Acer laptops, a problem 
with some of the extra/ multimedia keys has been cropping up - they don't 
emit scancodes by default. The solution found was to resurrect an old quirk 
from acerhk to turn them on (acerhk calls this "enabling dritek keyboard 
extension"):

/*
 * Keyboard controller ports
 */
#define ACER_KBD_STATUS_REG	0x64	/* Status register (R) */
#define ACER_KBD_CNTL_REG	0x64	/* Controller command register (W) */
#define ACER_KBD_DATA_REG	0x60	/* Keyboard data register (R/W) */

/*
 * Wait for the keyboard controller to become ready
 */
static int wait_kbd_write(void)
{
	int i = 0;
	while ((inb(ACER_KBD_STATUS_REG) & 0x02) && (i < 10000)) {
		udelay(50);
		i++;
	}
	return -(i == 10000);
}

static void send_kbd_cmd(u8 cmd, u8 val)
{
	preempt_disable();
	if (!wait_kbd_write())
		outb(cmd, ACER_KBD_CNTL_REG);
	if (!wait_kbd_write())
		outb(val, ACER_KBD_DATA_REG);
	preempt_enable_no_resched();
}

static void set_keyboard_quirk(void)
{
	send_kbd_cmd(0x59, 0x90);
}

After calling set_keyboard_quirk(), the extra keys start generating proper 
scancodes, and can be mapped as normal via setkeycodes.

At the moment, I've added this quirk to acer_acpi (it's currently only applied 
on the few systems we know that need it via DMI matching), but I'm not really 
sure if this is the right place for it as:

1) acer_acpi is still out of tree

2) Does this really belong in acer_acpi (I'm not really sure if it falls under 
what I'm doing - this seems to border a bit too much on the input tree side), 
or somewhere further up the input tree (wistron-btns isn't much use here, as 
the quirk would then be limited to 32 bit only, whereas some of the machines 
that need this quirk can run a 64 bit kernel)?

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
