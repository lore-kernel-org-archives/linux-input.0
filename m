From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/3] thinkpad_acpi: Wire unused micmute LED to capslock
Date: Thu, 22 Aug 2013 16:39:00 +0100
Message-ID: <20130822153900.GA2878@srcf.ucam.org>
References: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
 <1377180132-4933-3-git-send-email-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377180132-4933-3-git-send-email-Jason@zx2c4.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, rjw@sisk.pl, len.brown@intel.com, dtor@insightbb.com
List-Id: linux-input@vger.kernel.org

On Thu, Aug 22, 2013 at 04:02:12PM +0200, Jason A. Donenfeld wrote:
> Thinkpads with a micmute LED do not have a capslock LED. The micmute LED
> is currently not used by any piece of Linux kernel land or user land. It
> seems reasonable to hook it up to caps lock, at least by default, so
> users can have some degree of functionality.

I think there's a risk of user confusion here, in that it's now possible 
for the mic mute light to be lit despite the internal microphone still 
being active. That seems like surprising behaviour.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
