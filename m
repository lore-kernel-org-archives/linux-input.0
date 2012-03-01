From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Thu, 01 Mar 2012 13:47:54 +0000
Message-ID: <1330609674.2398.18.camel@novo.hadess.net>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
	 <CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
	 <CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33340 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758103Ab2CANsE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 08:48:04 -0500
In-Reply-To: <CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Paris <eparis@parisplace.org>
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, linux-input@vger.kernel.org

On Thu, 2012-03-01 at 08:39 -0500, Eric Paris wrote:
> On Wed, Feb 29, 2012 at 4:37 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> > On Wed, Feb 29, 2012 at 4:00 PM, Eric Paris <eparis@parisplace.org> wrote:
> 
> >> I just got a new Logitech MX5500 bluetooth keyboard mouse combo.  I
> >> had no problem at all getting them recognized and connected using the
> >> built in bluetooth on my Lenovo X200 laptop.  My problem is with the
> >> middle mouse 'button.'  On all of my other mice clicking the scroll
> >> wheel acted as a middle button.  On this new mouse it makes a noise
> >> like a 'click' but it doesn't do anything.  I launched evtest and see
> >> events for everything on the mouse (it has a thumb scroll whell, extra
> >> buttons, all sorts of stuff) but it gives no event for 'click'ing the
> >> scroll wheel. (I do see events for scrolling the scroll wheel)
> ...
> > It has never worked as far as I know. The middle button on the mouse
> > reports as device 0 which the input layer is not expecting. I gave up
> > trying to get it to work.
> >
> > This makes the back button near your thumb work as the middle button:
> > /usr/bin/xinput set-button-map "Logitech MX Revolution Mouse" 1 2 3 4 5 6 2 2
> >
> > I have it in .bashrc but it really should be in a udev script. The
> > mouse occasionally disconnects/reconnect. In udev the command would
> > get automatically reapplied.
> 
> If I run your command by hand it works.  I created a udev rule to try
> to auto-run the command and it does not work.
> 
> ATTR{address}=="00:1F:20:3A:C8:BD", ACTION=="add",
> RUN+="/usr/bin/xinput set-button-map "Logitech MX Revolution Mouse" 1
> 2 3 4 5 6 2 2"
> 
> I know the udev rule is triggered, because when I replaced it with
> /bin/touch /tmp/logitech the file was created in /tmp every time the
> mouse turned on.  Now I'm trying to figure out why it doesn't work as
> a udev rule.  Anyone thoughts?  If not, at least I have one way to get
> it mostly working.  Thanks so much everyone!

I think working on the kernel's fried your brain Eric ;)

xinput needs an X display. udev doesn't know that display. You can
instead use Jon's script with this, if you use GNOME 3:
http://who-t.blogspot.com/2011/03/custom-input-device-configuration-in.html

More examples at:
http://git.gnome.org/browse/gnome-settings-daemon/tree/plugins/common/input-device-example.sh

Cheers

