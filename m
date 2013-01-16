From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: add support for Sony RF receiver with USB product
 id 0x0374
Date: Wed, 16 Jan 2013 11:44:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301161141250.14768@pobox.suse.cz>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>  <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>  <50F52986.2080002@lab.ntt.co.jp> <1358246448.4897.3.camel@nexus.lab.ntt.co.jp> <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
 <50F637D1.8070302@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50F637D1.8070302@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

On Wed, 16 Jan 2013, Fernando Luis Vazquez Cao wrote:

> I noticed that the patch was tagged "for-3.9". Does this mean
> that it is too late to get it merged during the current release
> cycle?

I currently don't have anything queued for 3.8, and this particular patch 
doesn't justify a separate pull request.

Once it's in Linus' tree, it can be easily pushed out to all existing 
-stable branches (including 3.8-stable, once it's created).

If I am gfoing to be sending pull request for 3.8 to Linus still due to 
some important bugfix, I will be including this.

> If possible, I would like to get it backported to 3.7-stable (and 
> possibly 3.2 stable), since without it a whole family of Sony desktop 
> computers is unusable under Linux out of the box. Should I do it myself 
> or do you have a process in place for HID stable patches?

If the patch had

	Cc: stable@vger.kernel.org

in it, it'd be picked for -stable queue automatically. Otherwise, anyone 
is free to take it once it's in Linus' tree and sent to to 
stable@vger.kernel.org for inclusion.

Hope this helps,

-- 
Jiri Kosina
SUSE Labs
