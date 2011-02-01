From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hidraw: fixed hidraw_disconnect()
Date: Tue, 1 Feb 2011 11:21:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102011121110.5725@pobox.suse.cz>
References: <1296263850.2299.11.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296263850.2299.11.camel@neuromancer>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 29 Jan 2011, Stefan Achatz wrote:

> hidraw_disconnect() first sets an entry in hidraw_table to NULL
> and calls device_destroy() afterwards. The thereby called
> hidraw_release() tries to read this already cleared value resulting
> in never removing any device from the list.
> This got fixed by changing the order of events.

Applied, good catch. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
