From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: psmouse-alps patches fail on linux-3.2.1
Date: Thu, 19 Jan 2012 09:48:49 -0600
Message-ID: <20120119154849.GA23144@ubuntu-macmini>
References: <CAKanTDcC=MdxEfbE8vRFJ6ucCrBRsaonuJoxPh0iO7+65UB8-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55908 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab2ASPsw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jan 2012 10:48:52 -0500
Content-Disposition: inline
In-Reply-To: <CAKanTDcC=MdxEfbE8vRFJ6ucCrBRsaonuJoxPh0iO7+65UB8-g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ajaxas <ajaxas@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Thu, Jan 19, 2012 at 09:54:30PM +0700, ajaxas wrote:
> Goog evening!
> Could you please check this (confirmed here:
> http://aur.archlinux.org/packages.php?ID=52538<https://aur.archlinux.org/packages.php?ID=52538>
> ).
> 
> The psmouse patches for ALPS touchpads:
> http://people.canonical.com/~sforshee/alps-touchpad/ worked fine with
> linux-3.1.x. Applying the patches to linux-3.2.1, I got these 3 errors:

The patches are now in Linus's tree for 3.3, so you could get them there
and apply them to 3.2, but some backporting work will be required.
Alternately you could get the versions I've already backported to 3.2
for Ubuntu 12.04 from:

  http://kernel.ubuntu.com/git/ubuntu/ubuntu-precise.git

Cheers,
Seth
