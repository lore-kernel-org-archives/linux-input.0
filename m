From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/5] HID: refactored special event handling in Roccat
 Kone
Date: Wed, 19 May 2010 13:56:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005191356200.28092@pobox.suse.cz>
References: <1274200264.2243.4.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52889 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab0ESL4g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 07:56:36 -0400
In-Reply-To: <1274200264.2243.4.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Stephane Chatty <chatty@enac.fr>, wylda@volny.cz, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, Jerome Vidal <jerom3@free.fr>, linux-kernel@vger.kernel.org

On Tue, 18 May 2010, Stefan Achatz wrote:

> >From e550163af2c39c4e7490cd5bf02e44c5dec72d2b Mon Sep 17 00:00:00 2001
> From: Stefan Achatz <erazor_de@users.sourceforge.net>
> Date: Sat, 8 May 2010 17:30:27 +0200
> Subject: [PATCH 4/5] HID: refactored special event handling in Roccat Kone
> 
> As special events are reported along with hid event information all
> events are now processed further by standard handler.
> Also cleaned up this code.

Applied, thanks for the cleanup.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
