From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] appletouch powersaving - please apply for 2.6.23-rc1
Date: Wed, 18 Jul 2007 15:57:58 -0700
Message-ID: <20070718155758.072db90d.akpm@linux-foundation.org>
References: <1184656218.14051.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1184656218.14051.43.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>, Nicolas Boichat <nicolas@boichat.ch>, Michael Hanselmann <linux-kernel@hansmi.ch>, Peter Osterlund <petero2@telia.com>, Frank Arnold <frank@scirocco-5v-turbo.de>, Stelian Pop <stelian@popies.net>, Johannes Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

On Tue, 17 Jul 2007 09:10:18 +0200
Soeren Sonnenburg <kernel@nn7.de> wrote:

> the attached minimally intrusive patch is based on Matthew Garret's
> patch 'Make appletouch shut up when it has nothing to say' patches (e.g.
> http://lkml.org/lkml/2007/5/13/117): Matthews description follows /
> second paragraph lists my additional changes.
> 
> The appletouch geyser3 devices found in the Intel Macs (and possibly some later 
> PPC ones?) send a constant stream of packets after the first touch. This 
> results in the kernel waking up around once every couple of milliseconds 
> to process them, making it almost impossible to spend any significant 
> period of time in C3 state on a dynamic HZ kernel. Sending the mode 
> initialization code makes the device shut up until it's touched again. 
> This patch does so after receiving 10 packets with no interesting 
> content.
> 
> In addition it now empties the work queue via cancel_work_sync on module
> exit, keeps all error checking and only reports BTN_LEFT presses if bit
> 1 in the status byte (last byte in packet) is set. This fixes the random
> left clicks issue. Furthermore it invalidates touchpad data before the
> mode switch, which fixes the touchpad runs amok issue.

Please feed this through scripts/checkpatch.pl and consider addressing
all the things which it reports.
