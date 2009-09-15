From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: MX5000 support in hid-logitech
Date: Tue, 15 Sep 2009 16:34:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909151632280.17028@wotan.suse.de>
References: <200909151240.14486.corentin.chary@gmail.com> <1253012633.23937.8321.camel@localhost.localdomain> <200909151444.29108.corentin.chary@gmail.com> <200909151552.11811.corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38316 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbZIOOel (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 10:34:41 -0400
In-Reply-To: <200909151552.11811.corentin.chary@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

On Tue, 15 Sep 2009, Corentin Chary wrote:

> In fact .. my first patch works with showkey, not with xev ...
> I'll try to figure out why.

That's unfortunate limitation of X server/protocol -- keycodes higher than 
255 (more than 8 bit) do not reach the usual desktop applications (e.g. 
xev). See http://bugs.freedesktop.org/show_bug.cgi?id=11227 for more 
information.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
