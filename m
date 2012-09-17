From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: roccat: conditional blacklisting of Roccat
 modules
Date: Mon, 17 Sep 2012 17:27:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171727430.31149@pobox.suse.cz>
References: <1347890659.2398.1.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347890659.2398.1.camel@neuromancer.tessier-ashpool>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 17 Sep 2012, Stefan Achatz wrote:

> Roccat devices are standard compatible, specific drivers are only needed
> for extended functionality.
> If Roccat drivers are not configured, hid-generic binds these devices now.
> 
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>

Applied, thanks Stefan.

-- 
Jiri Kosina
SUSE Labs
