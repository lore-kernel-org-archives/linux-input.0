From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Power-managing devices that are not of interest at some point
 in time
Date: Wed, 16 Jul 2014 12:00:38 +0200
Message-ID: <1405504838.17757.2.camel@nuvo>
References: <20140716013206.GA13409@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20140716013206.GA13409@google.com>
Sender: linux-pm-owner@vger.kernel.org
To: Patrik Fimml <patrikf@chromium.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dtor@google.com>, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2014-07-15 at 18:32 -0700, Patrik Fimml wrote:
> (Re-sending with correct mailing list addresses.)
> 
> Hi,
> 
> When the lid of a laptop is closed, certain devices can no longer
> provide interesting input or will even produce bogus input, such as:
<snip>
> It's somewhat difficult to get the semantics right, since handles to
> such devices might still be open. It might be easier to implement
> behavior specific to device classes. On the other hand, it would be nice
> to have a uniform way of shutting devices down, and not introduce
> another possible path for a device to enter a power-saving state.
> 
> Rafael, can you give us your opinion on this?

Ditto the "tablet mode" of some devices such as the Thinkpad X41, or the
newer Lenovo Yoga, which should have their keyboards and touchpads
disabled.

If we used something like UPower to enable/disable those inaccessible
devices, we'd need a way of enumerating which devices won't be
accessible in those modes. Turning them off and back on should be easy
enough.

Cheers

