From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/6] hid: egalax: Rework to include joojoo support
Date: Fri, 15 Oct 2010 16:37:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010151637050.6879@pobox.suse.cz>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 13 Oct 2010, Henrik Rydberg wrote:

> Hi Jiri, Stephane,
> 
> This series adds support for the joojoo tablet. Based on the
> jikos/egalax branch, the first two patches prepare for the change to
> MT slots. The third patch fixes the bug that was also fixed by commit
> f516611, but in another (agreed) way. The fourth patch fixes another
> minor problem. The fifth patch adds event filtering based on observed
> signal quality, and the sixth patch does the heavy lifting of
> converting to MT slots and thereby solving the major problem for the
> joojoo.
> 
> The patches have been tested on both supported devices. Thanks Philipp!
> 
> Henrik
> 
> Henrik Rydberg (6):
>   hid: egalax: Use kzalloc
>   hid: egalax: Setup input device manually
>   hid: egalax: Correct for device resolution report error
>   hid: egalax: Report zero as minimum pressure
>   hid: egalax: Add event filtering
>   hid: egalax: Convert to MT slots
> 
>  drivers/hid/hid-egalax.c |  177 +++++++++++++++++++++++++++-------------------
>  1 files changed, 103 insertions(+), 74 deletions(-)

Stephane, I'd appreciate if I could get your Acked-by: for the series. 

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
