From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] Make appletouch shut up when it has nothing to say
Date: Sun, 13 May 2007 18:58:07 -0700
Message-ID: <20070513185807.18222a0d.zaitcev@redhat.com>
References: <1178995886.4168.10.camel@localhost>
	<20070513172052.GA26712@srcf.ucam.org>
	<20070513114626.d943999a.zaitcev@redhat.com>
	<20070513195724.GA28493@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070513195724.GA28493@srcf.ucam.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, linux-input@atrey.karlin.mff.cuni.cz, nicolas@boichat.ch, linux-usb-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
List-Id: linux-input@vger.kernel.org

On Sun, 13 May 2007 20:57:25 +0100, Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> Ok, I've tidied this up a little. [...]

Looks fine here... well, almost. Did you try rmmod (I don't even know if
it's applicable, sorry)? Usually, when schedule_work is involved, you want
to make sure that a scheduled work won't be run when the module is gone.
More often, a device removal is the issue, but as I take it, such is not
possible for a built-in device :-) . In most cases, all it takes is a
strategically placed flush_scheduled_work().

-- Pete
