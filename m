From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: roccat: fixing actual/startup profile sysfs
 attribute in koneplus
Date: Wed, 18 May 2011 16:34:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105181634360.28291@pobox.suse.cz>
References: <1302444165.12514.2.camel@neuromancer> <1302707872.2252.3.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1302707872.2252.3.camel@neuromancer>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 13 Apr 2011, Stefan Achatz wrote:

> startup_profile and actual_profile didn't work as expected. Also
> as the actual profile is persistent, the distinction between the
> two was ambiguous, so both use the same code now and startup_profile
> has been deprecated. Also the event is now propagated through
> chardev. 

Applied.

-- 
Jiri Kosina
SUSE Labs
