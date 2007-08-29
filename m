From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: USB: driver for CM109 chipset
Date: Wed, 29 Aug 2007 10:31:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708291029350.2460@twin.jikos.cz>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
 <46D1CB97.5030000@db.org>  <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
  <Pine.LNX.4.64.0708271143310.2460@twin.jikos.cz>
 <7f45d9390708282238w7174d105i351e81cd19037d14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <7f45d9390708282238w7174d105i351e81cd19037d14@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Shaun Jackman <sjackman@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, 28 Aug 2007, Shaun Jackman wrote:

> > Adding a HID_QUIRK_IGNORE entry to the blacklist is sufficient. Could you
> > please double check that this patched driver really binds to the device?
> Ah, found the problem. The usbhid.ko module was being loaded from the
> initramfs image, not from /lib/modules of my root partition. I updated
> the initramfs image and all is good!

BTW when you are ready with the CM109 driver, please don't forget to send 
me a patch which will add the device to the HID blacklist.

Thanks,

-- 
Jiri Kosina
