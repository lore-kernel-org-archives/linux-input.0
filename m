From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 03/16] HID: wiimote: Add drm request
Date: Thu, 28 Jul 2011 20:47:14 +0200
Message-ID: <201107282047.14903.oneukum@suse.de>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com> <201107282005.40226.oneukum@suse.de> <CANq1E4Qui-84C+rDOSnQKvC+BoKWTnZWXOSH=kYtdE0bPB1yCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54918 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab1G1So1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 14:44:27 -0400
In-Reply-To: <CANq1E4Qui-84C+rDOSnQKvC+BoKWTnZWXOSH=kYtdE0bPB1yCA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Donnerstag, 28. Juli 2011, 20:41:18 schrieb David Herrmann:
> On Thu, Jul 28, 2011 at 8:05 PM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Donnerstag, 28. Juli 2011, 18:08:23 schrieb David Herrmann:
> >> +static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
> >> +{
> >> +       __u8 cmd[3];
> >
> > Are you sure these buffers nned not be safe for DMA?
> 
> wiimote_queue() allocates a buffer for every request. This should be
> fine for DMA then. All wiimote_req_*() functions work the same way.
> 

Yes, that's safe.

	Regards
		Oliver
