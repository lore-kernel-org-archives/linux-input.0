From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard - implement Type Clipboard Text
Date: Tue, 19 Aug 2014 08:55:39 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9936FC3@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1408095719-19117-1-git-send-email-decui@microsoft.com>
 <20140815165733.GB25225@core.coreip.homeip.net>
 <EE124450C0AAF944A40DD71E61F878C9933040@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140818185151.GB31121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140818185151.GB31121@core.coreip.homeip.net>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: linux-input@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov
> Sent: Tuesday, August 19, 2014 2:52 AM
> To: Dexuan Cui
> On Mon, Aug 18, 2014 at 03:54:51AM +0000, Dexuan Cui wrote:
> > > -----Original Message-----
> > > From: Dmitry Torokhov
> > > Sent: Saturday, August 16, 2014 0:58 AM
> > > To: Dexuan Cui
> > > > For each char in the string, the host sends 2 events (key down/up with
> the
> > > > char's UNICODE value) to the guest.
> > > > The patch finds each char's scan codes of key down/up, and injects the
> > > > scan codes to the serio keyboard module.
> > > >
> > > No way. If you want to do this this way, do it in hypervisor code and keep
> > > feeding AT scan codes to hyperv-keyboard, although I am pretty sure
> users
> > Hi Dmitry,
> > Yeah, I had the same wish, but later I found this seems unlikely because
> IMO
> > the feature was firstly invented for Windows VM + generic UNICODE chars,
> > and we know there is no "scan code" for generic UNICODE chars... :-(
>
> Do you know what guest is running? You could potentially gate on that.
I'm not sure if the host knows this or not.
But even if the host knows this, IMO it seems bad for the host to discriminate
between Windows guest and Linux guest. And generally there is no scan code
for UNICODE chars.

And, here the patch tries to use a light-weight and straightforward method
to achieve the basic functionality of "Type (host) clipboard text (to guest)" --
the patch doesn't use the guest's X11 clipboard and it works for both text
mode tty and X11 window's input (for English keyboard layout. Please see my
below reply).

I studied open-vm-tools.sourceforge.net and
github.com/vmware/open-vm-tools.
My impression is: it's a pretty big collection of utilities/daemons and its code
seems bound to vmware-specific  features, maybe that's why it's called
"open-vm-tools" rather than "generic-vm-tools" :-)
1)  2517/2528 of the commits of the git repo are from vmware;
2) In Ubuntu 14.04, the utilities of open-vm-tools are just named as
vmware-XXX (I checked this by "dpkg-query -L open-vm-tools");
3) about the text copy&paste functionality between host/guest in either
direction, the implementation of open-vm-tools uses host/guest X11
clipboards and hence doesn't work in real text mode tty terminal, and,
vmware-specific implementation of backdoor() is extensively used -- I
don't think there is such an equivalent in other hypervisors'
environment, AFAIK.

So IMHO it's impractical for me to re-use open-vm-tools here?

> > > of
> > > French, Czech and other keyboard layouts with numbers in upper register
> > > and
> > > symbols in lower will have a few choice words for you.
> > Sorry, I can't understand what these are.
> > Can you please give more details or a link to further info?
>
> On French and many other European layouts to produce a number one
> needs to use
> Shift key, instead of simply using lower register, as on US or UK layouts. I.e.
> if you send scancode for KEY_3 through your proposed implementation it will
> produce '#' and KEY_SHIFT + KEY_3 will result in '3'.
>
> There are also issues with QWERTY/AZERTY and other layouts...
> Dmitry

Hi Dmitry,
Thanks for pointing this out!
This is a real issue -- my patch only works for English layout. :-(

I wrongly assumed  there is a 1:1 mapping between an ASCII char and a
scan code -- this is not true considering different keyboard layouts(keymaps).

So looks it's impossible for me to implement the functionality through the
path of the keyboard input subsystem... :-(
A feasible method would be: I can write a lightweight userland daemon,
just like open-vm-tools, which receives the string from the host and passes it
to the X11 windowing system directly using X11 APIs(this doesn't work in text
mode however).

Looking forward to your comment.

Thanks,
-- Dexuan
