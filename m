From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/7] HID: revert the Logitech High Resolution wheel
 support
Date: Wed, 21 Nov 2018 19:46:57 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811211946380.21108@cbobk.fhfr.pm>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 21 Nov 2018, Benjamin Tissoires wrote:

> It turns out that the implementation of the high resolution support of
> Logitech wheels is rather incompatible with the mice from Microsoft.
> 
> We had a lengthy discussion off-list and the summary is quoted in 7/7.
> 
> The TL;DR, we need to revert the current series before it gets out in
> a released kernel and work on a better approach for 4.21.
> 
> This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
> and Peter, but I wouldn't mind a public ack before I push this to
> the for-linus branch.

As discussed previously

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs
