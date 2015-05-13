From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] HID: usbhid: Add HID_QUIRK_NOGET for Aten DVI KVM switch
Date: Wed, 13 May 2015 14:02:37 +0200
Message-ID: <1431518557.1902.2.camel@suse.com>
References: <1431450000-25236-1-git-send-email-labbott@fedoraproject.org>
	 <alpine.LNX.2.00.1505131324470.8186@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1505131324470.8186@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Laura Abbott <labbott@fedoraproject.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stephane.tranchemer@devinci.fr
List-Id: linux-input@vger.kernel.org

On Wed, 2015-05-13 at 13:25 +0200, Jiri Kosina wrote:
> On Tue, 12 May 2015, Laura Abbott wrote:
> 
> > Like other KVM switches, the Aten DVI KVM switch needs a
> > quirk to avoid spewing errors:
> > 
> > [791759.606542] usb 1-5.4: input irq status -75 received
> > [791759.614537] usb 1-5.4: input irq status -75 received
> > [791759.622542] usb 1-5.4: input irq status -75 received
> > 
> > Add it.
> > 
> > Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> 
> Applied for for-4.1/upstream-fixes, thanks.

Hi,

this should go into stable, too.

	Regards
		Oliver
