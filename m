From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard - implement Type Clipboard Text
Date: Mon, 18 Aug 2014 03:54:51 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9933040@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1408095719-19117-1-git-send-email-decui@microsoft.com>
 <20140815165733.GB25225@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:3393
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751716AbaHRDzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Aug 2014 23:55:37 -0400
In-Reply-To: <20140815165733.GB25225@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>

> -----Original Message-----
> From: Dmitry Torokhov
> Sent: Saturday, August 16, 2014 0:58 AM
> To: Dexuan Cui
> > For each char in the string, the host sends 2 events (key down/up with the
> > char's UNICODE value) to the guest.
> > The patch finds each char's scan codes of key down/up, and injects the
> > scan codes to the serio keyboard module.
> >
> > Known issues:
> > 1) Only printable ASCII chars are supported, and unsupported chars are
> > ignored. It seems unlikely to support generic UNICODE chars because there
> > is not a generic API to inject a UNICODE char to text mode console, KDE,
> > gnome, etc.
> >
> > 2) When we use the feature, make sure the CapsLock state of the VM's
> > (virtual) keyboard is OFF because this patch assumes it -- we'll try to
> > fix this later, probably by tracking the state of virtual CapsLock, because
> > it looks the keyboard module doesn't supply an API for us to query the
> state
> > of the keyboard.
> >
> No way. If you want to do this this way, do it in hypervisor code and keep
> feeding AT scan codes to hyperv-keyboard, although I am pretty sure users
Hi Dmitry,
Yeah, I had the same wish, but later I found this seems unlikely because IMO
the feature was firstly invented for Windows VM + generic UNICODE chars,
and we know there is no "scan code" for generic UNICODE chars... :-(

> of
> French, Czech and other keyboard layouts with numbers in upper register
> and
> symbols in lower will have a few choice words for you.
Sorry, I can't understand what these are.
Can you please give more details or a link to further info?

> If you want real cut-and-paste support in various DEs I'd recommend
> working
> with VMware on open-vm-tools package to see what can be shared/reused
> there.
> Consider this NACked with prejudice.
> Dmitry
Thanks for the suggestion!
Let me study open-vm-tools and report back.

Thanks,
-- Dexuan
