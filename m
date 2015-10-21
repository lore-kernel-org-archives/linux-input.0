From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1] HID: fix some indenting issues
Date: Wed, 21 Oct 2015 13:17:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510211316120.21100@pobox.suse.cz>
References: <1444573102-10744-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444573102-10744-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Josenivaldo Benito Junior <jrbenito@benito.qsl.br>, Franco Catrin <fcatrin@gmail.com>, Nikolai Kondrashov <spbnick@gmail.com>, Don Prince <dhprince-devel@yahoo.co.uk>, srinivas pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-input@vger.kernel.org

On Sun, 11 Oct 2015, Jiri Slaby wrote:

> Some drivers indent some lines in a very weird manner. Fix that.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
> Cc: Franco Catrin <fcatrin@gmail.com>
> Cc: Nikolai Kondrashov <spbnick@gmail.com>
> Cc: Don Prince <dhprince-devel@yahoo.co.uk>
> Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>

Some of the are not really worth it per se, but the ones in 
aureal_report_fixup() and sensor_hub_*() are annoying enough to make the 
code harder to read, so I am applying it as a whole.

-- 
Jiri Kosina
SUSE Labs
