From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/2] HID: roccat: Add support for Arvo, small bugfix and
 a question
Date: Thu, 20 Jan 2011 11:29:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101201129020.29002@pobox.suse.cz>
References: <1294300829.5622.57.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1294300829.5622.57.camel@neuromancer>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 6 Jan 2011, Stefan Achatz wrote:

> This patchset adds support for the Roccat Arvo keyboard.
> The driver is similar to my other roccat drivers.

Applied, thanks for the driver, Stefan.

> I'm now finished implementing new device support and my next step would 
> be to abstract similarities to reduce code duplication.

That would be very welcome.

> Has the resulting file to be a module named like "roccat-common" that 
> has to be selected as depencendy in Kconfig or is there another 
> mechanism to hide this gratuitous decicion from the user?

Yes, I think this would be a reasonable implementation in this case.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
