From: Chris Moeller <kode54@gmail.com>
Subject: Re: [PATCH v2 0/1] Input: xpad - Implement wireless controller LED
 setting and fix connect time LED setting
Date: Fri, 30 Nov 2012 20:13:29 -0800
Message-ID: <20121130201329.3f8aefa0@umaro.lan>
References: <20121130135406.38c9bdc9@umaro.lan>
	<1994333.0mnJMZMWGT@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2LAEON (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2012 23:14:13 -0500
In-Reply-To: <1994333.0mnJMZMWGT@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 30 Nov 2012 14:30:23 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Chris,
> 
> On Friday, November 30, 2012 01:54:06 PM Chris Moeller wrote:
> > I've submitted versions of this with prior patch sets, and this part
> > was never accepted, possibly because it depended on other patches to
> > work, or possibly because it wasn't so cleanly organized. This time,
> > I've split the LED setting command off into its own static function,
> > then call that on controller connect and optionally on LED setting
> > commands. The static function does not include any locking, because
> > locking inside the function which receives the incoming packets
> > deadlocks the driver, and does not appear to be necessary anyway.
> > 
> > It also removes all traces of the original bulk out function which
> > was designed for the purpose of setting the LED status on connect,
> > as I found that it actually does not work at all. It appears to try
> > to send the data, but nothing actually happens to the controller
> > LEDs.
> 
> Attached is a reply I sent to on 7/4/11 to which you unfortunately
> never responded. The issue is that of force feedback (rumble) and LED
> share the same URB then access to that URB should be arbitrated. The
> attached message contains a patch that attempts to implement that
> arbitration, could you please try it out and see what changes are
> needed to make it work?
> 
> Thanks.
> 

So sorry I missed your reply. That's what I get for filtering the
mailing list messages past my inbox, then never following up on my
filter/folder set for replies to my own messages. I recall you
mentioned that potential race condition when I first submitted, but I
forgot to do anything about it. I'm glad at least one of us has our
stuff together. It seems to work just fine, but there may be a force
feedback issue with the following test program, where it leaves the
effect playing indefinitely after the program terminates, and then the
controller itself ceases to respond until the module is removed and
reloaded.

---

#include <unistd.h>
#include <fcntl.h>
#include <linux/input.h>
#include <signal.h>

int running;

void interrupt(int sig)
{
	(void)sig;
	running = 0;
}

int main(void)
{
	int fd = open("/dev/input/event13", O_RDWR);

	struct ff_effect effect;

	struct input_event play;

	effect.type = FF_RUMBLE;
	effect.id = -1;
	effect.u.rumble.strong_magnitude = 0x2F00;
	effect.u.rumble.weak_magnitude = 0x1500;
	effect.replay.length = 2000;
	effect.replay.delay = 0;

	ioctl(fd, EVIOCSFF, &effect);

	play.type = EV_FF;
	play.code = effect.id;

	running = 1;

	signal(SIGINT, interrupt);

	while (running)
	{
		play.value = 1;
	
		write(fd, (const void *) &play, sizeof(play));
	
		usleep(30000);
	
		play.value = 0;
	
		write(fd, (const void *) &play, sizeof(play));

		usleep(5000);
	}

	ioctl(fd, EVIOCRMFF, effect.id);

	close(fd);

	return 0;
}
