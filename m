From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] Input: atkbd - add LED triggers for keyboard state
Date: Sun, 22 Sep 2013 16:26:29 +0200
Message-ID: <20130922142629.GA30282@amd.pavel.ucw.cz>
References: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, rjw@sisk.pl, len.brown@intel.com, dtor@insightbb.com
List-Id: linux-input@vger.kernel.org

Hi!

> Many new laptop keyboards aren't shipping with LEDs in the keys for
> caps lock, num lock, and scroll lock. They do, however, ship with many LEDs
> for specialized functions that mostly go non-utilized by any current
> Linux drivers. Having a caps lock LED is very helpful in early boot full
> disk encryption, where a fancy GUI is not available to show that caps
> lock is activated.
> 
> This patch wires in the caps, num, and scroll lock states of the
> keyboard into the generic LED trigger subsystem, so that integrators can
> have different LEDs activated on caps/num/scroll lock state changes.

There's another patch floating around that properly integrates input
with LED subsystem; it already contains this functionality IIRC.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
