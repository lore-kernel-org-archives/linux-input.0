From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: intel_ish-hid: use %pUL for uuid formatting
Date: Fri, 2 Dec 2016 15:04:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612021504170.29400@cbobk.fhfr.pm>
References: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 30 Nov 2016, Rasmus Villemoes wrote:

> We have the %pU printf extension for doing exactly this. Saves some
> .text, and is likely also a little faster.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
