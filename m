From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being
 called
Date: Tue, 21 Sep 2010 17:14:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211714400.26813@pobox.suse.cz>
References: <20100812113624.GB1591@arch.tripp.de> <20100812114513.GA1584@arch.tripp.de> <20100812115657.GA1611@arch.tripp.de> <alpine.LNX.2.00.1008121401580.2702@pobox.suse.cz> <alpine.LNX.2.00.1008121457060.2702@pobox.suse.cz> <20100812130411.GA1626@arch.tripp.de>
 <4C63F285.8070801@signal11.us> <20100812164035.GB6761@fritha.org> <20100920181100.GA12295@fancy-poultry.org> <alpine.LNX.2.00.1009211653510.26813@pobox.suse.cz> <20100921150900.GA6801@fritha.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100921150900.GA6801@fritha.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heinz Diehl <htd@fritha.org>
Cc: Heinz Diehl <htd@fancy-poultry.org>, Alan Ott <alan@signal11.us>, Markus Trippelsdorf <markus@trippelsdorf.de>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Sep 2010, Heinz Diehl wrote:

> > Could you perhaps strace apcupsd to see what it is doing before it fails?
> 
> Yes, of course. The output is attached this mail.

strace -f would likely be more helpful.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
