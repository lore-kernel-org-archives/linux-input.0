From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: core: use scnprintf in modalias_show()
Date: Fri, 20 Nov 2015 10:48:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511201048260.20111@pobox.suse.cz>
References: <1447535288-12523-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447535288-12523-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 14 Nov 2015, Rasmus Villemoes wrote:

> scnprintf() exists to provide these semantics, so we might as well use
> it.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to hid.git#for-4.5/core. Thanks,

-- 
Jiri Kosina
SUSE Labs
