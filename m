From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] hid/hid-sony: get and set Sixaxis bdaddr via sysfs
Date: Wed, 01 Sep 2010 18:41:46 +0100
Message-ID: <1283362906.2361.25.camel@localhost.localdomain>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
	 <1272917756-31098-3-git-send-email-ospite@studenti.unina.it>
	 <1283357874.2361.24.camel@localhost.localdomain>
	 <20100901192854.9370c605.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:59021 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab0IARlx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 13:41:53 -0400
In-Reply-To: <20100901192854.9370c605.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>

On Wed, 2010-09-01 at 19:28 +0200, Antonio Ospite wrote:
> On Wed, 01 Sep 2010 17:17:54 +0100
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > On Mon, 2010-05-03 at 22:15 +0200, Antonio Ospite wrote:
> > > Expose to userspace a simple way to get device bdaddr, and get/set master
> > > bdaddr on Sixaxis controller.
> > > 
> > > Right now userspace softwares which manage pairing the controller with a
> > > bluetooth adapter, rely on libusb and hence have to detach and reattach
> > > usbhid, which is not very nice.
> > > 
> > > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > > ---
> > > 
> > > As said, ideally this should be done with an interface such as hidraw, but its
> > > limitations prevent us from doing it the right way; and I am not going to
> > > touch hidraw myself anytime soon.
> > 
> > Rest looks alright to me. Thanks!
> 
> Bastien, Jiri, this patch can be DISCARDED. The hidraw work from Alan
> Ott (waiting for Marcel to ACK the bluetooth part) will make this kernel
> approach overkill.
> 
> I already have some bluez patches based on Alan's work, but I am waiting
> for the needed changes to land into linus tree before submitting them.
> 
> Sorry for making you wasting some time reviewing this one, I told you on
> IRC it could be discarded, but we know: "IRCs volant, emails manent".

Given the time it took me to review it, it's my own damn fault anyway ;)

