From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 1/1] elantech: Add support for trackpoint found on
 some v3 models
Date: Thu, 12 Jun 2014 15:13:51 -0700
Message-ID: <20140612221351.GA8983@kroah.com>
References: <20140214205126.GB15526@lantern>
 <1402596901-28784-1-git-send-email-ulrik.debie-os@e2big.org>
 <1402596901-28784-2-git-send-email-ulrik.debie-os@e2big.org>
 <20140612184844.GA25788@kroah.com>
 <20140612190344.GA20952@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140612190344.GA20952@lantern>
Sender: stable-owner@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 12, 2014 at 09:03:45PM +0200, ulrik.debie-os@e2big.org wrote:
> Hi Greg,
> 
> Without this patch the elantech.c driver will still bind to the
> touchpad, and then get out of sync each time the user touches
> the trackpoint or the 3 mouse buttons associated with the trackpoint.
> 
> This out of sync will result in a few dmesg lines and a few lost
> touchpad input events. The fact that the trackpoint + buttons itself
> do not work at all is a minor annoyance compared to the sync loss
> effect on the touchpad events.
> 
> This resulted in multiple bug reports with patches:
> http://tojaj.com/fedora-20-howto-fix-elantech-trackpoint-on-lenovo-thinkpad-l430/
> http://permalink.gmane.org/gmane.linux.kernel.input/27763
> https://bugzilla.kernel.org/show_bug.cgi?id=48161
> 
> Hans suggested me to consider a cc:stable.

Broken hardware is never nice, but as this isn't a regression, and has
never worked, asking to update to a new kernel seems reasonable.

thanks,

greg k-h
