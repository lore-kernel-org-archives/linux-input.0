From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Wed, 17 Feb 2010 11:17:08 -0800
Message-ID: <20100217191708.GA15554@core.coreip.homeip.net>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com>
 <20100217052247.GD7160@core.coreip.homeip.net>
 <20100217180342.GA22522@srcf.ucam.org>
 <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:56325 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab0BQTRX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 14:17:23 -0500
Content-Disposition: inline
In-Reply-To: <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, johannes@sipsolutions.net, linux-wireless@vger.kernel.org, linux-input@vger.kernel.org, marcel@holtmann.org

On Wed, Feb 17, 2010 at 07:43:56PM +0100, Christian Lamparter wrote:
> On Wed, Feb 17, 2010 at 7:03 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Tue, Feb 16, 2010 at 09:22:47PM -0800, Dmitry Torokhov wrote:
> >
> >> I'd like some breathing room aroung KEY_NUMERIC? Any issues with making
> >> it 247 or 0x211?
> >
> > None. Do you want to make that change, or should I resubmit?
> >
> Wait wait... do you can get another KEY_?
> 
> The reason: Some new devices come with a WPS "Push Button".
> And there's no code for them yet.
> 

Yes, we can add a new key definition if you provide clear description of
what the intended use is and if we can't map such use to any existing
key definitions.

-- 
Dmitry
