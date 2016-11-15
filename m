From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [patch] HID: wacom: Don't clear bits unintentionally
Date: Tue, 15 Nov 2016 12:13:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611151213200.29400@cbobk.fhfr.pm>
References: <20161110192539.GA32533@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161110192539.GA32533@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 10 Nov 2016, Dan Carpenter wrote:

> This is trying to clear the lower 32 bits but the type is wrong so it
> clears everything.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to for-4.10/wacom/mobile-studio-pro. Thanks,

-- 
Jiri Kosina
SUSE Labs

