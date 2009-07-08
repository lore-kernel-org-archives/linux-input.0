From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Input: mark serio and i8042 as suspended when hibernating too.
Date: Wed, 8 Jul 2009 13:06:55 +0200
Message-ID: <200907081306.56804.rjw@sisk.pl>
References: <1246760019-4120-1-git-send-email-cascardo@holoscopio.com> <200907070040.43299.rjw@sisk.pl> <20090708065435.GF3309@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39661 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbZGHLGh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Jul 2009 07:06:37 -0400
In-Reply-To: <20090708065435.GF3309@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, maciej.rutecki@gmail.com, alan-jenkins@tuffmail.co.uk, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

On Wednesday 08 July 2009, Dmitry Torokhov wrote:
> On Tue, Jul 07, 2009 at 12:40:42AM +0200, Rafael J. Wysocki wrote:
> > On Sunday 05 July 2009, Thadeu Lima de Souza Cascardo wrote:
> > > serio ports are not being restarted any longer because resume operations
> > > after hibernate do nothing, since the device has not been marked as
> > > suspended. This happens because suspend is only considering the SUSPEND
> > > event but not the FREEZE event.
> > > 
> > > Note that this driver has still to migrate to dev_pm_ops, but this fixes
> > > this particular bug now.
> > 
> > Hmm, this looks like a fix for:
> > http://bugzilla.kernel.org/show_bug.cgi?id=13643
> > 
> > Any objections to merging it through the suspend tree?
> > 
> 
> Oops, just applied it to mine before reading your mail... I hope Linus
> will pick my pull request soon so it won't matter thoough.

No problem, I haven't added it to my for-linus branch yet.

Best,
Rafael
